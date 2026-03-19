class AppSessionState {
  final bool onboardingCompleted;
  final bool walletCreated;
  final bool lockEnabled;
  final bool hideBalances;

  const AppSessionState({
    required this.onboardingCompleted,
    required this.walletCreated,
    required this.lockEnabled,
    required this.hideBalances,
  });

  const AppSessionState.initial()
    : onboardingCompleted = false,
      walletCreated = false,
      lockEnabled = false,
      hideBalances = false;

  AppSessionState copyWith({
    bool? onboardingCompleted,
    bool? walletCreated,
    bool? lockEnabled,
    bool? hideBalances,
  }) {
    return AppSessionState(
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      walletCreated: walletCreated ?? this.walletCreated,
      lockEnabled: lockEnabled ?? this.lockEnabled,
      hideBalances: hideBalances ?? this.hideBalances,
    );
  }
}
