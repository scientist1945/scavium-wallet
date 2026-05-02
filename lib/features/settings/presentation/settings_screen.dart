import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/app_identity/app_version_provider.dart';
import 'package:scavium_wallet/features/assets/data/token_registry_repository_impl.dart';
import 'package:scavium_wallet/features/assets/data/tx_history_repository_impl.dart';
import 'package:scavium_wallet/features/settings/presentation/export_backup_screen.dart';
import 'package:scavium_wallet/features/settings/presentation/widgets/settings_section_card.dart';
import 'package:scavium_wallet/features/settings/presentation/widgets/theme_mode_selector.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/feedback/confirm_dialog.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final appVersionState = ref.watch(appVersionInfoProvider);
    final appVersionLabel = appVersionState.maybeWhen(
      data: (version) => version.displayLabel,
      orElse: () => 'Version unavailable',
    );

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Settings')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SettingsSectionCard(
            title: 'Appearance',
            icon: Icons.palette_outlined,
            subtitle: 'Choose how SCAVIUM Wallet follows your device display.',
            children: [ThemeModeSelector()],
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            title: 'Security & recovery',
            icon: Icons.shield_outlined,
            subtitle:
                'Export recovery material only when you are ready to store it securely.',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Export encrypted backup'),
                subtitle: const Text(
                  'Create a password-protected backup file that can be used to restore this wallet later.',
                ),
                trailing: const Icon(Icons.download_outlined),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ExportBackupScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            title: 'Signing',
            icon: Icons.edit_note_outlined,
            subtitle:
                'Signing proves account control without submitting a transaction.',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sign message'),
                subtitle: const Text(
                  'Sign a message or challenge with the active account without sending a transaction.',
                ),
                trailing: const Icon(Icons.draw_outlined),
                onTap: () => context.push(RouteNames.signing),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            title: 'Diagnostics',
            icon: Icons.monitor_heart_outlined,
            subtitle: 'Inspect network health without changing wallet data.',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('RPC diagnostics'),
                subtitle: const Text(
                  'Inspect active RPC node, ping endpoints and switch the active node manually.',
                ),
                trailing: const Icon(Icons.router_outlined),
                onTap: () => context.push(RouteNames.rpcDiagnostics),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            title: 'Danger zone',
            icon: Icons.warning_amber_outlined,
            iconColor: colorScheme.error,
            subtitle: 'Destructive actions require explicit confirmation.',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Reset wallet'),
                subtitle: const Text(
                  'Delete locally stored wallet, token list and local transaction history.',
                ),
                trailing: const Icon(Icons.delete_outline),
                onTap: () async {
                  await showDialog<void>(
                    context: context,
                    builder:
                        (context) => ConfirmDialog(
                          title: 'Reset wallet',
                          message:
                              'This will remove wallet data from this device. Make sure you backed up your recovery phrase or exported an encrypted backup.',
                          confirmText: 'Reset',
                          destructive: true,
                          onConfirm: () async {
                            await ref
                                .read(walletControllerProvider.notifier)
                                .resetWallet();
                            await ref
                                .read(tokenRegistryRepositoryProvider)
                                .saveTokens([]);
                            await ref.read(txHistoryRepositoryProvider).clear();

                            if (context.mounted) {
                              AppSnackbar.showInfo(
                                context,
                                'Wallet reset completed',
                              );
                              context.go(RouteNames.walletEntry);
                            }
                          },
                        ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsSectionCard(
            title: 'About',
            icon: Icons.info_outline,
            subtitle: 'App identity and installed build information.',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('SCAVIUM Wallet'),
                subtitle: Text('Installed version: $appVersionLabel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
