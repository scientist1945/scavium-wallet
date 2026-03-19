import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/data/token_registry_repository_impl.dart';
import 'package:scavium_wallet/features/assets/data/tx_history_repository_impl.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Settings')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ScaviumCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reset wallet'),
              subtitle: const Text(
                'Delete locally stored wallet, token list and local transaction history.',
              ),
              trailing: const Icon(Icons.delete_outline),
              onTap: () async {
                await ref.read(walletControllerProvider.notifier).resetWallet();
                await ref.read(tokenRegistryRepositoryProvider).saveTokens([]);
                await ref.read(txHistoryRepositoryProvider).clear();

                if (context.mounted) {
                  context.go(RouteNames.walletEntry);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          const ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),
                Text('SCAVIUM Wallet'),
                SizedBox(height: 4),
                Text('Version 0.4.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
