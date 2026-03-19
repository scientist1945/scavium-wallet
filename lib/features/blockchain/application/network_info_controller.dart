import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/network_info.dart';

final networkInfoControllerProvider =
    AsyncNotifierProvider<NetworkInfoController, NetworkInfo>(
      NetworkInfoController.new,
    );

class NetworkInfoController extends AsyncNotifier<NetworkInfo> {
  @override
  Future<NetworkInfo> build() async {
    final service = ref.read(scaviumRpcServiceProvider);
    return service.getNetworkInfo();
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);
      return service.getNetworkInfo();
    });
  }
}
