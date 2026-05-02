import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/features/blockchain/application/rpc_health_controller.dart';
import 'package:scavium_wallet/features/blockchain/presentation/rpc_diagnostics_screen.dart';

void main() {
  test('RPC health errors do not expose raw exception contents', () {
    const error = AppException(
      'privateKey=0xabc mnemonic="seed words" signature=0xsigned backupPassword=secret',
    );

    final message = safeRpcHealthErrorMessage(error);

    expect(message, contains('RPC ERROR'));
    expect(message, contains('connectivity'));
    expect(message, isNot(contains('privateKey')));
    expect(message, isNot(contains('mnemonic')));
    expect(message, isNot(contains('signature')));
    expect(message, isNot(contains('backupPassword')));
    expect(message, isNot(contains('0xabc')));
    expect(message, isNot(contains('secret')));
    expect(message, isNot(contains('AppException')));
  });

  test('RPC status errors are normalized for diagnostics UI', () {
    const error = AppException(
      'address=0x1111111111111111111111111111111111111111 raw signed message',
    );

    final message = safeRpcStatusErrorMessage(error);

    expect(message, contains('RPC status unavailable'));
    expect(
      message,
      isNot(contains('0x1111111111111111111111111111111111111111')),
    );
    expect(message, isNot(contains('signed message')));
    expect(message, isNot(contains('AppException')));
  });

  test('RPC health success keeps useful non-sensitive state', () {
    final message = formatRpcHealthOk(chainId: 1, latestBlock: 42);

    expect(message, 'RPC OK | chainId=1 | block=42');
  });
}
