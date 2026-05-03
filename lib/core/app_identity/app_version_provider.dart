import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scavium_wallet/core/app_identity/app_version_info.dart';

abstract class AppVersionReader {
  Future<AppVersionInfo> read();
}

class PackageInfoAppVersionReader implements AppVersionReader {
  const PackageInfoAppVersionReader();

  @override
  Future<AppVersionInfo> read() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppVersionInfo(
      appName: packageInfo.appName,
      semanticVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}

final appVersionReaderProvider = Provider<AppVersionReader>((ref) {
  return const PackageInfoAppVersionReader();
});

final appVersionInfoProvider = FutureProvider<AppVersionInfo>((ref) {
  return ref.watch(appVersionReaderProvider).read();
});
