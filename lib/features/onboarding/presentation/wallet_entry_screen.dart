import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/services/local_storage_service.dart';
import 'package:scavium_wallet/features/onboarding/application/onboarding_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/scavium_secondary_button.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class WalletEntryScreen extends ConsumerWidget {
  const WalletEntryScreen({super.key});

  Future<void> _completeFakeSetup(WidgetRef ref, BuildContext context) async {
    final storage = LocalStorageService();

    await ref.read(onboardingControllerProvider.notifier).completeOnboarding();
    await storage.setBool(StorageKeys.walletCreated, true);

    if (context.mounted) {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaviumScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Set up your wallet',
              subtitle:
                  'For Phase 1, these actions take you through the base app flow. Real wallet generation/import comes next.',
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
                    'Generate a brand-new SCAVIUM wallet with secure backup and account protection.',
                  ),
                  const SizedBox(height: 16),
                  ScaviumPrimaryButton(
                    text: 'Create wallet',
                    onPressed: () => _completeFakeSetup(ref, context),
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
                    'Restore using seed phrase or private key. This is wired as a placeholder in Phase 1.',
                  ),
                  const SizedBox(height: 16),
                  ScaviumSecondaryButton(
                    text: 'Import wallet',
                    onPressed: () => _completeFakeSetup(ref, context),
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
