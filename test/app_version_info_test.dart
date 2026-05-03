import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/app_identity/app_version_info.dart';

void main() {
  group('AppVersionInfo', () {
    test('builds a stable display label with build number', () {
      const info = AppVersionInfo(
        appName: 'SCAVIUM Wallet',
        semanticVersion: '0.2.2',
        buildNumber: '1',
      );

      expect(info.displayLabel, 'SCAVIUM Wallet 0.2.2 (1)');
    });

    test('omits build suffix when build number is empty', () {
      const info = AppVersionInfo(
        appName: 'SCAVIUM Wallet',
        semanticVersion: '0.2.2',
        buildNumber: '',
      );

      expect(info.displayLabel, 'SCAVIUM Wallet 0.2.2');
    });

    test('trims version fields before formatting', () {
      const info = AppVersionInfo(
        appName: '  SCAVIUM Wallet  ',
        semanticVersion: '  0.2.2  ',
        buildNumber: '  1  ',
      );

      expect(info.displayLabel, 'SCAVIUM Wallet 0.2.2 (1)');
    });

    test(
      'keeps semantic version and build number as separate display parts',
      () {
        const info = AppVersionInfo(
          appName: 'SCAVIUM Wallet',
          semanticVersion: '0.2.2',
          buildNumber: '1',
        );

        expect(info.semanticVersion, '0.2.2');
        expect(info.buildNumber, '1');
        expect(info.displayLabel, isNot(contains('+')));
      },
    );
  });
}
