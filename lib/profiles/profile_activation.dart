import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../i18n/strings.g.dart';
import '../screens/profile/pin_entry_dialog.dart';
import '../utils/snackbar_helper.dart';
import '../utils/app_logger.dart';
import '../services/system_shelf_service.dart';
import 'active_profile_binder.dart';
import 'active_profile_provider.dart';
import 'profile.dart';

/// How a UI-driven activation attempt ended. `cancelled` (user backed out
/// of a PIN dialog) is not an error and must not surface a failure message.
enum ProfileActivationOutcome { activated, cancelled, failed }

class _ProfileActivationResult {
  const _ProfileActivationResult(this.outcome, {this.rollbackProfile, this.activationGeneration});

  final ProfileActivationOutcome outcome;
  final Profile? rollbackProfile;
  final int? activationGeneration;
}

/// Activate [profile] from a UI surface, prompting for the PIN when the
/// profile is protected. Loops on wrong-PIN entries until the user submits
/// the right PIN or backs out.
///
/// The retry loop uses the shake-on-error pattern — see [showPinEntryDialog].
Future<_ProfileActivationResult> _activateProfileWithPin(BuildContext context, Profile profile) async {
  if (!profile.isPinProtected) {
    return _activateVerifiedProfile(context, profile);
  }

  String? errorMessage;
  while (true) {
    if (!context.mounted) {
      return const _ProfileActivationResult(ProfileActivationOutcome.cancelled);
    }
    final pin = await showPinEntryDialog(context, profile.displayName, errorMessage: errorMessage);
    if (!context.mounted) {
      return const _ProfileActivationResult(ProfileActivationOutcome.cancelled);
    }
    if (pin == null) {
      return const _ProfileActivationResult(ProfileActivationOutcome.cancelled);
    }
    final hash = profile.pinHash;
    if (hash != null && verifyPin(pin, hash)) {
      return _activateVerifiedProfile(context, profile, pin: pin);
    }
    errorMessage = t.profiles.incorrectPinTryAgain;
  }
}

Future<_ProfileActivationResult> _activateVerifiedProfile(BuildContext context, Profile profile, {String? pin}) async {
  final active = context.read<ActiveProfileProvider>();
  final binder = context.read<ActiveProfileBinder>();
  final shelf = SystemShelfService();
  final oldOwner = active.activeId;
  final requestGeneration = active.beginIdentityMutationRequest();
  int? activationGeneration;

  try {
    if (oldOwner != null && oldOwner != profile.id) {
      await shelf.endProfileSession(oldOwner);
      if (!active.isIdentityMutationRequestCurrent(requestGeneration)) {
        return const _ProfileActivationResult(ProfileActivationOutcome.cancelled);
      }
    }

    // Capture the rollback owner only once this verified request has been
    // admitted. Protected-profile verification may have awaited while another
    // profile became authoritative, so anything captured by the UI caller is
    // stale by this point.
    final rollbackProfile = active.active;
    binder.markUserInitiatedActivation(profile.id);
    final activation = active.activate(profile, pin: pin);
    activationGeneration = active.identityMutationGeneration;
    final activated = await activation;
    if (activated) {
      return _ProfileActivationResult(
        ProfileActivationOutcome.activated,
        rollbackProfile: rollbackProfile,
        activationGeneration: activationGeneration,
      );
    }
  } catch (error, stackTrace) {
    final stillCurrent = activationGeneration == null
        ? active.isIdentityMutationRequestCurrent(requestGeneration)
        : active.identityMutationGeneration == activationGeneration;
    if (stillCurrent) {
      appLogger.w('Failed to activate profile ${profile.id}', error: error, stackTrace: stackTrace);
    }
  } finally {
    active.finishIdentityMutationRequest(requestGeneration);
  }

  final stillCurrent = activationGeneration == null
      ? active.isIdentityMutationRequestCurrent(requestGeneration)
      : active.identityMutationGeneration == activationGeneration;
  if (!stillCurrent) {
    return const _ProfileActivationResult(ProfileActivationOutcome.cancelled);
  }

  // Activation may fail or throw while the prior identity is still
  // authoritative. Admit it again, but never replay rows captured before the
  // failed switch.
  if (oldOwner != null && active.activeId == oldOwner) {
    shelf.beginProfileSession(oldOwner);
  }
  return const _ProfileActivationResult(ProfileActivationOutcome.failed);
}

