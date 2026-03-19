class EvmAddressUtils {
  static bool isValidAddress(String value) {
    return RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value.trim());
  }
}
