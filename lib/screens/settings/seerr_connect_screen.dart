import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../focus/focusable_button.dart';
import '../../focus/focusable_text_field.dart';
import '../../i18n/strings.g.dart';
import '../../mixins/controller_disposer_mixin.dart';
import '../../models/seerr/seerr_public_settings.dart';
import '../../models/seerr/seerr_session.dart';
import '../../providers/seerr_account_provider.dart';
import '../../services/seerr/seerr_constants.dart';
import '../../services/seerr/seerr_exceptions.dart';
import '../../theme/mono_tokens.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/focused_scroll_scaffold.dart';
import '../../widgets/loading_indicator_box.dart';
import 'async_form_state_mixin.dart';

/// Which credential form is on screen after the probe.
enum _CredentialForm { none, jellyfin, emby, local }

/// Two-step Seerr connect flow:
///   1. Probe the instance URL (`/settings/public`).
///   2. Sign in with one of the methods the instance supports — one-tap
///      Plex (reusing the profile's stored token), Jellyfin/Emby
///      credentials, or a local Seerr account.
///
/// The finished [SeerrSession] is handed to [SeerrAccountProvider.adoptSession]
/// and the screen pops.
class SeerrConnectScreen extends StatefulWidget {
  const SeerrConnectScreen({super.key});

  @override
  State<SeerrConnectScreen> createState() => _SeerrConnectScreenState();
}

class _SeerrConnectScreenState extends State<SeerrConnectScreen> with AsyncFormStateMixin, ControllerDisposerMixin {
  late final _urlController = createTextEditingController();
  late final _identifierController = createTextEditingController();
  late final _passwordController = createTextEditingController();
  final _urlFocus = FocusNode(debugLabel: 'SeerrConnect:Url');
  final _continueFocus = FocusNode(debugLabel: 'SeerrConnect:Continue');
  final _changeServerFocus = FocusNode(debugLabel: 'SeerrConnect:ChangeServer');
  final _identifierFocus = FocusNode(debugLabel: 'SeerrConnect:Identifier');
  final _passwordFocus = FocusNode(debugLabel: 'SeerrConnect:Password');
  final _formKey = GlobalKey<FormState>();

  SeerrPublicSettings? _instance;
  String _baseUrl = '';
  _CredentialForm _form = _CredentialForm.none;

  @override
  void dispose() {
    _urlFocus.dispose();
    _continueFocus.dispose();
    _changeServerFocus.dispose();
    _identifierFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  _CredentialForm get _mediaServerForm {
    final instance = _instance;
    if (instance == null || !instance.mediaServerLogin) return _CredentialForm.none;
    return switch (instance.mediaServerType) {
      SeerrMediaServerType.jellyfin => _CredentialForm.jellyfin,
      SeerrMediaServerType.emby => _CredentialForm.emby,
      _ => _CredentialForm.none,
    };
  }

  Future<void> _probe() async {
    final input = _urlController.text.trim();
    if (input.isEmpty) {
      setErrorText(t.addServer.required);
      return;
    }
    // Bare hosts are common ("seerr.example.com") — default to https.
    final url = input.contains('://') ? input : 'https://$input';
    await runAsync<void>(() async {
      final account = context.read<SeerrAccountProvider>();
      final settings = await account.authService.probe(url);
      if (!mounted) return;
      setState(() {
        _instance = settings;
        _baseUrl = url;
        // With exactly one credential form on offer, skip the method list.
        final mediaForm = _mediaServerForm;
        if (mediaForm != _CredentialForm.none && !settings.localLogin) {
          _form = mediaForm;
        } else if (mediaForm == _CredentialForm.none && settings.localLogin) {
          _form = _CredentialForm.local;
        } else {
          _form = _CredentialForm.none;
        }
      });
    }, errorMapper: _describeError);
  }

  Future<void> _signInWithCredentials() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final form = _form;
    await runAsync<void>(() async {
      final account = context.read<SeerrAccountProvider>();
      final identifier = _identifierController.text.trim();
      final password = _passwordController.text;
      final session = switch (form) {
        _CredentialForm.jellyfin || _CredentialForm.emby => await account.authService.signInWithJellyfin(
          baseUrl: _baseUrl,
          username: identifier,
          password: password,
          emby: form == _CredentialForm.emby,
        ),
        _CredentialForm.local => await account.authService.signInWithLocal(
          baseUrl: _baseUrl,
          email: identifier,
          password: password,
        ),
        _CredentialForm.none => throw StateError('no credential form selected'),
      };
      await _finish(account, session);
    }, errorMapper: _describeError);
  }

