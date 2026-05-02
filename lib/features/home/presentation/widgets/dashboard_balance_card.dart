import 'package:flutter/material.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/domain/asset_item.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';

class DashboardBalanceCard extends StatelessWidget {
  final AssetItem? nativeAsset;

  const DashboardBalanceCard({super.key, required this.nativeAsset});

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Balance'),
          const SizedBox(height: 10),
          Text(
            nativeAsset == null
                ? 'Loading...'
                : '${nativeAsset!.displayBalance} ${AppConfig.current.nativeSymbol}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
