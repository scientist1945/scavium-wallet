import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/network_info_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/rpc_status_controller.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/home/application/home_auto_refresh_controller.dart';
import 'package:scavium_wallet/features/home/presentation/widgets/dashboard_balance_card.dart';
import 'package:scavium_wallet/features/home/presentation/widgets/dashboard_recent_activity_card.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/presentation/account_switcher.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final refresh = ref.read(homeAutoRefreshControllerProvider.notifier);
      await refresh.refreshNow();
      refresh.start();
    });
  }

  String _formatLastSwitchAgo(DateTime? dateTime) {
    if (dateTime == null) return 'unknown time';

    final diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    }

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }

    return '${diff.inHours}h ago';
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(homeAutoRefreshControllerProvider);

    final walletState = ref.watch(walletControllerProvider);
    final assetsState = ref.watch(assetsControllerProvider);
    final networkState = ref.watch(networkInfoControllerProvider);
    final historyState = ref.watch(txHistoryControllerProvider);
    final rpcStatusState = ref.watch(rpcStatusControllerProvider);

    final profile = walletState.valueOrNull;
    final rpcService = ref.read(scaviumRpcServiceProvider);

    final address = profile?.activeAccount.address ?? '-';
    final assets = assetsState.valueOrNull;
    final nativeAsset =
        (assets != null && assets.isNotEmpty) ? assets.first : null;

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('SCAVIUM Wallet'),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(homeAutoRefreshControllerProvider.notifier)
                  .refreshNow();
            },
            icon: const Icon(LucideIcons.refreshCw, size: ScavoIconSize.action),
          ),
          IconButton(
            onPressed: () => context.push(RouteNames.settings),
            icon: const Icon(LucideIcons.settings, size: ScavoIconSize.action),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DashboardBalanceCard(nativeAsset: nativeAsset),
          const SizedBox(height: 16),
          ScaviumCard(child: AccountSwitcher(profile: profile)),
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
                  error: (e, _) => Text('Error loading network info: $e'),
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
                  'RPC status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                rpcStatusState.when(
                  data: (status) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active node: ${status.activeRpcName}'),
                        const SizedBox(height: 6),
                        SelectableText(status.activeRpcUrl),
                        const SizedBox(height: 10),
                        if (status.hasRecentFailover) ...[
                          const Text('Recent failover detected'),
                          const SizedBox(height: 6),
                          if (status.lastFailedRpcUrl != null)
                            SelectableText(
                              'Previous failed node: ${status.lastFailedRpcUrl}',
                            ),
                          const SizedBox(height: 6),
                          Text(
                            'Detected ${_formatLastSwitchAgo(status.lastSwitchAt)}',
                          ),
                        ] else ...[
                          const Text('No recent failover detected'),
                        ],
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton(
                            onPressed:
                                () => context.push(RouteNames.rpcDiagnostics),
                            child: const Text('Open RPC diagnostics'),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Text('Loading RPC status...'),
                  error: (e, _) => Text('Error loading RPC status: $e'),
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
                      icon: LucideIcons.arrowUp,
                      onTap: () => context.push(RouteNames.send),
                    ),
                    _QuickAction(
                      title: 'Receive',
                      icon: LucideIcons.arrowDown,
                      onTap: () => context.push(RouteNames.receive),
                    ),
                    _QuickAction(
                      title: 'Assets',
                      icon: LucideIcons.wallet,
                      onTap: () => context.push(RouteNames.assets),
                    ),
                    _QuickAction(
                      title: 'Accounts',
                      icon: LucideIcons.users,
                      onTap: () => context.push(RouteNames.accounts),
                    ),
                    _QuickAction(
                      title: 'History',
                      icon: LucideIcons.receipt,
                      onTap: () => context.push(RouteNames.history),
                    ),
                    _QuickAction(
                      title: 'Copy',
                      icon: LucideIcons.copy,
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
                      icon: LucideIcons.externalLink,
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
          historyState.when(
            data:
                (items) => DashboardRecentActivityCard(
                  entries: items,
                  onOpenActivity: () => context.push(RouteNames.history),
                  onOpenEntry:
                      (entry) => context.push(
                        RouteNames.transactionDetail,
                        extra: entry,
                      ),
                ),
            loading: () => const ScaviumCard(child: Text('Loading history...')),
            error:
                (e, _) =>
                    const ScaviumCard(child: Text('Error loading history')),
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
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(ScavoRadius.interactive),
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(ScavoSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(ScavoRadius.interactive),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.primary,
              size: ScavoIconSize.section,
            ),
            const SizedBox(height: ScavoSpacing.xs),
            Text(title),
          ],
        ),
      ),
    );
  }
}
