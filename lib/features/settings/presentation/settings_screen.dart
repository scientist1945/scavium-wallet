import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/lock/application/lock_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lockState = ref.watch(lockControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Settings')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ScaviumCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: lockState.valueOrNull ?? false,
                  onChanged: (value) async {
                    if (value) {
                      await ref
                          .read(lockControllerProvider.notifier)
                          .enableLock();
                    } else {
                      await ref
                          .read(lockControllerProvider.notifier)
                          .disableLock();
                    }
                  },
                  title: const Text('Enable local lock'),
                  subtitle: const Text(
                    'Phase 1 uses a basic PIN placeholder to wire the security flow.',
                  ),
                ),
              ],
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
                Text('Version 0.1.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
