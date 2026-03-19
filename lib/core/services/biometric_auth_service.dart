import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> isDeviceSupported() {
    return _localAuthentication.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() {
    return _localAuthentication.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      final supported = await isDeviceSupported();
      if (!supported) return false;

      return await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to unlock SCAVIUM Wallet',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
