import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/onboarding/application/onboarding_controller.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class ImportWalletScreen extends ConsumerStatefulWidget {
  const ImportWalletScreen({super.key});

  @override
  ConsumerState<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends ConsumerState<ImportWalletScreen> {
  final _accountNameCtrl = TextEditingController(text: 'Imported Account');
  final _secretCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();

  bool _useMnemonic = true;
  bool _biometricEnabled = true;
  String? _error;

  @override
  void dispose() {
    _accountNameCtrl.dispose();
    _secretCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);

    if (_pinCtrl.text.length < 4) {
      setState(() => _error = 'El PIN debe tener al menos 4 dígitos');
      return;
    }

    final notifier = ref.read(walletControllerProvider.notifier);

    if (_useMnemonic) {
      await notifier.importFromMnemonic(
        mnemonic: _secretCtrl.text,
        accountName:
            _accountNameCtrl.text.trim().isEmpty
                ? 'Imported Account'
                : _accountNameCtrl.text.trim(),
        pin: _pinCtrl.text.trim(),
        biometricEnabled: _biometricEnabled,
      );
    } else {
      await notifier.importFromPrivateKey(
        privateKey: _secretCtrl.text,
        accountName:
            _accountNameCtrl.text.trim().isEmpty
                ? 'Imported Account'
                : _accountNameCtrl.text.trim(),
        pin: _pinCtrl.text.trim(),
        biometricEnabled: _biometricEnabled,
      );
    }

    final state = ref.read(walletControllerProvider);
    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    await ref.read(onboardingControllerProvider.notifier).completeOnboarding();

    if (!mounted) return;
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Import wallet')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SectionTitle(
            title: 'Import existing wallet',
            subtitle: 'Restore from BIP39 mnemonic or EVM private key.',
          ),
          const SizedBox(height: 16),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(value: true, label: Text('Mnemonic')),
              ButtonSegment<bool>(value: false, label: Text('Private key')),
            ],
            selected: {_useMnemonic},
            onSelectionChanged: (value) {
              setState(() {
                _useMnemonic = value.first;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _accountNameCtrl,
            decoration: const InputDecoration(labelText: 'Account name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _secretCtrl,
            maxLines: _useMnemonic ? 3 : 1,
            decoration: InputDecoration(
              labelText: _useMnemonic ? 'Mnemonic phrase' : 'Private key',
              errorText: _error,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pinCtrl,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'PIN'),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: _biometricEnabled,
            onChanged:
                (value) => setState(() {
                  _biometricEnabled = value;
                }),
            title: const Text('Enable biometrics'),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          ScaviumPrimaryButton(
            text: walletState.isLoading ? 'Importing...' : 'Import wallet',
            isLoading: walletState.isLoading,
            onPressed: walletState.isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}
