import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/constants/storage_keys.dart';
import 'package:scavium_wallet/core/providers/service_providers.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';
import 'package:scavium_wallet/features/assets/domain/token_registry_repository.dart';

final tokenRegistryRepositoryProvider = Provider<TokenRegistryRepository>((
  ref,
) {
  return TokenRegistryRepositoryImpl(ref);
});

class TokenRegistryRepositoryImpl implements TokenRegistryRepository {
  final Ref ref;

  TokenRegistryRepositoryImpl(this.ref);

  @override
  Future<List<TokenInfo>> getTokens() async {
    final storage = ref.read(localStorageProvider);
    final raw = await storage.getString(StorageKeys.tokenRegistryJson);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TokenInfo.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> saveTokens(List<TokenInfo> tokens) async {
    final storage = ref.read(localStorageProvider);
    final raw = jsonEncode(tokens.map((e) => e.toJson()).toList());
    await storage.setString(StorageKeys.tokenRegistryJson, raw);
  }

  @override
  Future<void> addToken(TokenInfo token) async {
    final items = await getTokens();
    final exists = items.any(
      (e) =>
          e.contractAddress.toLowerCase() ==
          token.contractAddress.toLowerCase(),
    );
    if (exists) return;

    items.add(token);
    await saveTokens(items);
  }

  @override
  Future<void> removeToken(String contractAddress) async {
    final items = await getTokens();
    items.removeWhere(
      (e) => e.contractAddress.toLowerCase() == contractAddress.toLowerCase(),
    );
    await saveTokens(items);
  }
}
