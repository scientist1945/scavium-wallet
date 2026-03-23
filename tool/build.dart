import 'dart:io';

Future<void> main(List<String> args) async {
  final options = BuildOptions.parse(args);

  logSection('SCAVIUM Wallet Build Automation');

  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    fail('pubspec.yaml not found in project root');
  }

  final versionInfo = resolveVersion(
    pubspecFile: pubspecFile,
    overrideVersion: options.version,
    noVersionBump: options.noVersionBump,
  );

  success('Using version ${versionInfo.fullVersion}');

  if (!options.skipClean) {
    await runCommand('flutter', ['clean']);
  } else {
    warn('Skipping flutter clean');
  }

  if (!options.skipPubGet) {
    await runCommand('flutter', ['pub', 'get']);
  } else {
    warn('Skipping flutter pub get');
  }

  switch (options.platform) {
    case BuildPlatform.androidApk:
      await buildAndroidApk(versionInfo);
      break;
    case BuildPlatform.androidBundle:
      await buildAndroidBundle(versionInfo);
      break;
    case BuildPlatform.web:
      await buildWeb(versionInfo);
      break;
    case BuildPlatform.windows:
      await buildWindows(versionInfo);
      break;
    case BuildPlatform.windowsMsix:
      await buildWindowsMsix(versionInfo);
      break;
    case BuildPlatform.all:
      await buildAndroidApk(versionInfo);
      await buildAndroidBundle(versionInfo);
      await buildWeb(versionInfo);
      await buildWindowsMsix(versionInfo);
      break;
  }

  showArtifacts();

  logSection('DONE');
  success('Build completed successfully: ${versionInfo.fullVersion}');
}

enum BuildPlatform { androidApk, androidBundle, web, windows, windowsMsix, all }

class BuildOptions {
  final BuildPlatform platform;
  final String? version;
  final bool noVersionBump;
  final bool skipClean;
  final bool skipPubGet;

  const BuildOptions({
    required this.platform,
    required this.version,
    required this.noVersionBump,
    required this.skipClean,
    required this.skipPubGet,
  });

  static BuildOptions parse(List<String> args) {
    BuildPlatform platform = BuildPlatform.all;
    String? version;
    bool noVersionBump = false;
    bool skipClean = false;
    bool skipPubGet = false;

    for (int i = 0; i < args.length; i++) {
      final arg = args[i];

      switch (arg) {
        case '--platform':
          if (i + 1 >= args.length) {
            fail('Missing value for --platform');
          }
          platform = parsePlatform(args[++i]);
          break;

        case '--version':
          if (i + 1 >= args.length) {
            fail('Missing value for --version');
          }
          version = args[++i].trim();
          break;

        case '--no-version-bump':
          noVersionBump = true;
          break;

        case '--skip-clean':
          skipClean = true;
          break;

        case '--skip-pub-get':
          skipPubGet = true;
          break;

        case '--help':
        case '-h':
          printUsage();
          exit(0);

        default:
          fail('Unknown argument: $arg');
      }
    }

    return BuildOptions(
      platform: platform,
      version: version,
      noVersionBump: noVersionBump,
      skipClean: skipClean,
      skipPubGet: skipPubGet,
    );
  }

  static BuildPlatform parsePlatform(String value) {
    switch (value.trim().toLowerCase()) {
      case 'android-apk':
        return BuildPlatform.androidApk;
      case 'android-bundle':
        return BuildPlatform.androidBundle;
      case 'web':
        return BuildPlatform.web;
      case 'windows':
        return BuildPlatform.windows;
      case 'windows-msix':
        return BuildPlatform.windowsMsix;
      case 'all':
        return BuildPlatform.all;
      default:
        fail(
          'Invalid platform: $value. Allowed: android-apk, android-bundle, web, windows, windows-msix, all',
        );
    }
  }
}

class VersionInfo {
  final String buildName;
  final int buildNumber;

  const VersionInfo({required this.buildName, required this.buildNumber});

  String get fullVersion => '$buildName+$buildNumber';
}

