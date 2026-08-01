import 'dart:async';
import 'package:flutter/material.dart';
import '../i18n/strings.g.dart';
import '../focus/focusable_button.dart';
import '../focus/key_event_utils.dart';
import '../media/media_backend.dart';
import '../navigation/profile_session_screen.dart';
import '../utils/navigation_transitions.dart';
import '../widgets/backend_badge.dart';
import 'settings/add_jellyfin_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.initialErrorMessage});

  final String? initialErrorMessage;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _errorMessage = widget.initialErrorMessage;
  }

  Future<void> _connectToJellyfin() async {
    final added = await Navigator.push<bool>(context, MaterialPageRoute(builder: (_) => const AddJellyfinScreen()));
    if (!mounted || added != true) return;
    // The connection persisted and the manager registered the client; move
    // straight to the main screen. [MainScreen] reads the active client
    // from the server provider, so no client argument is needed here.
    unawaited(Navigator.pushReplacement(context, fadeRoute(const ProfileSessionScreen())));
  }

  @override
  Widget build(BuildContext context) {
    // Use two-column layout on desktop, single column on mobile
    final isDesktop = MediaQuery.sizeOf(context).width > 700;

    return Focus(
      canRequestFocus: false,
      onKeyEvent: (_, event) => handleBackKeyNavigation(context, event),
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isDesktop ? 800 : 400),
            padding: const EdgeInsets.all(24),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(child: _buildBranding(context)),
                      const SizedBox(width: 48),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: .min,
                              crossAxisAlignment: .stretch,
                              children: [_buildAuthBody()],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .stretch,
                      children: [_buildBranding(context), const SizedBox(height: 48), _buildAuthBody()],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranding(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        SvgPicture.asset('assets/harbor.svg', width: 120, height: 120),
        const SizedBox(height: 24),
        Text(
          t.app.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: .bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAuthBody() {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        FocusableButton(
          autofocus: true,
          onPressed: _connectToJellyfin,
          useBackgroundFocus: true,
          child: ElevatedButton.icon(
            onPressed: _connectToJellyfin,
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            icon: const BackendBadge(backend: MediaBackend.jellyfin, size: 18),
            label: Text(t.auth.connectToJellyfin),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
