import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/onboarding/application/onboarding_controller.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/scavium_secondary_button.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class CreateWalletScreen extends ConsumerStatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  ConsumerState<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends ConsumerState<CreateWalletScreen> {
  final _accountNameCtrl = TextEditingController(text: 'Main Account');
  final _pinCtrl = TextEditingController();
  bool _biometricEnabled = true;
  String? _error;

  @override
  void dispose() {
    _accountNameCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);

    if (_pinCtrl.text.length < 4) {
      setState(() => _error = 'El PIN debe tener al menos 4 dígitos');
      return;
    }

    await ref
        .read(walletControllerProvider.notifier)
        .createWallet(
          accountName:
              _accountNameCtrl.text.trim().isEmpty
                  ? 'Main Account'
                  : _accountNameCtrl.text.trim(),
          pin: _pinCtrl.text.trim(),
          biometricEnabled: _biometricEnabled,
        );

    final state = ref.read(walletControllerProvider);
    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    await ref.read(onboardingControllerProvider.notifier).completeOnboarding();

    if (!mounted) return;
    context.go(RouteNames.backupMnemonic);
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Create wallet')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SectionTitle(
            title: 'Create your SCAVIUM wallet',
            subtitle:
                'This creates a real EVM-compatible wallet for the SCAVIUM network.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _accountNameCtrl,
            decoration: const InputDecoration(labelText: 'Account name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pinCtrl,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'PIN', errorText: _error),
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
            text: walletState.isLoading ? 'Creating...' : 'Create wallet',
            isLoading: walletState.isLoading,
            onPressed: walletState.isLoading ? null : _submit,
          ),
          const SizedBox(height: 12),
          ScaviumSecondaryButton(text: 'Back', onPressed: () => context.pop()),
        ],
      ),
    );
  }
}
