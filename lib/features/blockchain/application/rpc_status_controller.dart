import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/scavium_rpc_status.dart';

final rpcStatusControllerProvider =
    AutoDisposeAsyncNotifierProvider<RpcStatusController, ScaviumRpcStatus>(
      RpcStatusController.new,
    );

class RpcStatusController extends AutoDisposeAsyncNotifier<ScaviumRpcStatus> {
  @override
  Future<ScaviumRpcStatus> build() async {
    final service = ref.read(scaviumRpcServiceProvider);
    return service.getRpcStatus();
  }

  Future<void> refreshStatus() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);
      return service.getRpcStatus();
    });
  }

  Future<void> selectRpc(int index) async {
    final service = ref.read(scaviumRpcServiceProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.setActiveRpcByIndex(index);
      return service.getRpcStatus();
    });
  }

  Future<bool> pingRpc(int index) async {
    final service = ref.read(scaviumRpcServiceProvider);
    return service.pingRpcByIndex(index);
  }

  Future<bool> pingActiveRpc() async {
    final service = ref.read(scaviumRpcServiceProvider);
    return service.pingActiveRpc();
  }
}
