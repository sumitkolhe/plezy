import 'dart:async';

import 'package:flutter/material.dart';

import '../../connection/connection.dart';
import '../../exceptions/media_server_exceptions.dart';
import '../../i18n/strings.g.dart';
import '../../navigation/profile_session_screen.dart';
import '../../services/jellyfin_auth_service.dart';
import '../../services/jellyfin_endpoint_discovery.dart';
import '../../services/jellyfin_lan_discovery_service.dart';
import '../../services/storage_service.dart';
import '../../utils/device_identity.dart';
import '../../utils/app_logger.dart';
import '../../utils/navigation_transitions.dart';
import '../settings/connection_persistence.dart';
import 'onboarding_palette.dart';
import 'steps/connect_step.dart';
import 'steps/connected_step.dart';
import 'steps/discover_step.dart';
import 'steps/sign_in_step.dart';
import 'steps/working_step.dart';
import 'widgets/harbor_water.dart';

/// Where the flow is. Two of these are waits rather than pages, but they are
/// steps as far as the user is concerned, so they live in one enum.
enum OnboardingStep { connect, discover, reaching, signIn, signingIn, connected }

/// First run: find a Jellyfin server, sign in, and hand over to the library.
///
/// One screen rather than a stack of routes. The water along the bottom is the
/// argument: it is mounted once here and the steps swap above it, so crossing
/// between them never restarts the animation, and the flow reads as one place
/// you are moving through instead of five pages.
///
/// The dense form on the Connections screen ([AddJellyfinScreen]) stays as it
/// is — that one is for someone who already has the app working and wants a
/// second server. Both commit through [commitJellyfinConnection].
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({
    super.key,
    this.initialErrorMessage,
    @visibleForTesting this.authServiceFactory,
    @visibleForTesting this.lanDiscoveryFactory,
  });

  /// Surfaced when the flow is reached by being signed out rather than by
  /// installing the app.
  final String? initialErrorMessage;

  final Future<JellyfinConnectionAuthService> Function()? authServiceFactory;
  final Future<List<DiscoveredJellyfinServer>> Function()? lanDiscoveryFactory;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final _address = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  OnboardingStep _step = OnboardingStep.connect;

  /// The connect step opens with one button and expands in place. Someone who
  /// taps straight through loses nothing, and nobody meets an empty field
  /// before they have been told what it is for.
  bool _addressExpanded = false;

  String? _error;
  bool _scanning = false;
  List<DiscoveredJellyfinServer> _discovered = const [];

  JellyfinServerInfo? _serverInfo;
  JellyfinEndpointRaceResult? _endpoint;
  bool _quickConnectEnabled = false;
  JellyfinQuickConnectInitiation? _quickConnect;
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
  }

  @override
  void dispose() {
    _quickConnectCancelled = true;
    _address.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
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

  void _to(OnboardingStep step, {String? error}) {
    _generation++;
    setState(() {
      _step = step;
      _error = error;
    });
  }

  // ---- connect ------------------------------------------------------------

  Future<void> _probe(String raw) async {
    final input = JellyfinEndpointDiscovery.buildUserInputCandidates([raw]);
    if (input.probeBaseUrls.isEmpty) {
      setState(() => _error = t.onboarding.addressRequired);
      return;
    }

    final generation = ++_generation;
    setState(() {
      _step = OnboardingStep.reaching;
      _error = null;
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
      setState(() {
        _endpoint = endpoint;
        _serverInfo = endpoint.serverInfo;
        _quickConnectEnabled = quickConnect;
        _step = OnboardingStep.signIn;
      });
    } catch (e) {
      if (!mounted || generation != _generation) return;
      // Straight back to the address, with the reason attached to the field —
      // a dead end here means the address is wrong and that is where the fix is.
      setState(() {
        _step = OnboardingStep.connect;
        _addressExpanded = true;
        _error = e is MediaServerUrlException ? e.message : t.addServer.couldNotReachServer(error: e.toString());
      });
    }
  }

  // ---- discover -----------------------------------------------------------

  Future<void> _scan() async {
    final generation = ++_generation;
    setState(() {
      _step = OnboardingStep.discover;
      _scanning = true;
      _discovered = const [];
      _error = null;
    });
    try {
      final factory = widget.lanDiscoveryFactory;
      final found = factory != null
          ? await factory()
          : await JellyfinLanDiscoveryService().discover(responseWindow: const Duration(milliseconds: 1300));
      if (!mounted || generation != _generation) return;
      setState(() {
        _discovered = found;
        _scanning = false;
      });
    } catch (e, st) {
      appLogger.w('Onboarding LAN discovery failed', error: e, stackTrace: st);
      if (!mounted || generation != _generation) return;
      setState(() => _scanning = false);
    }
  }

  // ---- sign in ------------------------------------------------------------

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
      _step = OnboardingStep.signingIn;
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
        _step = OnboardingStep.signIn;
        _error = e is MediaServerAuthException ? e.message : t.addServer.signInFailed(error: e.toString());
      });
    }
  }

  Future<void> _startQuickConnect() async {
    final info = _serverInfo;
    final endpoint = _endpoint;
    if (info == null || endpoint == null) return;

    final generation = ++_generation;
    final attempt = ++_quickConnectAttempt;
    _quickConnectCancelled = false;
    setState(() => _error = null);
    try {
      final auth = await _auth();
      final storage = await StorageService.getInstance();
      final deviceId = await storage.getOrCreateClientIdentifier();
      final initiation = await auth.initiateQuickConnect(baseUrl: endpoint.activeBaseUrl, deviceId: deviceId);
      if (!mounted || attempt != _quickConnectAttempt) return;
      setState(() => _quickConnect = initiation);

      final connection = await auth.authenticateByQuickConnect(
        baseUrl: endpoint.activeBaseUrl,
        baseUrls: endpoint.baseUrls,
        secret: initiation.secret,
        deviceId: deviceId,
        serverInfo: info,
        shouldCancel: () => _quickConnectCancelled || attempt != _quickConnectAttempt,
      );
      if (!mounted || attempt != _quickConnectAttempt) return;
      setState(() => _quickConnect = null);
      if (connection == null) {
        // A cancel is the user's own doing and needs no message; an expiry does.
        if (!_quickConnectCancelled) setState(() => _error = t.auth.quickConnectExpired);
        return;
      }
      await _commit(connection, generation);
    } catch (e) {
      if (!mounted || attempt != _quickConnectAttempt) return;
      setState(() {
        _quickConnect = null;
        _error = t.addServer.quickConnectFailed(error: e.toString());
      });
    }
  }

  void _cancelQuickConnect() {
    _quickConnectCancelled = true;
    _quickConnectAttempt++;
    setState(() => _quickConnect = null);
  }

  Future<void> _commit(JellyfinConnection connection, int generation) async {
    final failure = await commitJellyfinConnection(context: context, connection: connection, targetProfile: null);
    if (!mounted || generation != _generation) return;
    if (failure != null) {
      setState(() {
        _step = OnboardingStep.signIn;
        _error = failure;
      });
      return;
    }
    setState(() {
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
      backgroundColor: OnboardingPalette.ink,
      // The flow owns its own inset handling per step, and the water must reach
      // the bottom edge.
      body: Stack(
        children: [
          if (_step != OnboardingStep.connected) const Positioned(left: 0, right: 0, bottom: 0, child: HarborWater()),
          Positioned.fill(child: SafeArea(bottom: false, child: _buildStep())),
        ],
      ),
    );
  }

  Widget _buildStep() {
    return switch (_step) {
      OnboardingStep.connect => ConnectStep(
        controller: _address,
        expanded: _addressExpanded,
        error: _error,
        onExpand: () => setState(() => _addressExpanded = true),
        onConnect: () => unawaited(_probe(_address.text)),
        onDiscover: () => unawaited(_scan()),
      ),
      OnboardingStep.discover => DiscoverStep(
        scanning: _scanning,
        servers: _discovered,
        onBack: () => _to(OnboardingStep.connect),
        onRetry: () => unawaited(_scan()),
        onPick: (server) {
          _address.text = server.address;
          unawaited(_probe(server.address));
        },
      ),
      OnboardingStep.reaching => WorkingStep(title: t.onboarding.reaching, detail: _address.text),
      OnboardingStep.signingIn => WorkingStep(title: t.onboarding.signingIn, detail: _serverInfo?.serverName ?? ''),
      OnboardingStep.signIn => SignInStep(
        serverName: _serverInfo?.serverName ?? '',
        serverAddress: _endpoint?.activeBaseUrl ?? _address.text,
        username: _username,
        password: _password,
        error: _error,
        quickConnectEnabled: _quickConnectEnabled,
        quickConnect: _quickConnect,
        onSignIn: () => unawaited(_signIn()),
        onQuickConnect: () => unawaited(_startQuickConnect()),
        onCancelQuickConnect: _cancelQuickConnect,
        onChangeServer: () => _to(OnboardingStep.connect),
      ),
      OnboardingStep.connected => ConnectedStep(
        connection: _connection!,
        address: _endpoint?.activeBaseUrl ?? _address.text,
        onEnter: _enterLibrary,
      ),
    };
  }
}
