import 'package:scavium_wallet/features/wallet/domain/imported_wallet_type.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';

class WalletProfile {
  final ImportedWalletType type;
  final WalletAccount account;
  final List<WalletAccount> accounts;
  final String activeAccountId;
  final String defaultAccountId;
  final bool hasMnemonic;
  final bool biometricEnabled;

  WalletProfile({
    required this.type,
    required WalletAccount account,
    List<WalletAccount>? accounts,
    String? activeAccountId,
    String? defaultAccountId,
    required this.hasMnemonic,
    required this.biometricEnabled,
  }) : account = account,
       accounts = _normalizeAccounts(
         account: account,
         accounts: accounts,
         activeAccountId: activeAccountId,
         defaultAccountId: defaultAccountId,
       ),
       activeAccountId = activeAccountId ?? account.id,
       defaultAccountId = defaultAccountId ?? account.id;

  WalletAccount get activeAccount {
    return accounts.firstWhere(
      (candidate) => candidate.id == activeAccountId,
      orElse: () => account,
    );
  }

  WalletAccount get defaultAccount {
    return accounts.firstWhere(
      (candidate) => candidate.id == defaultAccountId,
      orElse: () => account,
    );
  }

  WalletProfile copyWith({
    ImportedWalletType? type,
    WalletAccount? account,
    List<WalletAccount>? accounts,
    String? activeAccountId,
    String? defaultAccountId,
    bool? hasMnemonic,
    bool? biometricEnabled,
  }) {
    final resolvedAccount = account ?? this.account;

    return WalletProfile(
      type: type ?? this.type,
      account: resolvedAccount,
      accounts: accounts ?? this.accounts,
      activeAccountId: activeAccountId ?? this.activeAccountId,
      defaultAccountId: defaultAccountId ?? this.defaultAccountId,
      hasMnemonic: hasMnemonic ?? this.hasMnemonic,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    );
  }

  static List<WalletAccount> _normalizeAccounts({
    required WalletAccount account,
    List<WalletAccount>? accounts,
    String? activeAccountId,
    String? defaultAccountId,
  }) {
    final source =
        accounts == null || accounts.isEmpty
            ? <WalletAccount>[account]
            : accounts;

    return source
        .map((candidate) {
          final isActive =
              activeAccountId == null
                  ? candidate.id == account.id
                  : candidate.id == activeAccountId;
          final isDefault =
              defaultAccountId == null
                  ? candidate.id == account.id
                  : candidate.id == defaultAccountId;

          return candidate.copyWith(
            isActive: candidate.isActive || isActive,
            isDefault: candidate.isDefault || isDefault,
          );
        })
        .toList(growable: false);
  }
}
