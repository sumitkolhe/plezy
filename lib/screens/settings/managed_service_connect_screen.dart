import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../focus/focusable_button.dart';
import '../../focus/focusable_text_field.dart';
import '../../i18n/strings.g.dart';
import '../../mixins/controller_disposer_mixin.dart';
import '../../models/arr/managed_service.dart';
import '../../providers/managed_services_provider.dart';
import '../../services/arr/managed_service_exceptions.dart';
import '../../theme/mono_tokens.dart';
import '../../widgets/focused_scroll_scaffold.dart';
import '../../widgets/loading_indicator_box.dart';
import 'async_form_state_mixin.dart';
import 'managed_service_labels.dart';

/// Add or re-key one instance. Saving probes first, so a wrong key or port is
/// reported here rather than becoming a row that never loads.
class ManagedServiceConnectScreen extends StatefulWidget {
  final ManagedServiceKind kind;

  /// Re-keying an existing instance; its address is fixed, since changing that
  /// would make a different connection.
  final ManagedServiceConnection? existing;

  const ManagedServiceConnectScreen({super.key, required this.kind, this.existing});

  @override
  State<ManagedServiceConnectScreen> createState() => _ManagedServiceConnectScreenState();
}

class _ManagedServiceConnectScreenState extends State<ManagedServiceConnectScreen>
    with AsyncFormStateMixin, ControllerDisposerMixin {
  late final _addressController = createTextEditingController(text: widget.existing?.baseUrl ?? '');
  late final _secretController = createTextEditingController(text: widget.existing?.secret ?? '');
  late final _usernameController = createTextEditingController(text: widget.existing?.username ?? '');
  late final _nameController = createTextEditingController(text: widget.existing?.name ?? '');

  final _addressFocus = FocusNode(debugLabel: 'ManagedServiceConnect:Address');
  final _secretFocus = FocusNode(debugLabel: 'ManagedServiceConnect:Secret');
  final _usernameFocus = FocusNode(debugLabel: 'ManagedServiceConnect:Username');
  final _nameFocus = FocusNode(debugLabel: 'ManagedServiceConnect:Name');
  final _submitFocus = FocusNode(debugLabel: 'ManagedServiceConnect:Submit');

  @override
  void dispose() {
    _addressFocus.dispose();
    _secretFocus.dispose();
    _usernameFocus.dispose();
    _nameFocus.dispose();
    _submitFocus.dispose();
    super.dispose();
  }

  bool get _usesApiKey => widget.kind.apiKeyAuth;
  String get _serviceName => managedServiceName(widget.kind);

  Future<void> _submit() async {
    final address = _addressController.text.trim();
    if (address.isEmpty) return setErrorText(t.managedServices.addressRequired);
    if (_usesApiKey && _secretController.text.trim().isEmpty) {
      return setErrorText(t.managedServices.apiKeyRequired);
    }
    if (!_usesApiKey && _usernameController.text.trim().isEmpty) {
      return setErrorText(t.managedServices.usernameRequired);
    }

    final provider = context.read<ManagedServicesProvider>();
    await runAsync(() async {
      await provider.connect(
        ManagedServiceConnection(
          kind: widget.kind,
          baseUrl: address,
          username: _usesApiKey ? '' : _usernameController.text.trim(),
          secret: _secretController.text.trim(),
          name: _nameController.text.trim(),
        ),
      );
      if (mounted) Navigator.of(context).pop();
    }, errorMapper: _describeFailure);
  }

  String _describeFailure(Object error) {
    if (error is ManagedServiceAuthException) {
      return _usesApiKey ? t.managedServices.keyRejected(service: _serviceName) : t.managedServices.loginRejected;
    }
    if (error is ManagedServiceApiException) {
      return t.managedServices.notThisService(service: _serviceName);
    }
    return t.managedServices.notReachable(address: _addressController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokensRef = tokens(context);

    return FocusedScrollScaffold(
      title: Text(widget.existing == null ? t.managedServices.addTitle : _serviceName),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    _serviceName,
                    style: TextStyle(fontSize: 20, fontWeight: .w700, color: tokensRef.text),
                  ),
                  const SizedBox(height: 20),

                  FocusableTextField(
                    controller: _addressController,
                    focusNode: _addressFocus,
                    autofocus: widget.existing == null,
                    enabled: !busy && widget.existing == null,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: t.managedServices.addressLabel,
                      hintText: t.managedServices.addressHint,
                    ),
                    onSubmitted: (_) => (_usesApiKey ? _secretFocus : _usernameFocus).requestFocus(),
                  ),
                  const SizedBox(height: 16),

                  if (_usesApiKey) ...[
                    FocusableTextField(
                      controller: _secretController,
                      focusNode: _secretFocus,
                      enabled: !busy,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: t.managedServices.apiKeyLabel,
                        helperText: t.managedServices.apiKeyHelp(service: _serviceName),
                        helperMaxLines: 2,
                      ),
                      onSubmitted: (_) => _nameFocus.requestFocus(),
                    ),
                  ] else ...[
                    FocusableTextField(
                      controller: _usernameController,
                      focusNode: _usernameFocus,
                      enabled: !busy,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: t.managedServices.usernameLabel),
                      onSubmitted: (_) => _secretFocus.requestFocus(),
                    ),
                    const SizedBox(height: 16),
                    FocusableTextField(
                      controller: _secretController,
                      focusNode: _secretFocus,
                      enabled: !busy,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: t.managedServices.passwordLabel),
                      onSubmitted: (_) => _nameFocus.requestFocus(),
                    ),
                  ],
                  const SizedBox(height: 16),

                  FocusableTextField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    enabled: !busy,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: t.managedServices.nameLabel,
                      hintText: t.managedServices.nameHint,
                      helperText: t.managedServices.nameHelp,
                      helperMaxLines: 2,
                    ),
                    onSubmitted: (_) => _submit(),
                  ),

                  ...buildInlineError(theme, gap: 16),
                  const SizedBox(height: 24),

                  SizedBox(
                    height: 48,
                    child: FocusableButton(
                      focusNode: _submitFocus,
                      useBackgroundFocus: true,
                      onPressed: busy ? null : _submit,
                      child: FilledButton(
                        onPressed: busy ? null : _submit,
                        child: busy
                            ? const LoadingIndicatorBox()
                            : Text(widget.existing == null ? t.managedServices.connect : t.managedServices.save),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
