import 'package:flutter/material.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';

class SigningConfirmDialog extends StatelessWidget {
  final SigningMode mode;
  final String accountAddress;
  final String message;

  const SigningConfirmDialog({
    super.key,
    required this.mode,
    required this.accountAddress,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm signature'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_modeLabel(mode)),
          const SizedBox(height: 12),
          const Text('Account'),
          SelectableText(accountAddress),
          const SizedBox(height: 12),
          const Text('Message preview'),
          SelectableText(message),
          const SizedBox(height: 12),
          const Text(
            'Signing does not send a transaction, move funds, or grant access to your recovery phrase or private keys.',
          ),
          const SizedBox(height: 8),
          Text(_confirmationWarning(mode)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Sign'),
        ),
      ],
    );
  }

  String _modeLabel(SigningMode mode) {
    return switch (mode) {
      SigningMode.personalMessage => 'Personal message',
      SigningMode.challengeMessage => 'Challenge message',
    };
  }

  String _confirmationWarning(SigningMode mode) {
    return switch (mode) {
      SigningMode.personalMessage =>
        'Approve this personal message only if you recognize the full text.',
      SigningMode.challengeMessage =>
        'Approve this challenge only if it came from the service you are intentionally verifying with.',
    };
  }
}
