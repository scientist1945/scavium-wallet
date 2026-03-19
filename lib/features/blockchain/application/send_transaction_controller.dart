import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/application/native_balance_controller.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';
import 'package:web3dart/web3dart.dart';

final sendTransactionControllerProvider =
    AsyncNotifierProvider<SendTransactionController, TransactionSendResult?>(
      SendTransactionController.new,
    );

class SendTransactionController extends AsyncNotifier<TransactionSendResult?> {
  @override
  Future<TransactionSendResult?> build() async {
    return null;
  }

  Future<void> sendNative({
    required String toAddress,
    required String amountText,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);

      final amount = double.tryParse(amountText.replaceAll(',', '.'));
      if (amount == null || amount <= 0) {
        throw Exception('Monto inválido');
      }

      final value = EtherAmount.fromUnitAndValue(
        EtherUnit.ether,
        amount.toString(),
      );

      final result = await service.sendNativeTransaction(
        toAddress: toAddress,
        amount: value,
      );

      ref.invalidate(nativeBalanceControllerProvider);

      return result;
    });
  }
}
