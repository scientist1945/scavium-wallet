import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/features/assets/application/token_registry_controller.dart';
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
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value.trim());
  }

  Future<void> _submit() async {
    setState(() => _error = null);

    final address = _controller.text.trim();
    if (!_isValidAddress(address)) {
      setState(() => _error = 'Contract address inválido');
      return;
    }

    await ref
        .read(tokenRegistryControllerProvider.notifier)
        .addTokenByAddress(address);

    final state = ref.read(tokenRegistryControllerProvider);
    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tokenRegistryControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Add token')),
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
            text: state.isLoading ? 'Adding...' : 'Add token',
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}
