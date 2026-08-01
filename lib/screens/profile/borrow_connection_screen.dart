import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../connection/connection.dart';
import '../../connection/connection_registry.dart';
import '../../focus/focusable_wrapper.dart';
import '../../i18n/strings.g.dart';
import '../../profiles/active_profile_binder.dart';
import '../../profiles/profile.dart';
import '../../profiles/profile_activation.dart';
import '../../profiles/profile_connection.dart';
import '../../profiles/profile_connection_registry.dart';
import '../../profiles/profile_merge.dart';
import '../../profiles/profile_registry.dart';
import '../../services/storage_service.dart';
import '../../theme/mono_tokens.dart';
import '../../utils/app_logger.dart';
import '../../utils/snackbar_helper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/backend_badge.dart';
import '../../widgets/loading_indicator_box.dart';
import '../../widgets/focused_scroll_scaffold.dart';
import '../libraries/state_messages.dart';
import 'pin_entry_dialog.dart';

/// Pick a connection from another profile and attach it to [targetProfile]
/// as an independent copy.
///
/// For each candidate (sourceProfile, profileConnection):
/// 1. If the source profile is PIN-protected (local kind), prompt for its
///    PIN and verify locally before revealing the borrow action.
/// 2. For Plex sources: call `/home/users/{uuid}/switch` from the parent
///    account token with the source's `userIdentifier` and (if the target
///    Home user is `protected`) the Home PIN. The borrower gets its own
///    fresh user-token.
/// 3. For Jellyfin sources: copy the existing `userToken` (one user per
///    Jellyfin connection).
class BorrowConnectionScreen extends StatefulWidget {
  final Profile targetProfile;
  final bool popOnSuccess;

  const BorrowConnectionScreen({super.key, required this.targetProfile, this.popOnSuccess = false});

  @override
  State<BorrowConnectionScreen> createState() => _BorrowConnectionScreenState();
}

