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
    final normalizedTokens = _dedupeTokens(tokens);
    final raw = jsonEncode(normalizedTokens.map((e) => e.toJson()).toList());
    await storage.setString(StorageKeys.tokenRegistryJson, raw);
  }

  @override
  Future<void> addToken(TokenInfo token) async {
    final items = await getTokens();
    final normalizedToken = token.normalized();
    final exists = items.any(
      (e) => e.contractAddress == normalizedToken.contractAddress,
    );
    if (exists) return;

    items.add(normalizedToken);
    await saveTokens(items);
  }

  @override
  Future<void> removeToken(String contractAddress) async {
    final items = await getTokens();
    final normalizedAddress = TokenInfo.normalizeContractAddress(
      contractAddress,
    );
    items.removeWhere((e) => e.contractAddress == normalizedAddress);
    await saveTokens(items);
  }

  List<TokenInfo> _dedupeTokens(List<TokenInfo> tokens) {
    final byAddress = <String, TokenInfo>{};
    for (final token in tokens) {
      final normalizedToken = token.normalized();
      byAddress.putIfAbsent(normalizedToken.contractAddress, () {
        return normalizedToken;
      });
    }
    return byAddress.values.toList(growable: false);
  }
}
