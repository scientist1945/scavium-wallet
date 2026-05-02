import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/signing/application/signing_controller.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_request.dart';
import 'package:scavium_wallet/features/signing/presentation/widgets/signing_confirm_dialog.dart';
import 'package:scavium_wallet/features/signing/presentation/widgets/signing_result_card.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/feedback/state_message.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class SigningScreen extends ConsumerStatefulWidget {
  const SigningScreen({super.key});

  @override
  ConsumerState<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends ConsumerState<SigningScreen> {
  final _messageController = TextEditingController();
  var _mode = SigningMode.personalMessage;
  String? _error;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sign(String accountAddress) async {
    setState(() => _error = null);

    final request = SigningRequest(
      mode: _mode,
      message: _messageController.text,
      accountAddress: accountAddress,
    );

    late final SigningRequest normalizedRequest;
    try {
      normalizedRequest = request.normalized();
    } catch (error) {
      setState(() => _error = error.toString());
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (_) => SigningConfirmDialog(
            mode: normalizedRequest.mode,
            accountAddress: normalizedRequest.accountAddress,
            message: normalizedRequest.message,
          ),
    );

    if (confirmed != true) {
      return;
    }

    try {
      await ref
          .read(signingControllerProvider.notifier)
          .sign(normalizedRequest);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Message signed');
      }
    } catch (error) {
      if (mounted) {
        setState(() => _error = error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletControllerProvider);
    final signingState = ref.watch(signingControllerProvider);
    final profile = walletState.valueOrNull;
    final activeAccount = profile?.activeAccount;
    final result = signingState.valueOrNull;

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Sign message')),
      child: walletState.when(
        data: (_) {
          if (activeAccount == null) {
            return const StateMessage(
              icon: Icons.account_balance_wallet_outlined,
              title: 'No active account',
              subtitle: 'Load a wallet before signing messages.',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ScaviumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Signing is not a transaction',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A signature proves control of the active account. It does not submit a transaction, move funds, or create transaction history.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Review the exact text before signing. Never sign a message that asks for your recovery phrase, private key, backup password, or unexpected permissions.',
                    ),
                    const SizedBox(height: 16),
                    const Text('Active account'),
                    const SizedBox(height: 6),
                    SelectableText(activeAccount.address),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ScaviumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<SigningMode>(
                      segments: const [
                        ButtonSegment(
                          value: SigningMode.personalMessage,
                          label: Text('Personal'),
                          icon: Icon(Icons.message_outlined),
                        ),
                        ButtonSegment(
                          value: SigningMode.challengeMessage,
                          label: Text('Challenge'),
                          icon: Icon(Icons.verified_user_outlined),
                        ),
                      ],
                      selected: {_mode},
                      onSelectionChanged: (selection) {
                        setState(() => _mode = selection.single);
                      },
                    ),
                    const SizedBox(height: 16),
                    _SigningModeWarning(mode: _mode),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _messageController,
                      minLines: 4,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Message or challenge',
                        errorText: _error,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed:
                          signingState.isLoading
                              ? null
                              : () => _sign(activeAccount.address),
                      icon: const Icon(Icons.draw_outlined),
                      label: Text(
                        signingState.isLoading
                            ? 'Signing...'
                            : 'Preview and sign',
                      ),
                    ),
                  ],
                ),
              ),
              if (result != null) ...[
                const SizedBox(height: 16),
                SigningResultCard(result: result),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => StateMessage(
              icon: Icons.error_outline,
              title: 'Error loading active account',
              subtitle: '$error',
            ),
      ),
    );
  }
}

class _SigningModeWarning extends StatelessWidget {
  final SigningMode mode;

  const _SigningModeWarning({required this.mode});

  @override
  Widget build(BuildContext context) {
    final text = switch (mode) {
      SigningMode.personalMessage =>
        'Personal messages are often used to prove account ownership. Only sign text you recognize and intend to share.',
      SigningMode.challengeMessage =>
        'Challenges should come from a trusted service and be reviewed exactly as shown before approval.',
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.warning_amber_outlined),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
