class EvmAmounts {
  static bool isPositiveDecimal(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    return parsed != null && parsed > 0;
  }

  static bool hasTooManyDecimals(String value, int decimals) {
    final normalized = value.trim().replaceAll(',', '.');
    final parts = normalized.split('.');
    if (parts.length < 2) return false;
    return parts[1].length > decimals;
  }
}
