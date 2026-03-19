import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/security/screenshot_guard.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class BackupMnemonicScreen extends ConsumerStatefulWidget {
  const BackupMnemonicScreen({super.key});

  @override
  ConsumerState<BackupMnemonicScreen> createState() =>
      _BackupMnemonicScreenState();
}

class _BackupMnemonicScreenState extends ConsumerState<BackupMnemonicScreen> {
  @override
  void initState() {
    super.initState();
    ScreenshotGuard.enableProtection();
  }

  @override
  void dispose() {
    ScreenshotGuard.disableProtection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ref.read(walletControllerProvider.notifier).readMnemonic(),
      builder: (context, snapshot) {
        final mnemonic = snapshot.data;

        return ScaviumScaffold(
          appBar: AppBar(title: const Text('Backup phrase')),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SectionTitle(
                title: 'Save your secret recovery phrase',
                subtitle:
                    'Write these words down offline. Never share them. Anyone with them can control your funds.',
              ),
              const SizedBox(height: 20),
              ScaviumCard(
                child:
                    mnemonic == null
                        ? const Text('No mnemonic available for this wallet.')
                        : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              mnemonic
                                  .split(' ')
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => Chip(
                                      label: Text(
                                        '${entry.key + 1}. ${entry.value}',
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
              ),
              const SizedBox(height: 24),
              ScaviumPrimaryButton(
                text: 'I saved it',
                onPressed: () => context.go(RouteNames.confirmMnemonic),
              ),
            ],
          ),
        );
      },
    );
  }
}
