import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/features/wallet/domain/wallet_profile.dart';

enum _AddAccountMode { derived, privateKey }

class _AccountModeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _AccountModeTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      enabled: enabled,
      onTap: enabled ? onTap : null,
      leading: Icon(
        selected ? LucideIcons.checkCircle : LucideIcons.circle,
        size: ScavoIconSize.inline,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

Future<void> showAddAccountSheet(
  BuildContext context, {
  required WalletProfile profile,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => AddAccountSheet(profile: profile),
  );
}

class AddAccountSheet extends ConsumerStatefulWidget {
  final WalletProfile profile;

  const AddAccountSheet({super.key, required this.profile});

  @override
  ConsumerState<AddAccountSheet> createState() => _AddAccountSheetState();
}

class _AddAccountSheetState extends ConsumerState<AddAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _privateKeyController = TextEditingController();

  _AddAccountMode _mode = _AddAccountMode.derived;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();

    if (!widget.profile.hasMnemonic) {
      _mode = _AddAccountMode.privateKey;
    }
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final canDerive = widget.profile.hasMnemonic;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: bottomInset + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Add account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        _submitting ? null : () => Navigator.pop(context),
                    icon: const Icon(LucideIcons.x, size: ScavoIconSize.action),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _AccountModeTile(
                title: 'Create derived account',
                subtitle: 'Uses the existing wallet mnemonic.',
                selected: _mode == _AddAccountMode.derived,
                enabled: canDerive && !_submitting,
                onTap: () => setState(() => _mode = _AddAccountMode.derived),
              ),
              _AccountModeTile(
                title: 'Import private key account',
                subtitle: 'Adds an independent imported account.',
                selected: _mode == _AddAccountMode.privateKey,
                enabled: !_submitting,
                onTap: () => setState(() => _mode = _AddAccountMode.privateKey),
              ),
              if (!canDerive) ...[
                const SizedBox(height: 8),
                const Text(
                  'Derived accounts are only available for mnemonic wallets.',
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _accountNameController,
                enabled: !_submitting,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Account name',
                  hintText: 'Account 2',
                ),
              ),
              if (_mode == _AddAccountMode.privateKey) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _privateKeyController,
                  enabled: !_submitting,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Private key',
                    hintText: '0x...',
                  ),
                  validator: (value) {
                    if (_mode != _AddAccountMode.privateKey) {
                      return null;
                    }

                    if (value == null || value.trim().isEmpty) {
                      return 'Private key is required';
                    }

                    return null;
                  },
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submitting ? null : _submit,
                  icon:
                      _submitting
                          ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(
                            LucideIcons.plus,
                            size: ScavoIconSize.inline,
                          ),
                  label: Text(_submitting ? 'Adding...' : 'Add account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);

    final accountName = _accountNameController.text.trim();
    final controller = ref.read(walletControllerProvider.notifier);

    try {
      if (_mode == _AddAccountMode.derived) {
        await controller.addDerivedAccount(accountName: accountName);
      } else {
        await controller.addPrivateKeyAccount(
          privateKey: _privateKeyController.text,
          accountName: accountName,
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not add account: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}
