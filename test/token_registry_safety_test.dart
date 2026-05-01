import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/features/assets/domain/token_info.dart';

void main() {
  group('TokenInfo contract address safety', () {
    test('normalizes ERC-20 contract addresses deterministically', () {
      final normalized = TokenInfo.normalizeContractAddress(
        '  0xABCDEFabcdefABCDEFabcdefABCDEFabcdefABCD  ',
      );

      expect(normalized, '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd');
    });

    test('rejects invalid contract addresses before metadata loading', () {
      expect(TokenInfo.isValidContractAddress(''), isFalse);
      expect(TokenInfo.isValidContractAddress('0x1234'), isFalse);
      expect(
        () => TokenInfo.normalizeContractAddress('not-a-contract'),
        throwsFormatException,
      );
    });

    test('normalizes token metadata without changing registry JSON keys', () {
      final token =
          const TokenInfo(
            contractAddress: '0xABCDEFabcdefABCDEFabcdefABCDEFabcdefABCD',
            name: '  Example Token  ',
            symbol: '  EXT  ',
            decimals: 18,
          ).normalized();

      expect(
        token.contractAddress,
        '0xabcdefabcdefabcdefabcdefabcdefabcdefabcd',
      );
      expect(token.name, 'Example Token');
      expect(token.symbol, 'EXT');
      expect(token.toJson().keys, {
        'contractAddress',
        'name',
        'symbol',
        'decimals',
      });
    });
  });
}
