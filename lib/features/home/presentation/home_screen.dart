import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/blockchain/application/native_balance_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/network_info_controller.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _formatBalanceBigInt(BigInt wei) {
    final asDouble = wei / BigInt.from(1000000000000000000);
    return asDouble.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletControllerProvider);
    final balanceState = ref.watch(nativeBalanceControllerProvider);
    final networkState = ref.watch(networkInfoControllerProvider);
    final profile = walletState.valueOrNull;
    final rpcService = ref.read(scaviumRpcServiceProvider);

    final address = profile?.account.address ?? '-';

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('SCAVIUM Wallet'),
        actions: [
          IconButton(
            onPressed: () async {
              ref.invalidate(nativeBalanceControllerProvider);
              ref.invalidate(networkInfoControllerProvider);
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
                balanceState.when(
                  data:
                      (balance) => Text(
                        '${balance.getValueInUnit(EtherUnit.ether).toStringAsFixed(6)} ${AppConfig.current.nativeSymbol}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                  loading:
                      () => const Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                  error:
                      (e, _) => Text(
                        'Error loading balance',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
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
