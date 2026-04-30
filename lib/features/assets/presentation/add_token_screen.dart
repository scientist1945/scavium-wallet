import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/features/assets/application/token_registry_controller.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/feedback/loading_overlay.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class AddTokenScreen extends ConsumerStatefulWidget {
  const AddTokenScreen({super.key});

  @override
  ConsumerState<AddTokenScreen> createState() => _AddTokenScreenState();
}

class _AddTokenScreenState extends ConsumerState<AddTokenScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isValidAddress(String value) {
    return TokenInfo.isValidContractAddress(value);
  }

  Future<void> _submit() async {
    setState(() => _error = null);

    final rawAddress = _controller.text;
    if (!_isValidAddress(rawAddress)) {
      setState(() => _error = 'Enter a valid ERC-20 contract address');
      return;
    }

    await ref
        .read(tokenRegistryControllerProvider.notifier)
        .addTokenByAddress(TokenInfo.normalizeContractAddress(rawAddress));

    final state = ref.read(tokenRegistryControllerProvider);
    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    if (!mounted) return;
    AppSnackbar.showSuccess(context, 'Token added successfully');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tokenRegistryControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Add token')),
      child: LoadingOverlay(
        isVisible: state.isLoading,
        message: 'Loading token metadata...',
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SectionTitle(
              title: 'Add ERC-20 token',
              subtitle:
                  'Paste the token contract address to load metadata and balances.',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Contract address',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 20),
            ScaviumPrimaryButton(
              text: 'Add token',
              onPressed: state.isLoading ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}