VersionInfo resolveVersion({
  required File pubspecFile,
  required String? overrideVersion,
  required bool noVersionBump,
}) {
  final content = pubspecFile.readAsStringSync();

  final regex = RegExp(
    r'^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$',
    multiLine: true,
  );

  final match = regex.firstMatch(content);
  if (match == null) {
    fail('Invalid pubspec version format. Expected: version: x.y.z+n');
  }

  final name = match.group(1);
  final build = match.group(2);

  if (name == null || build == null) {
    fail('Invalid pubspec version groups');
  }

  final currentName = name;
  final currentBuild = int.tryParse(build);
  if (currentBuild == null) {
    fail('Invalid pubspec build number: $build');
  }

  if (noVersionBump) {
    return VersionInfo(buildName: currentName, buildNumber: currentBuild);
  }

  late final String newName;
  late final int newBuild;

  if (overrideVersion == null || overrideVersion.isEmpty) {
    newName = currentName;
    newBuild = currentBuild + 1;
  } else {
    final normalized = overrideVersion.trim();

    final versionRegex = RegExp(r'^\d+\.\d+\.\d+$');
    if (!versionRegex.hasMatch(normalized)) {
      fail('Invalid --version format. Use x.y.z');
    }

    if (normalized == currentName) {
      newName = normalized;
      newBuild = currentBuild + 1;
    } else {
      newName = normalized;
      newBuild = 1;
    }
  }

  final newVersionLine = 'version: $newName+$newBuild';
  final updatedContent = content.replaceFirst(regex, newVersionLine);

  if (updatedContent == content) {
    fail('Failed to update pubspec.yaml version line');
  }

  pubspecFile.writeAsStringSync(updatedContent);

  return VersionInfo(buildName: newName, buildNumber: newBuild);
}

Future<void> buildAndroidApk(VersionInfo version) async {
  logSection('Android APK');

  await runCommand('flutter', [
    'build',
    'apk',
    '--release',
    '--build-name=${version.buildName}',
    '--build-number=${version.buildNumber}',
  ]);

  success('Android APK built');
}

Future<void> buildAndroidBundle(VersionInfo version) async {
  logSection('Android App Bundle');

  await runCommand('flutter', [
    'build',
    'appbundle',
    '--release',
    '--build-name=${version.buildName}',
    '--build-number=${version.buildNumber}',
  ]);

  success('Android App Bundle built');
}

Future<void> buildWeb(VersionInfo version) async {
  logSection('Web');

  await runCommand('flutter', [
    'build',
    'web',
    '--release',
    '--build-name=${version.buildName}',
    '--build-number=${version.buildNumber}',
  ]);

  success('Web build created');
}

Future<void> buildWindows(VersionInfo version) async {
  logSection('Windows');

  await runCommand('flutter', [
    'build',
    'windows',
    '--release',
    '--build-name=${version.buildName}',
    '--build-number=${version.buildNumber}',
  ]);

  success('Windows build created');
}

void syncMsixVersion({
  required File pubspecFile,
  required VersionInfo version,
}) {
  final content = pubspecFile.readAsStringSync();

  final msixVersion = '${version.buildName}.${version.buildNumber}';

  final hasMsixConfig = RegExp(
    r'^\s*msix_config\s*:\s*$',
    multiLine: true,
  ).hasMatch(content);

  if (!hasMsixConfig) {
    fail('msix_config section not found in pubspec.yaml');
  }

  final msixVersionRegex = RegExp(
    r'^(\s*msix_version\s*:\s*)(\d+\.\d+\.\d+\.\d+)\s*$',
    multiLine: true,
  );

  String updatedContent;

  if (msixVersionRegex.hasMatch(content)) {
    updatedContent = content.replaceFirst(
      msixVersionRegex,
      '  msix_version: $msixVersion',
    );
  } else {
    final msixConfigLineRegex = RegExp(
      r'^(\s*msix_config\s*:\s*$)',
      multiLine: true,
    );

    updatedContent = content.replaceFirst(
      msixConfigLineRegex,
      'msix_config:\n  msix_version: $msixVersion',
    );
  }

  if (updatedContent != content) {
    pubspecFile.writeAsStringSync(updatedContent);
    success('Updated msix_config.msix_version to $msixVersion');
  } else {
    info('msix_config.msix_version already set to $msixVersion');
  }
}

Future<void> buildWindowsMsix(VersionInfo version) async {
  logSection('Windows MSIX');

  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    fail('pubspec.yaml not found in project root');
  }

  syncMsixVersion(pubspecFile: pubspecFile, version: version);

  await buildWindows(version);

  final pubspecText = pubspecFile.readAsStringSync();

  final hasMsixConfig = RegExp(
    r'^\s*msix_config\s*:',
    multiLine: true,
  ).hasMatch(pubspecText);

  if (!hasMsixConfig) {
    fail('msix_config section not found in pubspec.yaml');
  }

  await runCommand('dart', ['run', 'msix:create']);

  // Optional extra signing only if env vars are configured.
  await trySignMsix();

  // Always verify final artifact signature.
  await verifyMsixSignature();

  success('Windows MSIX created and verified');
}

