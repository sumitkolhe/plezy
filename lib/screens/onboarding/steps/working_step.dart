import 'package:flutter/material.dart';

import '../onboarding_palette.dart';
import '../widgets/harbor_mark.dart';

/// The wait, used for both the probe and the sign-in.
///
/// A sweep rather than a percentage: neither the reachability race nor the
/// authentication call can say how far along it is, and a bar that pretends
/// otherwise is a lie the user catches.
class WorkingStep extends StatelessWidget {
  const WorkingStep({super.key, required this.title, required this.detail});

  final String title;

  /// What is being reached — the address, or the server that answered.
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Clear of the water, which owns the bottom of the screen.
      padding: const EdgeInsets.only(bottom: 190),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HarborMark(size: 96, bob: true),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
              color: OnboardingPalette.text,
            ),
          ),
          const SizedBox(height: 15),
          const _Sweep(),
          if (detail.isNotEmpty) ...[
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Sweep extends StatefulWidget {
  const _Sweep();

  @override
  State<_Sweep> createState() => _SweepState();
}

class _SweepState extends State<_Sweep> with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))
    ..repeat();

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const width = 180.0;
    const barWidth = width * 0.42;
    return SizedBox(
      width: width,
      height: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: OnboardingPalette.text.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(99),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: AnimatedBuilder(
            animation: _sweep,
            builder: (context, child) {
              final eased = Curves.easeInOut.transform(_sweep.value);
              return Align(
                alignment: Alignment(-1 + 2 * eased * (1 + barWidth / width) - barWidth / width, 0),
                child: child,
              );
            },
            child: Container(
              width: barWidth,
              decoration: BoxDecoration(color: OnboardingPalette.blue, borderRadius: BorderRadius.circular(99)),
            ),
          ),
        ),
      ),
    );
  }
}
