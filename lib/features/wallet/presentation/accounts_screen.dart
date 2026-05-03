import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/presentation/account_switcher.dart';
import 'package:scavium_wallet/shared/widgets/feedback/state_message.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Accounts')),
      child: walletState.when(
        data: (profile) {
          if (profile == null) {
            return const StateMessage(
              icon: LucideIcons.wallet,
              title: 'No wallet loaded',
              subtitle: 'Create or import a wallet before managing accounts.',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Wallet accounts',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select the active account used by balances, assets, activity, and signing. Backup and restore behavior stays wallet-owned.',
              ),
              const SizedBox(height: 16),
              ScaviumCard(child: AccountSwitcher(profile: profile)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => StateMessage(
              icon: LucideIcons.alertCircle,
              title: 'Error loading accounts',
              subtitle: '$error',
            ),
      ),
    );
  }
}
