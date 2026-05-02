import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_tokens.dart';
import 'package:scavium_wallet/features/signing/domain/signing_result.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';

class SigningResultCard extends StatelessWidget {
  final SigningResult result;

  const SigningResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ScaviumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signature result',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text('Signature'),
          const SizedBox(height: 6),
          SelectableText(result.signature),
          const SizedBox(height: 8),
          const Text(
            'Share this signature only with the service you intended to verify with. It is not a transaction receipt.',
          ),
          const SizedBox(height: 12),
          const Text('Signed account'),
          const SizedBox(height: 6),
          SelectableText(result.accountAddress),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: result.signature));
                if (context.mounted) {
                  AppSnackbar.showSuccess(context, 'Signature copied');
                }
              },
              icon: const Icon(LucideIcons.copy, size: ScavoIconSize.inline),
              label: const Text('Copy signature'),
            ),
          ),
        ],
      ),
    );
  }
}
