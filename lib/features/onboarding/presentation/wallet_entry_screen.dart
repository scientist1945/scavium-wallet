import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/scavium_secondary_button.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class WalletEntryScreen extends StatelessWidget {
  const WalletEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Set up your wallet',
              subtitle:
                  'Create a new EVM wallet for SCAVIUM or restore an existing one.',
            ),
            const SizedBox(height: 24),
            ScaviumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create a new wallet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Generate a new recovery phrase and derive your first SCAVIUM account.',
                  ),
                  const SizedBox(height: 16),
                  ScaviumPrimaryButton(
                    text: 'Create wallet',
                    onPressed: () => context.push(RouteNames.createWallet),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ScaviumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Import existing wallet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Restore from a mnemonic phrase or a private key.',
                  ),
                  const SizedBox(height: 16),
                  ScaviumSecondaryButton(
                    text: 'Import wallet',
                    onPressed: () => context.push(RouteNames.importWallet),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
