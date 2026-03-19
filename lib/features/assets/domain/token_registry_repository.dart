import 'package:scavium_wallet/features/assets/domain/token_info.dart';

abstract class TokenRegistryRepository {
  Future<List<TokenInfo>> getTokens();
  Future<void> saveTokens(List<TokenInfo> tokens);
  Future<void> addToken(TokenInfo token);
  Future<void> removeToken(String contractAddress);
}
