import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/shared/widgets/scavium_logo.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/scavium_secondary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const ScaviumLogo(size: 90),
            const SizedBox(height: 24),
            const Text(
              'Welcome to SCAVIUM Wallet',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'A self-custody wallet for the SCAVIUM ecosystem, designed for security and scale.',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ScaviumPrimaryButton(
              text: 'Continue',
              onPressed: () => context.push(RouteNames.walletEntry),
            ),
            const SizedBox(height: 12),
            ScaviumSecondaryButton(
              text: 'Back',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
