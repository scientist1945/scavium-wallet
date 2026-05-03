import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/build.dart' as build_tool;

void main() {
  group('readVersionInfo', () {
    test('parses strict pubspec version format', () {
      final pubspecFile = _writePubspec(version: '1.2.3+45');

      final version = build_tool.readVersionInfo(pubspecFile);

      expect(version.buildName, '1.2.3');
      expect(version.buildNumber, 45);
      expect(version.fullVersion, '1.2.3+45');
    });
  });

  group('normalizeGitTag', () {
    test('normalizes simple version tags', () {
      expect(build_tool.normalizeGitTag('v1.2.3'), '1.2.3');
    });

    test('normalizes refs tag names', () {
      expect(build_tool.normalizeGitTag('refs/tags/v1.2.3'), '1.2.3');
    });

    test('rejects tags without v prefix', () {
      expect(build_tool.normalizeGitTag('1.2.3'), isNull);
    });

    test('rejects tags with invalid semantic versions', () {
      expect(build_tool.normalizeGitTag('v1.2'), isNull);
      expect(build_tool.normalizeGitTag('v1.2.3+4'), isNull);
      expect(build_tool.normalizeGitTag('refs/tags/1.2.3'), isNull);
    });
  });

  group('resolveVersion', () {
    test('increments the build number when no override is provided', () {
      final pubspecFile = _writePubspec(version: '0.2.2+1');

      final version = build_tool.resolveVersion(
        pubspecFile: pubspecFile,
        overrideVersion: null,
        noVersionBump: false,
      );

      expect(version.buildName, '0.2.2');
      expect(version.buildNumber, 2);
      expect(pubspecFile.readAsStringSync(), contains('version: 0.2.2+2'));
    });

    test(
      'increments the build number when override matches current version',
      () {
        final pubspecFile = _writePubspec(version: '0.2.2+1');

        final version = build_tool.resolveVersion(
          pubspecFile: pubspecFile,
          overrideVersion: '0.2.2',
          noVersionBump: false,
        );

        expect(version.buildName, '0.2.2');
        expect(version.buildNumber, 2);
        expect(pubspecFile.readAsStringSync(), contains('version: 0.2.2+2'));
      },
    );

    test('resets the build number when override changes semantic version', () {
      final pubspecFile = _writePubspec(version: '0.2.2+9');

      final version = build_tool.resolveVersion(
        pubspecFile: pubspecFile,
        overrideVersion: '0.2.3',
        noVersionBump: false,
      );

      expect(version.buildName, '0.2.3');
      expect(version.buildNumber, 1);
      expect(pubspecFile.readAsStringSync(), contains('version: 0.2.3+1'));
    });

    test('leaves pubspec unchanged when no-version-bump is set', () {
      final pubspecFile = _writePubspec(version: '0.2.2+4');
      final originalContent = pubspecFile.readAsStringSync();

      final version = build_tool.resolveVersion(
        pubspecFile: pubspecFile,
        overrideVersion: '0.2.3',
        noVersionBump: true,
      );

      expect(version.buildName, '0.2.2');
      expect(version.buildNumber, 4);
      expect(pubspecFile.readAsStringSync(), originalContent);
    });
  });

  group('syncMsixVersion', () {
    test('derives msix version from resolved full version', () {
      final pubspecFile = _writePubspec(
        version: '0.2.2+1',
        msixVersion: '0.2.2.1',
      );

      build_tool.syncMsixVersion(
        pubspecFile: pubspecFile,
        version: const build_tool.VersionInfo(
          buildName: '0.2.3',
          buildNumber: 7,
        ),
      );

      expect(
        pubspecFile.readAsStringSync(),
        contains('  msix_version: 0.2.3.7'),
      );
    });
  });
}

File _writePubspec({required String version, String? msixVersion}) {
  final directory = Directory.systemTemp.createTempSync('build_tool_test_');
  addTearDown(() {
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  });

  final pubspecFile = File(
    '${directory.path}${Platform.pathSeparator}pubspec.yaml',
  );
  final msixVersionLine =
      msixVersion == null ? '' : '  msix_version: $msixVersion\n';

  pubspecFile.writeAsStringSync('''
name: scavium_wallet_test
version: $version

msix_config:
$msixVersionLine  display_name: SCAVIUM Wallet
''');

  return pubspecFile;
}