  Future<void> _finish(SeerrAccountProvider account, SeerrSession session) async {
    await account.adoptSession(session.copyWith(instanceLabel: _instance?.instanceLabel));
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  String _describeError(Object e) => switch (e) {
    SeerrUrlException(:final message) => message,
    SeerrAuthException(:final message) => message,
    _ => t.addServer.couldNotReachServer(error: e.toString()),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusedScrollScaffold(
      title: Text(t.seerr.connectTitle),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _instance == null ? _buildUrlStep(theme) : _buildSignInStep(theme),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildUrlStep(ThemeData theme) {
    return [
      FocusableTextFormField(
        controller: _urlController,
        focusNode: _urlFocus,
        autofocus: true,
        tvTextInputAutoOpenBehavior: deferredUrlFieldAutoOpen,
        keyboardType: TextInputType.url,
        autocorrect: false,
        enableSuggestions: false,
        enabled: !busy,
        onNavigateDown: () => _continueFocus.requestFocus(),
        textInputAction: TextInputAction.go,
        onFieldSubmitted: busy ? null : (_) => _probe(),
        decoration: InputDecoration(
          labelText: t.seerr.serverUrl,
          // URL example — intentionally not localized.
          hintText: 'https://seerr.example.com',
          helperText: t.seerr.serverUrlHelper,
          prefixIcon: const AppIcon(PhosphorIcons.link),
        ),
      ),
      const SizedBox(height: 16),
      FocusableButton(
        focusNode: _continueFocus,
        useBackgroundFocus: true,
        onNavigateUp: () => _urlFocus.requestFocus(),
        onPressed: busy ? null : _probe,
        child: FilledButton.icon(
          onPressed: busy ? null : _probe,
          icon: busy ? const LoadingIndicatorBox() : const AppIcon(PhosphorIcons.globe),
          label: Text(t.seerr.checkServer),
        ),
      ),
      ...buildInlineError(theme),
    ];
  }

  List<Widget> _buildSignInStep(ThemeData theme) {
    final instance = _instance!;
    final mediaForm = _mediaServerForm;
    final showLocalOption = instance.localLogin && _form != _CredentialForm.local;
    final showMediaOption = mediaForm != _CredentialForm.none && _form != mediaForm;
    final noMethods = mediaForm == _CredentialForm.none && !instance.localLogin;
    return [
      _buildInstanceCard(theme, instance),
      const SizedBox(height: 16),
      if (noMethods)
        Text(t.seerr.noSignInMethods, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error))
      else ...[
        if (_form != _CredentialForm.none) ..._buildCredentialFields(theme),
        if (showMediaOption)
          _buildMethodButton(
            label: mediaForm == _CredentialForm.emby ? t.seerr.signInWithEmby : t.seerr.signInWithJellyfin,
            onPressed: () => _switchForm(mediaForm),
          ),
        if (showLocalOption)
          _buildMethodButton(label: t.seerr.signInWithLocal, onPressed: () => _switchForm(_CredentialForm.local)),
      ],
      ...buildInlineError(theme),
    ];
  }

  void _switchForm(_CredentialForm form) {
    setState(() {
      _form = form;
      _identifierController.clear();
      _passwordController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _identifierFocus.canRequestFocus) _identifierFocus.requestFocus();
    });
  }

  Widget _buildMethodButton({required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FocusableButton(
        useBackgroundFocus: true,
        onPressed: busy ? null : onPressed,
        child: OutlinedButton(onPressed: busy ? null : onPressed, child: Text(label)),
      ),
    );
  }

  List<Widget> _buildCredentialFields(ThemeData theme) {
    final isLocal = _form == _CredentialForm.local;
    return [
      FocusableTextFormField(
        controller: _identifierController,
        focusNode: _identifierFocus,
        autocorrect: false,
        enableSuggestions: false,
        enabled: !busy,
        keyboardType: isLocal ? TextInputType.emailAddress : TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: busy ? null : (_) => _passwordFocus.requestFocus(),
        decoration: InputDecoration(
          labelText: isLocal ? t.seerr.email : t.addServer.username,
          prefixIcon: AppIcon(isLocal ? PhosphorIcons.envelope : PhosphorIcons.person),
        ),
        validator: (v) => v == null || v.trim().isEmpty ? t.addServer.required : null,
      ),
      const SizedBox(height: 12),
      FocusableTextFormField(
        controller: _passwordController,
        focusNode: _passwordFocus,
        obscureText: true,
        enabled: !busy,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: busy ? null : (_) => _signInWithCredentials(),
        decoration: InputDecoration(labelText: t.addServer.password, prefixIcon: const AppIcon(PhosphorIcons.lock)),
        validator: (v) => v == null || v.isEmpty ? t.addServer.required : null,
      ),
      const SizedBox(height: 16),
      FocusableButton(
        useBackgroundFocus: true,
        onPressed: busy ? null : _signInWithCredentials,
        child: FilledButton.icon(
          onPressed: busy ? null : _signInWithCredentials,
          icon: busy ? const LoadingIndicatorBox() : const AppIcon(PhosphorIcons.signIn),
          label: Text(t.addServer.signIn),
        ),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _buildInstanceCard(ThemeData theme, SeerrPublicSettings instance) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(tokens(context).radiusMd),
      ),
      child: Row(
        children: [
          const AppIcon(PhosphorIcons.cloudCheck),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(instance.instanceLabel, style: theme.textTheme.titleSmall),
                Text(
                  _baseUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
          FocusableButton(
            focusNode: _changeServerFocus,
            useBackgroundFocus: true,
            onPressed: busy ? null : _resetToUrlStep,
            child: TextButton(onPressed: busy ? null : _resetToUrlStep, child: Text(t.addServer.change)),
          ),
        ],
      ),
    );
  }

  void _resetToUrlStep() {
    setState(() {
      _instance = null;
      _form = _CredentialForm.none;
      _identifierController.clear();
      _passwordController.clear();
    });
  }
}
