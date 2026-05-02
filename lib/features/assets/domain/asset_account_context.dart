import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';

class AssetAccountContext {
  final String accountId;
  final String name;
  final String? label;
  final String address;

  const AssetAccountContext({
    required this.accountId,
    required this.name,
    required this.label,
    required this.address,
  });

  String get displayName {
    final resolvedLabel = label?.trim();
    if (resolvedLabel != null && resolvedLabel.isNotEmpty) {
      return resolvedLabel;
    }
    return name;
  }

  String get shortAddress {
    final trimmed = address.trim();
    if (trimmed.length <= 14) {
      return trimmed;
    }
    return '${trimmed.substring(0, 8)}...${trimmed.substring(trimmed.length - 6)}';
  }

  factory AssetAccountContext.fromWalletAccount(WalletAccount account) {
    return AssetAccountContext(
      accountId: account.id,
      name: account.name,
      label: account.label,
      address: account.address,
    );
  }
}
