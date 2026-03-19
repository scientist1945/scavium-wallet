import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('SCAVIUM Wallet'),
        actions: [
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
                const Text('Total Balance', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                const Text(
                  '0.0000 SCAV',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text('Network: ${AppConfig.current.appName}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const ScaviumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _QuickAction(title: 'Send', icon: Icons.arrow_upward),
                    _QuickAction(title: 'Receive', icon: Icons.arrow_downward),
                    _QuickAction(title: 'History', icon: Icons.receipt_long),
                    _QuickAction(title: 'Accounts', icon: Icons.wallet),
                  ],
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
                  'Assets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Text('S')),
                  title: Text('SCAVIUM'),
                  subtitle: Text('Native token'),
                  trailing: Text('0.0000'),
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

  const _QuickAction({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [Icon(icon), const SizedBox(height: 10), Text(title)],
      ),
    );
  }
}