class _BorrowConnectionScreenState extends State<BorrowConnectionScreen> {
  late Future<List<_BorrowCandidate>> _candidatesFuture;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _candidatesFuture = _loadCandidates();
  }

  void _retryCandidates() {
    setState(() {
      _candidatesFuture = _loadCandidates();
    });
  }

  Future<List<_BorrowCandidate>> _loadCandidates() async {
    try {
      return await _loadCandidatesUnchecked();
    } catch (error, stackTrace) {
      appLogger.w('Borrow candidate load failed', error: error, stackTrace: stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<_BorrowCandidate>> _loadCandidatesUnchecked() async {
    final pcRegistry = context.read<ProfileConnectionRegistry>();
    final connRegistry = context.read<ConnectionRegistry>();
    final profileRegistry = context.read<ProfileRegistry>();
    final results = await Future.wait([
      pcRegistry.listAll(),
      connRegistry.list(),
      profileRegistry.list(),
      StorageService.getInstance(),
    ]);
    final allPcs = results.first as List<ProfileConnection>;
    final allConns = results[1] as List<Connection>;
    final localProfiles = results[2] as List<Profile>;
    final storage = results[3] as StorageService;
    final connById = {for (final c in allConns) c.id: c};
    final allProfiles = hydrateProfiles(locals: localProfiles, storage: storage);

    // What does the target already have? Skip duplicates by connection id.
    final targetConnIds = allPcs
        .where((pc) => pc.profileId == widget.targetProfile.id)
        .map((pc) => pc.connectionId)
        .toSet();
    final out = <_BorrowCandidate>[];
    final seen = <String>{};

    // Dedup by the *thing being borrowed* — (connection, user) — not the
    // source profile. If two profiles already borrowed the same Home user,
    // the borrow operation is identical regardless of which one the picker
    // points at; showing both is just clutter.
    String key(String connId, String userId) => '$connId/$userId';

    // Pass 2: persisted ProfileConnection rows from any other profile
    // (local profiles' own connections + already-borrowed rows on plex_home
    // profiles). Skipped when (conn, user) already surfaced via pass 1.
    for (final pc in allPcs) {
      if (pc.profileId == widget.targetProfile.id) continue;
      if (targetConnIds.contains(pc.connectionId)) continue;
      final conn = connById[pc.connectionId];
      if (conn == null) continue;
      final source = allProfiles.firstWhere(
        (p) => p.id == pc.profileId,
        orElse: () => widget.targetProfile, // sentinel — skipped below
      );
      if (source.id == widget.targetProfile.id) continue;
      if (!seen.add(key(conn.id, pc.userIdentifier))) continue;
      out.add(_BorrowCandidate(source: source, pc: pc, connection: conn));
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_BorrowCandidate>>(
      future: _candidatesFuture,
      builder: (context, snapshot) {
        late final Widget candidateSliver;
        if (snapshot.connectionState != ConnectionState.done) {
          candidateSliver = LoadingIndicatorBox.sliver;
        } else if (snapshot.hasError) {
          candidateSliver = SliverFillRemaining(
            child: ErrorStateWidget(
              message: t.profiles.borrowLoadFailed,
              onRetry: _retryCandidates,
              actionAutofocus: true,
              actionUseBackgroundFocus: true,
            ),
          );
        } else {
          final candidates = snapshot.requireData;
          if (candidates.isEmpty) {
            candidateSliver = SliverFillRemaining(
              child: EmptyStateWidget(
                message: t.profiles.borrowEmpty,
                subtitle: t.profiles.borrowEmptySubtitle,
                icon: Symbols.share_rounded,
                iconSize: 48,
              ),
            );
          } else {
            candidateSliver = SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final cand = candidates[index];
                final tokensRef = tokens(context);
                final tileRadii = groupItemRadii(context, index, candidates.length);
                return Padding(
                  padding: EdgeInsets.fromLTRB(16, index == 0 ? 4 : tokensRef.groupGap, 16, 0),
                  child: FocusableWrapper(
                    autofocus: index == 0,
                    disableScale: true,
                    borderRadii: tileRadii,
                    onSelect: _busy ? null : () => _borrow(cand),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: tileRadii),
                      clipBehavior: Clip.antiAlias,
                      child: _BorrowTile(candidate: cand, borderRadius: tileRadii, onTap: () => _borrow(cand)),
                    ),
                  ),
                );
              }, childCount: candidates.length),
            );
          }
        }

        return FocusedScrollScaffold(
          title: Text(t.profiles.borrowAddTo(displayName: widget.targetProfile.displayName)),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              sliver: SliverToBoxAdapter(
                child: Text(t.profiles.borrowExplain, style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            candidateSliver,
          ],
        );
      },
    );
  }

  Future<void> _borrow(_BorrowCandidate cand) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (!await _verifySourcePin(cand)) return;
      await _borrowJellyfin(cand);
    } catch (e, st) {
      // Without this, a throw from the verify/borrow steps (network, DB)
      // dies in the unawaited caller and the user gets no feedback.
      appLogger.w('Borrow failed', error: e, stackTrace: st);
      if (mounted) {
        showErrorSnackBar(context, t.profiles.borrowFailed);
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _candidatesFuture = _loadCandidates();
        });
      }
    }
  }

  /// Verify the source profile's PIN if it has one.
  Future<bool> _verifySourcePin(_BorrowCandidate cand) async {
    if (!cand.source.isPinProtected) return true;
    final pin = await showPinEntryDialog(context, cand.source.displayName);
    if (pin == null) return false;
    if (!verifyProfilePin(cand.source, pin)) {
      if (!mounted) return false;
      showErrorSnackBar(context, t.profiles.incorrectPin);
      return false;
    }
    return true;
  }

  Future<void> _borrowJellyfin(_BorrowCandidate cand) async {
    final jelly = cand.connection as JellyfinConnection;
    final pcRegistry = context.read<ProfileConnectionRegistry>();
    await pcRegistry.upsert(
      ProfileConnection(
        profileId: widget.targetProfile.id,
        connectionId: jelly.id,
        userToken: cand.pc.hasToken ? cand.pc.userToken : jelly.accessToken,
        userIdentifier: cand.pc.userIdentifier.isNotEmpty ? cand.pc.userIdentifier : jelly.userId,
        tokenAcquiredAt: DateTime.now(),
      ),
    );
    _finishBorrow();
  }

  /// Shared tail of every successful borrow: rebind the target profile when
  /// it is the active one, then pop with the result or confirm in place.
  void _finishBorrow() {
    if (!mounted) return;
    unawaited(context.read<ActiveProfileBinder>().rebindIfActive(widget.targetProfile.id));
    if (widget.popOnSuccess) {
      Navigator.of(context).pop(true);
      return;
    }
    showSuccessSnackBar(context, t.profiles.borrowConnectionBorrowed);
  }
}

class _BorrowCandidate {
  final Profile source;
  final ProfileConnection pc;
  final Connection connection;

  const _BorrowCandidate({required this.source, required this.pc, required this.connection});

  String get connectionLabel => connection.displayLabel;
}

class _BorrowTile extends StatelessWidget {
  final _BorrowCandidate candidate;
  final BorderRadius borderRadius;
  final VoidCallback onTap;

  const _BorrowTile({required this.candidate, required this.borderRadius, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      canRequestFocus: false,
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            BackendBadge(backend: candidate.connection.backend, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Text(candidate.connectionLabel, style: theme.textTheme.titleMedium, overflow: .ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        t.profiles.borrowFromProfile(displayName: candidate.source.displayName),
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                      if (candidate.source.isPinProtected) ...[
                        const SizedBox(width: 6),
                        AppIcon(Symbols.lock_rounded, fill: 1, size: 12, color: theme.colorScheme.onSurfaceVariant),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Padding(padding: .only(left: 8, top: 4), child: AppIcon(Symbols.add_rounded, fill: 1)),
          ],
        ),
      ),
    );
  }
}
