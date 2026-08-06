import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../connection/connection.dart';
import '../../exceptions/media_server_exceptions.dart';
import '../../i18n/strings.g.dart';
import '../../navigation/profile_session_screen.dart';
import '../../services/jellyfin_auth_service.dart';
import '../../services/jellyfin_endpoint_discovery.dart';
import '../../services/storage_service.dart';
import '../../utils/app_logger.dart';
import '../../utils/device_identity.dart';
import '../../utils/navigation_transitions.dart';
import '../settings/connection_persistence.dart';
import 'onboarding_palette.dart';
import 'steps/connected_step.dart';
import 'steps/certificate_step.dart';
import 'steps/intro_step.dart';
import 'steps/sign_in_step.dart';

/// Where the flow is.
///
/// Waiting is not among them: reaching a server and signing in both happen
/// inside the button that started them, so the form stays on screen and the
/// address stays editable while it works.
enum OnboardingStep { intro, certificateWarning, signIn, connected }

/// First run: name a Jellyfin server, sign in, and hand over to the library.
///
/// One screen rather than a stack of routes — the splash and the connect screen
/// are the same surface morphing, and the rest swap above the same ink.
///
/// Nothing here scans. No traffic leaves the device until the user presses
/// Connect, which is the flow's one privacy claim and worth keeping true.
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({
    super.key,
    this.initialErrorMessage,
    this.startAtSplash = true,
    @visibleForTesting this.authServiceFactory,
    @visibleForTesting this.clipboardReader,
  });

  /// Surfaced when the flow is reached by being signed out rather than by
  /// installing the app.
  final String? initialErrorMessage;

  /// False when the user is already past the splash — being sent back here by a
  /// sign-out should not replay the logo.
  final bool startAtSplash;

  final Future<JellyfinConnectionAuthService> Function()? authServiceFactory;
  final Future<String?> Function()? clipboardReader;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final _address = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  OnboardingStep _step = OnboardingStep.intro;

  /// The intro opens folded to a single button and expands in place. Someone
  /// who taps straight through loses nothing, and nobody meets an empty field
  /// before they have been told what it is for.
  bool _formOpen = false;

  String? _error;
  String? _clipboardOffer;
  bool _obscurePassword = true;

  /// Reaching a server, or authenticating against one.
  bool _busy = false;

  /// Offered only once the wait has run long enough to be worth acknowledging.
  bool _showCancel = false;
  Timer? _cancelTimer;

  SignInMode _signInMode = SignInMode.password;

  /// How long a wait has to last before a way out of it is offered. Sooner
  /// reads as expecting failure.
  static const Duration _cancelAfter = Duration(milliseconds: 1800);

  JellyfinServerInfo? _serverInfo;
  JellyfinEndpointRaceResult? _endpoint;
  bool _quickConnectEnabled = false;
  String? _quickConnectCode;
  bool _quickConnectCancelled = false;
  int _quickConnectAttempt = 0;

  JellyfinConnection? _connection;

  /// Guards every `setState` that follows an await against a step the user has
  /// since navigated away from.
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _error = widget.initialErrorMessage;
    unawaited(_readClipboard());
  }

  @override
  void dispose() {
    _cancelTimer?.cancel();
    _quickConnectCancelled = true;
    _address.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Offer what is already on the clipboard rather than making someone retype
  /// an address they just copied off a dashboard. Only an offer — nothing is
  /// filled in without a tap.
  Future<void> _readClipboard() async {
    try {
      final reader = widget.clipboardReader;
      final text = reader != null ? await reader() : (await Clipboard.getData(Clipboard.kTextPlain))?.text;
      final candidate = text?.trim();
      if (!mounted || candidate == null || candidate.isEmpty || candidate.length > 120) return;
      // Only something shaped like an address is worth offering.
      if (!RegExp(r'^(https?://)?[\w.-]+(:\d+)?/?$').hasMatch(candidate)) return;
      setState(() => _clipboardOffer = candidate);
    } catch (e) {
      appLogger.w('Could not read the clipboard for an address offer', error: e);
    }
  }

  Future<JellyfinConnectionAuthService> _auth() async {
    final factory = widget.authServiceFactory;
    if (factory != null) return factory();
    return JellyfinConnectionAuthService(
      clientName: 'Harbor',
      clientVersion: await resolveJellyfinClientVersion(),
      deviceName: await resolveJellyfinDeviceName(),
    );
  }

  // ---- reaching the server ------------------------------------------------

  Future<void> _probe() async {
    if (_busy) return;
    final input = JellyfinEndpointDiscovery.buildUserInputCandidates([_address.text]);
    if (input.probeBaseUrls.isEmpty) {
      setState(() => _error = t.onboarding.addressRequired);
      return;
    }

    final generation = ++_generation;
    setState(() {
      _busy = true;
      _showCancel = false;
      _error = null;
    });
    _cancelTimer = Timer(_cancelAfter, () {
      if (mounted && _busy) setState(() => _showCancel = true);
    });

    try {
      final auth = await _auth();
      final endpoint = await auth.raceEndpoints(
        input.probeBaseUrls,
        baseUrlsToPersist: input.explicitBaseUrls,
        baseUrlValidationGroups: input.validationBaseUrlGroups,
      );
      final quickConnect = await auth.isQuickConnectEnabled(endpoint.activeBaseUrl);
      if (!mounted || generation != _generation) return;
      _settleWait();
      setState(() {
        _endpoint = endpoint;
        _serverInfo = endpoint.serverInfo;
        _quickConnectEnabled = quickConnect;
        _signInMode = SignInMode.password;
        _step = OnboardingStep.signIn;
      });
    } catch (e) {
      if (!mounted || generation != _generation) return;
      _settleWait();
      // An address nobody answered belongs under the field that holds it —
      // the fix is to edit it, and sending the user to another screen to be
      // told so just puts a page between them and the correction. A rejected
      // certificate is not that: the address may be right, and it needs room
      // to explain itself.
      if (_isCertificateFailure(e)) {
        setState(() => _step = OnboardingStep.certificateWarning);
      } else {
        setState(() => _error = t.onboarding.couldNotReach(address: _address.text.trim()));
      }
    }
  }

  void _settleWait() {
    _cancelTimer?.cancel();
    _busy = false;
    _showCancel = false;
  }

  bool _isCertificateFailure(Object error) {
    final text = error.toString().toLowerCase();
    return text.contains('certificate') || text.contains('handshake');
  }

  void _cancelProbe() {
    _generation++;
    setState(() {
      _settleWait();
      _error = t.onboarding.connectionCancelled;
    });
  }

  void _editAddress() {
    _generation++;
    setState(() {
      _step = OnboardingStep.intro;
      _formOpen = true;
      _error = null;
    });
  }

  // ---- signing in ---------------------------------------------------------

  Future<void> _signIn() async {
    final info = _serverInfo;
    final endpoint = _endpoint;
    if (info == null || endpoint == null) return;
    if (_username.text.trim().isEmpty) {
      setState(() => _error = t.addServer.required);
      return;
    }

    final generation = ++_generation;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final auth = await _auth();
      final storage = await StorageService.getInstance();
      final connection = await auth.authenticateByName(
        baseUrl: endpoint.activeBaseUrl,
        baseUrls: endpoint.baseUrls,
        username: _username.text,
        password: _password.text,
        deviceId: await storage.getOrCreateClientIdentifier(),
        serverInfo: info,
      );
      if (!mounted || generation != _generation) return;
      await _commit(connection, generation);
    } catch (e) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _busy = false;
        _error = e is MediaServerAuthException ? e.message : t.addServer.signInFailed(error: e.toString());
      });
    }
  }

  Future<void> _startQuickConnect() async {
    final info = _serverInfo;
    final endpoint = _endpoint;
    if (info == null || endpoint == null) return;

    final generation = _generation;
    final attempt = ++_quickConnectAttempt;
    _quickConnectCancelled = false;
    setState(() {
      _signInMode = SignInMode.quickConnect;
      _quickConnectCode = null;
      _error = null;
    });
    try {
      final auth = await _auth();
      final storage = await StorageService.getInstance();
      final deviceId = await storage.getOrCreateClientIdentifier();
      final initiation = await auth.initiateQuickConnect(baseUrl: endpoint.activeBaseUrl, deviceId: deviceId);
      if (!mounted || attempt != _quickConnectAttempt) return;
      setState(() => _quickConnectCode = initiation.code);

      final connection = await auth.authenticateByQuickConnect(
        baseUrl: endpoint.activeBaseUrl,
        baseUrls: endpoint.baseUrls,
        secret: initiation.secret,
        deviceId: deviceId,
        serverInfo: info,
        shouldCancel: () => _quickConnectCancelled || attempt != _quickConnectAttempt,
      );
      if (!mounted || attempt != _quickConnectAttempt) return;
      if (connection == null) {
        // A cancel is the user's own doing and needs no message; an expiry does.
        setState(() {
          _quickConnectCode = null;
          if (!_quickConnectCancelled) _error = t.auth.quickConnectExpired;
        });
        return;
      }
      await _commit(connection, generation);
    } catch (e) {
      if (!mounted || attempt != _quickConnectAttempt) return;
      setState(() {
        _quickConnectCode = null;
        _error = t.addServer.quickConnectFailed(error: e.toString());
      });
    }
  }

  void _usePassword() {
    _quickConnectCancelled = true;
    _quickConnectAttempt++;
    setState(() {
      _signInMode = SignInMode.password;
      _quickConnectCode = null;
      _error = null;
    });
  }

  Future<void> _commit(JellyfinConnection connection, int generation) async {
    final failure = await commitJellyfinConnection(context: context, connection: connection, targetProfile: null);
    if (!mounted || generation != _generation) return;
    if (failure != null) {
      setState(() {
        _busy = false;
        _step = OnboardingStep.signIn;
        _error = failure;
      });
      return;
    }
    setState(() {
      _busy = false;
      _connection = connection;
      _step = OnboardingStep.connected;
    });
  }

  void _enterLibrary() {
    unawaited(Navigator.pushReplacement(context, fadeRoute(const ProfileSessionScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingPalette.surface,
      body: SafeArea(bottom: false, child: _buildStep()),
    );
  }

  Widget _buildStep() {
    return switch (_step) {
      OnboardingStep.intro => IntroStep(
        controller: _address,
        formOpen: _formOpen,
        error: _error,
        clipboardOffer: _address.text.trim().isEmpty ? _clipboardOffer : null,
        busy: _busy,
        showCancel: _showCancel,
        startAtSplash: widget.startAtSplash,
        onOpenForm: () => setState(() => _formOpen = true),
        onConnect: () => unawaited(_probe()),
        onCancel: _cancelProbe,
        onPaste: () => setState(() {
          _address.text = _clipboardOffer ?? '';
          _clipboardOffer = null;
          _error = null;
        }),
      ),
      OnboardingStep.certificateWarning => CertificateStep(address: _address.text, onEditAddress: _editAddress),
      OnboardingStep.signIn => SignInStep(
        serverName: _serverInfo?.serverName ?? '',
        mode: _signInMode,
        username: _username,
        password: _password,
        obscurePassword: _obscurePassword,
        error: _error,
        busy: _busy,
        quickConnectEnabled: _quickConnectEnabled,
        quickConnectCode: _quickConnectCode,
        onSignIn: () => unawaited(_signIn()),
        onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
        onUseQuickConnect: () => unawaited(_startQuickConnect()),
        onUsePassword: _usePassword,
      ),
      OnboardingStep.connected => ConnectedStep(connection: _connection!, onEnter: _enterLibrary),
    };
  }
}
