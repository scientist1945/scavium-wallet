class AppVersionInfo {
  final String appName;
  final String semanticVersion;
  final String buildNumber;

  const AppVersionInfo({
    required this.appName,
    required this.semanticVersion,
    required this.buildNumber,
  });

  String get displayLabel {
    final normalizedName = appName.trim();
    final normalizedVersion = semanticVersion.trim();
    final normalizedBuild = buildNumber.trim();

    if (normalizedBuild.isEmpty) {
      return '$normalizedName $normalizedVersion';
    }

    return '$normalizedName $normalizedVersion ($normalizedBuild)';
  }
}
