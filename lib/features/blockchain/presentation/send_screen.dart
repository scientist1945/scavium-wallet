import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/blockchain/application/send_transaction_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class SendScreen extends ConsumerStatefulWidget {
  const SendScreen({super.key});

  @override
  ConsumerState<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends ConsumerState<SendScreen> {
  final _toCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _toCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  bool _isValidEvmAddress(String value) {
    final exp = RegExp(r'^0x[a-fA-F0-9]{40}$');
    return exp.hasMatch(value.trim());
  }

  Future<void> _send() async {
    setState(() => _error = null);

    if (!_isValidEvmAddress(_toCtrl.text.trim())) {
      setState(() => _error = 'Dirección inválida');
      return;
    }

    if ((_amountCtrl.text.trim()).isEmpty) {
      setState(() => _error = 'Monto inválido');
      return;
    }

    await ref
        .read(sendTransactionControllerProvider.notifier)
        .sendNative(
          toAddress: _toCtrl.text.trim(),
          amountText: _amountCtrl.text.trim(),
        );

    final state = ref.read(sendTransactionControllerProvider);

    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    final txHash = state.valueOrNull?.txHash;
    if (txHash == null) return;

    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transaction sent'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your transaction was submitted.'),
              const SizedBox(height: 12),
              SelectableText(txHash),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final uri = Uri.parse(
                  '${AppConfig.current.txExplorerPath}/$txHash',
                );
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              child: const Text('Open explorer'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sendState = ref.watch(sendTransactionControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Send')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SectionTitle(
            title: 'Send ${AppConfig.current.nativeSymbol}',
            subtitle: 'Send native SCAVIUM funds to another EVM address.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _toCtrl,
            decoration: InputDecoration(
              labelText: 'Recipient address',
              errorText: _error,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Amount (${AppConfig.current.nativeSymbol})',
            ),
          ),
          const SizedBox(height: 24),
          ScaviumPrimaryButton(
            text: sendState.isLoading ? 'Sending...' : 'Send',
            isLoading: sendState.isLoading,
            onPressed: sendState.isLoading ? null : _send,
          ),
        ],
      ),
    );
  }
}
