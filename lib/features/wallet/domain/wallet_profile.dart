import 'package:scavium_wallet/features/wallet/domain/imported_wallet_type.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';

class WalletProfile {
  final ImportedWalletType type;
  final WalletAccount account;
  final bool hasMnemonic;
  final bool biometricEnabled;

  const WalletProfile({
    required this.type,
    required this.account,
    required this.hasMnemonic,
    required this.biometricEnabled,
  });

  WalletProfile copyWith({
    ImportedWalletType? type,
    WalletAccount? account,
    bool? hasMnemonic,
    bool? biometricEnabled,
  }) {
    return WalletProfile(
      type: type ?? this.type,
      account: account ?? this.account,
      hasMnemonic: hasMnemonic ?? this.hasMnemonic,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    );
  }
}
