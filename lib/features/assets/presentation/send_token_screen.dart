import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/application/send_token_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class SendTokenScreen extends ConsumerStatefulWidget {
  final TokenInfo token;

  const SendTokenScreen({super.key, required this.token});

  @override
  ConsumerState<SendTokenScreen> createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends ConsumerState<SendTokenScreen> {
  final _toCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _toCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  bool _isValidAddress(String value) {
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value.trim());
  }

  Future<void> _send() async {
    setState(() => _error = null);

    if (!_isValidAddress(_toCtrl.text.trim())) {
      setState(() => _error = 'Dirección inválida');
      return;
    }

    if (_amountCtrl.text.trim().isEmpty) {
      setState(() => _error = 'Monto inválido');
      return;
    }

    await ref
        .read(sendTokenControllerProvider.notifier)
        .sendToken(
          token: widget.token,
          toAddress: _toCtrl.text.trim(),
          amountText: _amountCtrl.text.trim(),
        );

    final state = ref.read(sendTokenControllerProvider);
    if (state.hasError) {
      setState(() => _error = state.error.toString());
      return;
    }

    final txHash = state.valueOrNull?.txHash;
    if (txHash == null || !mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Token transfer sent'),
          content: SelectableText(txHash),
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
    final state = ref.watch(sendTokenControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: Text('Send ${widget.token.symbol}')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SectionTitle(
            title: 'Send ${widget.token.symbol}',
            subtitle: 'ERC-20 transfer for ${widget.token.name}.',
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
              labelText: 'Amount (${widget.token.symbol})',
            ),
          ),
          const SizedBox(height: 24),
          ScaviumPrimaryButton(
            text: state.isLoading ? 'Sending...' : 'Send token',
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : _send,
          ),
        ],
      ),
    );
  }
}