Future<void> verifyMsixSignature() async {
  final msixFile = findLatestMsixFile();

  if (msixFile == null || !msixFile.existsSync()) {
    fail('MSIX file not found for signature verification');
  }

  info('Verifying MSIX signature: ${msixFile.path}');

  final result = await Process.run('signtool', [
    'verify',
    '/pa',
    '/v',
    msixFile.path,
  ], runInShell: true);

  final stdoutText = (result.stdout ?? '').toString().trim();
  final stderrText = (result.stderr ?? '').toString().trim();

  if (stdoutText.isNotEmpty) {
    stdout.writeln(stdoutText);
  }
  if (stderrText.isNotEmpty) {
    stderr.writeln(stderrText);
  }

  if (result.exitCode != 0) {
    fail('MSIX signature verification failed');
  }

  success('MSIX signature verified successfully');
}

File? findLatestMsixFile() {
  final buildDir = Directory('build/windows');

  if (!buildDir.existsSync()) {
    return null;
  }

  final msixFiles =
      buildDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.toLowerCase().endsWith('.msix'))
          .toList();

  if (msixFiles.isEmpty) {
    return null;
  }

  msixFiles.sort((a, b) {
    final aModified = a.statSync().modified;
    final bModified = b.statSync().modified;
    return bModified.compareTo(aModified);
  });

  return msixFiles.first;
}

Future<void> trySignMsix() async {
  final certPath = Platform.environment['SCAVIUM_CERT_PATH'];
  final certPassword = Platform.environment['SCAVIUM_CERT_PASSWORD'];

  if (certPath == null || certPassword == null) {
    info('Skipping extra signtool signing (env certificate not configured)');
    return;
  }

  final msixFile = findLatestMsixFile();

  if (msixFile == null || !msixFile.existsSync()) {
    warn('MSIX file not found for signing');
    return;
  }

  info('Signing MSIX with signtool: ${msixFile.path}');

  await runCommand('signtool', [
    'sign',
    '/fd',
    'SHA256',
    '/f',
    certPath,
    '/p',
    certPassword,
    msixFile.path,
  ]);

  success('MSIX signed successfully with signtool');
}

Future<void> runCommand(String command, List<String> arguments) async {
  info('Running: $command ${arguments.join(' ')}');

  final process = await Process.start(
    command,
    arguments,
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    fail(
      'Command failed with exit code $exitCode: $command ${arguments.join(' ')}',
    );
  }
}

void showArtifacts() {
  logSection('Artifacts');

  final artifactPaths = <String>[
    'build/app/outputs/flutter-apk/app-release.apk',
    'build/app/outputs/bundle/release/app-release.aab',
    'build/web',
    'build/windows/x64/runner/Release',
    'build/windows/runner/Release',
    'build/windows',
  ];

  for (final path in artifactPaths) {
    final file = File(path);
    final dir = Directory(path);

    if (file.existsSync()) {
      success(file.path);
    } else if (dir.existsSync()) {
      success(dir.path);
    }
  }
}

void printUsage() {
  stdout.writeln('''
SCAVIUM Wallet build tool

Usage:
  dart run tool/build.dart [options]

Options:
  --platform <value>       android-apk | android-bundle | web | windows | windows-msix | all
  --version <x.y.z>        Override base version. If changed, build number resets to 1
  --no-version-bump        Do not modify pubspec.yaml version
  --skip-clean             Skip flutter clean
  --skip-pub-get           Skip flutter pub get
  --help, -h               Show this help

Examples:
  dart run tool/build.dart --platform all
  dart run tool/build.dart --platform android-bundle
  dart run tool/build.dart --platform all --version 0.2.2
  dart run tool/build.dart --platform windows-msix --no-version-bump
''');
}

void logSection(String text) {
  stdout.writeln('');
  stdout.writeln('========================================');
  stdout.writeln(text);
  stdout.writeln('========================================');
}

void info(String text) {
  stdout.writeln('[INFO] $text');
}

void success(String text) {
  stdout.writeln('[OK] $text');
}

void warn(String text) {
  stdout.writeln('[WARN] $text');
}

Never fail(String text) {
  stderr.writeln('[ERROR] $text');
  exit(1);
}
