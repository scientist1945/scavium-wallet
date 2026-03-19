import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:web3dart/web3dart.dart';

final nativeBalanceControllerProvider =
    AsyncNotifierProvider<NativeBalanceController, EtherAmount>(
      NativeBalanceController.new,
    );

class NativeBalanceController extends AsyncNotifier<EtherAmount> {
  @override
  Future<EtherAmount> build() async {
    final service = ref.read(scaviumRpcServiceProvider);
    return service.getNativeBalance();
  }

  Future<void> refreshBalance() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);
      return service.getNativeBalance();
    });
  }
}
