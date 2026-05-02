import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';

final rpcHealthControllerProvider =
    AsyncNotifierProvider<RpcHealthController, String>(RpcHealthController.new);

String formatRpcHealthOk({required int chainId, required int latestBlock}) {
  return 'RPC OK | chainId=$chainId | block=$latestBlock';
}

String safeRpcHealthErrorMessage([Object? error]) {
  return 'RPC ERROR | Node health unavailable. Check RPC connectivity and try again.';
}

class RpcHealthController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return _loadHealth();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _loadHealth());
  }

  Future<String> _loadHealth() async {
    final service = ref.read(scaviumRpcServiceProvider);

    try {
      final info = await service.getNetworkInfo();
      return formatRpcHealthOk(
        chainId: info.chainId,
        latestBlock: info.latestBlock,
      );
    } catch (error) {
      return safeRpcHealthErrorMessage(error);
    }
  }
}
