import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/network_info_controller.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletControllerProvider);
    final assetsState = ref.watch(assetsControllerProvider);
    final networkState = ref.watch(networkInfoControllerProvider);
    final historyState = ref.watch(txHistoryControllerProvider);
    final profile = walletState.valueOrNull;
    final rpcService = ref.read(scaviumRpcServiceProvider);

    final address = profile?.account.address ?? '-';
    final nativeAsset = assetsState.valueOrNull?.firstOrNull;

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('SCAVIUM Wallet'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(assetsControllerProvider);
              ref.invalidate(networkInfoControllerProvider);
              ref.invalidate(txHistoryControllerProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => context.push(RouteNames.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Balance'),
                const SizedBox(height: 10),
                Text(
                  nativeAsset == null
                      ? 'Loading...'
                      : '${nativeAsset.displayBalance} ${AppConfig.current.nativeSymbol}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Account: ${profile?.account.name ?? '-'}'),
                const SizedBox(height: 6),
                SelectableText('Address: $address'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Network',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                networkState.when(
                  data:
                      (network) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ChainId: ${network.chainId}'),
                          const SizedBox(height: 6),
                          Text('Latest block: ${network.latestBlock}'),
                          const SizedBox(height: 6),
                          Text('Gas price (wei): ${network.gasPriceWei}'),
                        ],
                      ),
                  loading: () => const Text('Loading network info...'),
                  error: (e, _) => const Text('Error loading network info'),
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
                  'Quick actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _QuickAction(
                      title: 'Send',
                      icon: Icons.arrow_upward,
                      onTap: () => context.push(RouteNames.send),
                    ),
                    _QuickAction(
                      title: 'Receive',
                      icon: Icons.arrow_downward,
                      onTap: () => context.push(RouteNames.receive),
                    ),
                    _QuickAction(
                      title: 'Assets',
                      icon: Icons.account_balance_wallet_outlined,
                      onTap: () => context.push(RouteNames.assets),
                    ),
                    _QuickAction(
                      title: 'History',
                      icon: Icons.receipt_long,
                      onTap: () => context.push(RouteNames.history),
                    ),
                    _QuickAction(
                      title: 'Copy',
                      icon: Icons.copy_outlined,
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: address));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Address copied')),
                          );
                        }
                      },
                    ),
                    _QuickAction(
                      title: 'Explorer',
                      icon: Icons.open_in_new,
                      onTap: () async {
                        final uri = Uri.parse(
                          rpcService.explorerAddressUrl(address),
                        );
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
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
                  'Recent activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                historyState.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Text('No transactions yet');
                    }
                    final recent = items.take(3).toList();
                    return Column(
                      children:
                          recent
                              .map(
                                (e) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text('${e.amountDisplay} ${e.symbol}'),
                                  subtitle: Text(e.toAddress),
                                  trailing: Text(e.status.name),
                                ),
                              )
                              .toList(),
                    );
                  },
                  loading: () => const Text('Loading history...'),
                  error: (e, _) => const Text('Error loading history'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickAction({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [Icon(icon), const SizedBox(height: 10), Text(title)],
        ),
      ),
    );
  }
}