/// Activate [profile] from a UI surface, then wait until the active profile's
/// server/token binding has settled. Shows the standard switch failure message
/// for activation and binding failures — but not for a PIN-dialog cancel,
/// which is the user changing their mind, not an error.
Future<bool> switchProfileFromUi(BuildContext context, Profile profile) async {
  final activeProvider = context.read<ActiveProfileProvider>();
  final binder = context.read<ActiveProfileBinder>();
  final shelf = SystemShelfService();
  final activation = await _activateProfileWithPin(context, profile);
  if (!context.mounted) return false;
  switch (activation.outcome) {
    case ProfileActivationOutcome.cancelled:
      return false;
    case ProfileActivationOutcome.failed:
      showErrorSnackBar(context, t.errors.failedToSwitchProfile(displayName: profile.displayName));
      return false;
    case ProfileActivationOutcome.activated:
      break;
  }

  final previousProfile = activation.rollbackProfile;
  var activationGeneration = activation.activationGeneration;
  if (activationGeneration == null) return false;
  bool isCurrentActivation(String expectedProfileId) =>
      activeProvider.committedIdentityGeneration == activationGeneration &&
      activeProvider.activeId == expectedProfileId;

  if (!isCurrentActivation(profile.id)) return false;
  final bound = await activeProvider.awaitBindingSettle();
  if (!isCurrentActivation(profile.id)) return false;
  if (bound) return true;

  if (previousProfile != null && previousProfile.id != profile.id && isCurrentActivation(profile.id)) {
    final rollbackRequestGeneration = activeProvider.beginIdentityMutationRequest();
    try {
      await shelf.endProfileSession(profile.id);
      if (!isCurrentActivation(profile.id)) return false;

      final rollbackGeneration = await activeProvider.restoreAfterFailedActivation(
        previousProfile,
        expectedActiveId: profile.id,
        expectedCommittedGeneration: activationGeneration,
        requestGeneration: rollbackRequestGeneration,
      );
      if (rollbackGeneration == null) return false;
      activationGeneration = rollbackGeneration;
      if (!isCurrentActivation(previousProfile.id)) return false;

      binder.markUserInitiatedActivation(previousProfile.id);
      final rebind = binder.rebindActive();
      final restored = await activeProvider.awaitBindingSettle();
      if (!isCurrentActivation(previousProfile.id)) {
        await rebind;
        return false;
      }
      await rebind;
      if (!isCurrentActivation(previousProfile.id)) return false;

      if (restored) {
        shelf.beginProfileSession(previousProfile.id);
      }
    } catch (error, stackTrace) {
      appLogger.w(
        'Failed to restore ${previousProfile.id} after profile switch failure',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      activeProvider.finishIdentityMutationRequest(rollbackRequestGeneration);
    }
  }
  if (context.mounted && activeProvider.committedIdentityGeneration == activationGeneration) {
    showErrorSnackBar(context, t.errors.failedToSwitchProfile(displayName: profile.displayName));
  }
  return false;
}

/// Verify [pin] against [profile]'s stored PIN hash *without* activating it.
/// Used by the borrow flow: we need to confirm the user knows the source
/// profile's PIN before letting them copy a connection out of it.
bool verifyProfilePin(Profile profile, String pin) {
  final hash = profile.pinHash;
  if (hash == null || hash.isEmpty) return true;
  return verifyPin(pin, hash);
}
