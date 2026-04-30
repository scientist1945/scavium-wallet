import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_account.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';

class AccountSwitcher extends ConsumerWidget {
  final WalletProfile? profile;

  const AccountSwitcher({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolvedProfile = profile;

    if (resolvedProfile == null) {
      return const _AccountSwitcherPlaceholder();
    }

    final accounts = resolvedProfile.accounts;
    final activeAccount = resolvedProfile.activeAccount;
    final canSwitch = accounts.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Active account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            if (!canSwitch)
              const Chip(
                label: Text('Single account'),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: activeAccount.id,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Account',
          ),
          items: accounts
              .map(
                (account) => DropdownMenuItem<String>(
                  value: account.id,
                  child: _AccountOption(account: account),
                ),
              )
              .toList(growable: false),
          onChanged:
              canSwitch
                  ? (accountId) async {
                    if (accountId == null || accountId == activeAccount.id) {
                      return;
                    }

                    await ref
                        .read(walletControllerProvider.notifier)
                        .setActiveAccount(accountId);
                  }
                  : null,
        ),
        const SizedBox(height: 10),
        SelectableText(
          activeAccount.address,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _AccountOption extends StatelessWidget {
  final WalletAccount account;

  const _AccountOption({required this.account});

  @override
  Widget build(BuildContext context) {
    final label =
        account.label == null || account.label!.trim().isEmpty
            ? account.name
            : account.label!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, overflow: TextOverflow.ellipsis),
        Text(
          _shortAddress(account.address),
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _shortAddress(String address) {
    final trimmed = address.trim();
    if (trimmed.length <= 14) {
      return trimmed;
    }
    return '${trimmed.substring(0, 8)}...${trimmed.substring(trimmed.length - 6)}';
  }
}

class _AccountSwitcherPlaceholder extends StatelessWidget {
  const _AccountSwitcherPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12),
        Text('No wallet profile loaded'),
      ],
    );
  }
}
