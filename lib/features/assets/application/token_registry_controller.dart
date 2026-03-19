import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/data/token_registry_repository_impl.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';

final tokenRegistryControllerProvider =
    AsyncNotifierProvider<TokenRegistryController, List<TokenInfo>>(
      TokenRegistryController.new,
    );

class TokenRegistryController extends AsyncNotifier<List<TokenInfo>> {
  @override
  Future<List<TokenInfo>> build() async {
    return ref.read(tokenRegistryRepositoryProvider).getTokens();
  }

  Future<void> addTokenByAddress(String contractAddress) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final rpc = ref.read(scaviumRpcServiceProvider);
      final repo = ref.read(tokenRegistryRepositoryProvider);

      final token = await rpc.loadTokenMetadata(contractAddress);
      await repo.addToken(token);

      return repo.getTokens();
    });
  }

  Future<void> removeToken(String contractAddress) async {
    final repo = ref.read(tokenRegistryRepositoryProvider);
    await repo.removeToken(contractAddress);
    state = AsyncData(await repo.getTokens());
  }
}
