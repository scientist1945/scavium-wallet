import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/errors/app_exception.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/signing/domain/signing_mode.dart';
import 'package:scavium_wallet/features/signing/domain/signing_request.dart';
import 'package:scavium_wallet/features/signing/domain/signing_result.dart';

abstract class SigningService {
  Future<SigningResult> signPersonalMessage(String message);
  Future<SigningResult> signChallengeMessage(String message);
}

class RpcSigningService implements SigningService {
  final ScaviumRpcService rpc;

  const RpcSigningService(this.rpc);

  @override
  Future<SigningResult> signPersonalMessage(String message) {
    return rpc.signPersonalMessage(message);
  }

  @override
  Future<SigningResult> signChallengeMessage(String message) {
    return rpc.signChallengeMessage(message);
  }
}

final signingServiceProvider = Provider<SigningService>((ref) {
  return RpcSigningService(ref.read(scaviumRpcServiceProvider));
});

final signingControllerProvider =
    AsyncNotifierProvider<SigningController, SigningResult?>(
      SigningController.new,
    );

class SigningController extends AsyncNotifier<SigningResult?> {
  @override
  Future<SigningResult?> build() async {
    return null;
  }

  Future<SigningResult> sign(SigningRequest request) async {
    final normalizedRequest = request.normalized();
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final service = ref.read(signingServiceProvider);
      final signed = switch (normalizedRequest.mode) {
        SigningMode.personalMessage => await service.signPersonalMessage(
          normalizedRequest.message,
        ),
        SigningMode.challengeMessage => await service.signChallengeMessage(
          normalizedRequest.message,
        ),
      };

      if (!_sameAddress(
        signed.accountAddress,
        normalizedRequest.accountAddress,
      )) {
        throw const AppException(
          'Signed account does not match requested account',
        );
      }

      return signed;
    });

    state = result;
    return result.requireValue;
  }

  bool _sameAddress(String left, String right) {
    return left.trim().toLowerCase() == right.trim().toLowerCase();
  }
}
