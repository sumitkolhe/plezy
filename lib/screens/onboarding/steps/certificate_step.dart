import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../theme/mono_tokens.dart';
import '../onboarding_style.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// The one failure that earns its own screen.
///
/// An address nobody answered is reported under the field it was typed into,
/// because the fix is to edit it. A certificate the device refuses is
/// different: the address may be perfectly right, the problem is not something
/// retrying touches, and it is worth saying why at length.
///
/// The design offers `Trust and continue` here. Harbor has no
/// certificate-exception policy anywhere — no bad-certificate callback, no
/// per-host trust store — so a button promising to trust one would do nothing.
/// Rather than ship that, the screen says plainly what is wrong and leads back
/// to the address.
class CertificateStep extends StatelessWidget {
  const CertificateStep({super.key, required this.address, required this.onEditAddress});

  final String address;
  final VoidCallback onEditAddress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
                decoration: BoxDecoration(color: scheme.error.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(Icons.warning_amber_rounded, size: 30, color: scheme.error),
              ),
            ),
            const SizedBox(height: 22),
            Text(t.onboarding.failedCertificateTitle, textAlign: TextAlign.center, style: OnboardingType.headline),
            const SizedBox(height: 10),
            Text(
              t.onboarding.failedCertificateBody,
              textAlign: TextAlign.center,
              style: OnboardingType.body.copyWith(height: 1.55),
            ),
            const SizedBox(height: 24),
            _AddressRow(address: address),
            const SizedBox(height: 22),
            OnboardingButton(label: t.onboarding.editAddress, onPressed: onEditAddress),
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
    final c = tokens(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: c.outline),
          bottom: BorderSide(color: c.outline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Text(t.onboarding.addressLabel, style: TextStyle(fontSize: 13, color: c.textMuted)),
          ),
          Expanded(
            child: Text(
              address,
              style: TextStyle(fontFamily: 'GoogleSansCode', fontSize: 12.5, height: 1.4, color: c.text),
            ),
          ),
        ],
      ),
    );
  }
}
