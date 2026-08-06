import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../onboarding_palette.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// Why a connection did not happen, and what to do about it.
///
/// Two shapes rather than one, because the recoveries differ: an address that
/// nobody answered is worth retrying as-is, while a certificate the device will
/// not trust never will be, however many times you press the button.
enum ConnectionFailure { unreachable, certificate }

/// The failure screen.
///
/// The design offers `Trust and continue` on the certificate variant. Harbor
/// has no certificate-exception policy anywhere — no bad-certificate callback,
/// no per-host trust store — so a button promising to trust one would do
/// nothing. Rather than ship a lie, the certificate variant says plainly that
/// the connection cannot be made and leads to the address instead.
class FailedStep extends StatelessWidget {
  const FailedStep({
    super.key,
    required this.failure,
    required this.address,
    required this.onRetry,
    required this.onEditAddress,
  });

  final ConnectionFailure failure;
  final String address;
  final VoidCallback onRetry;
  final VoidCallback onEditAddress;

  bool get _isCertificate => failure == ConnectionFailure.certificate;

  Color get _tone => _isCertificate ? OnboardingPalette.caution : OnboardingPalette.danger;

  String get _title => _isCertificate ? t.onboarding.failedCertificateTitle : t.onboarding.failedUnreachableTitle;

  String get _body => _isCertificate ? t.onboarding.failedCertificateBody : t.onboarding.failedUnreachableBody;

  @override
  Widget build(BuildContext context) {
    return RiseIn(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(OnboardingMetrics.gutter, 80, OnboardingMetrics.gutter, 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(color: _tone.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(Icons.warning_amber_rounded, size: 30, color: _tone),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              _title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                color: OnboardingPalette.text,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _body,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, height: 1.55, color: OnboardingPalette.textMuted),
            ),
            const SizedBox(height: 24),
            _AddressRow(address: address),
            const SizedBox(height: 22),
            // Retrying a certificate the device rejects only fails again, so
            // that variant leads with the edit instead.
            if (_isCertificate)
              OnboardingButton(label: t.onboarding.editAddress, onPressed: onEditAddress)
            else ...[
              OnboardingButton(label: t.common.retry, onPressed: onRetry),
              const SizedBox(height: 11),
              OnboardingSecondaryButton(label: t.onboarding.editAddress, onPressed: onEditAddress),
            ],
          ],
        ),
      ),
    );
  }
}

/// What was tried, spelled out. Monospaced because it is an address and the
/// difference between two of them is often one character.
class _AddressRow extends StatelessWidget {
  const _AddressRow({required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: OnboardingPalette.hairline),
          bottom: BorderSide(color: OnboardingPalette.hairline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Text(
              t.onboarding.addressLabel,
              style: const TextStyle(fontSize: 13, color: OnboardingPalette.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              address,
              style: const TextStyle(
                fontFamily: 'GoogleSansCode',
                fontSize: 12.5,
                height: 1.4,
                color: OnboardingPalette.textOnFill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
