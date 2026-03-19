import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const SectionTitle(
              title: 'Your gateway to the SCAVIUM network',
              subtitle:
                  'Secure self-custody wallet for SCAVIUM, built on an EVM-compatible network.',
            ),
            const SizedBox(height: 24),
            const _FeaturePoint(text: 'Create or import your wallet'),
            const _FeaturePoint(text: 'Manage SCAVIUM and EVM tokens'),
            const _FeaturePoint(text: 'Send, receive and track transactions'),
            const _FeaturePoint(
              text: 'Protect access with lock and biometrics',
            ),
            const Spacer(),
            ScaviumPrimaryButton(
              text: 'Get started',
              onPressed: () => context.push(RouteNames.welcome),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _FeaturePoint extends StatelessWidget {
  final String text;
  const _FeaturePoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
