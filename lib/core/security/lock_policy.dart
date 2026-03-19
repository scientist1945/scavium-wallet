class LockPolicy {
  final bool enabled;
  final bool biometricAllowed;
  final Duration autoLockAfter;

  const LockPolicy({
    required this.enabled,
    required this.biometricAllowed,
    required this.autoLockAfter,
  });

  const LockPolicy.defaultPolicy()
    : enabled = false,
      biometricAllowed = true,
      autoLockAfter = const Duration(minutes: 2);
}
