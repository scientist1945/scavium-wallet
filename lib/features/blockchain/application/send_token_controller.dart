import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';

final sendTokenControllerProvider =
    AsyncNotifierProvider<SendTokenController, TransactionSendResult?>(
      SendTokenController.new,
    );

class SendTokenController extends AsyncNotifier<TransactionSendResult?> {
  @override
  Future<TransactionSendResult?> build() async {
    return null;
  }

  Future<void> sendToken({
    required TokenInfo token,
    required String toAddress,
    required String amountText,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final rpc = ref.read(scaviumRpcServiceProvider);

      final amountRaw = _parseUnits(amountText, token.decimals);
      if (amountRaw <= BigInt.zero) {
        throw Exception('Monto inválido');
      }

      final result = await rpc.sendErc20Transaction(
        contractAddress: token.contractAddress,
        toAddress: toAddress,
        amountRaw: amountRaw,
      );

      await ref
          .read(txHistoryControllerProvider.notifier)
          .addEntry(
            TxHistoryEntry(
              id: '${DateTime.now().microsecondsSinceEpoch}',
              kind: TxKind.erc20Send,
              status: result.confirmed ? TxStatus.confirmed : TxStatus.pending,
              symbol: token.symbol,
              tokenAddress: token.contractAddress,
              toAddress: toAddress,
              amountDisplay: amountText,
              txHash: result.txHash,
              createdAt: DateTime.now(),
            ),
          );

      ref.invalidate(assetsControllerProvider);
      return result;
    });
  }

  BigInt _parseUnits(String value, int decimals) {
    final normalized = value.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return BigInt.zero;

    final parts = normalized.split('.');
    final whole = parts[0].isEmpty ? '0' : parts[0];
    final fraction = parts.length > 1 ? parts[1] : '';

    final sanitizedFraction =
        fraction.length > decimals
            ? fraction.substring(0, decimals)
            : fraction.padRight(decimals, '0');

    final combined = '$whole$sanitizedFraction'.replaceFirst(
      RegExp(r'^0+'),
      '',
    );
    return BigInt.parse(combined.isEmpty ? '0' : combined);
  }
}
