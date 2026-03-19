import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_primary_button.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class ReceiveScreen extends ConsumerWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletControllerProvider);
    final address = walletState.valueOrNull?.account.address ?? '';

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Receive')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SectionTitle(
            title: 'Receive SCAV',
            subtitle: 'Share your address or QR code to receive funds.',
          ),
          const SizedBox(height: 24),
          Center(
            child: ScaviumCard(
              padding: const EdgeInsets.all(24),
              child: QrImageView(data: address, size: 220),
            ),
          ),
          const SizedBox(height: 24),
          ScaviumCard(
            child: SelectableText(
              address,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          ScaviumPrimaryButton(
            text: 'Copy address',
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: address));
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Address copied')));
              }
            },
          ),
        ],
      ),
    );
  }
}
