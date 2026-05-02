# Current Task — 8.6.1

Project: SCAVIUM Wallet
Phase: 8.6 — Release & Distribution Maturity Extension
Subphase: 8.6.1 — Build Tool Artifact and Version Consistency Maturity
Type: code

## Goal

Mature local build automation so release operators get deterministic version, artifact, and summary output while preserving `tool/build.dart` as the release-tool owner.

## Scope

Improve artifact reporting, version/MSIX consistency checks, build summaries, and safe operator feedback. Do not replace the build tool or change runtime wallet behavior.

## Allowed Files

- `tool/build.dart`
- `pubspec.yaml`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Read only `tool/build.dart` and `pubspec.yaml` before proposing edits.
- Preserve supported platforms: `android-apk`, `android-bundle`, `web`, `windows`, `windows-msix`, and `all`.
- Preserve `--check-version`, `--expected-tag`, `--no-version-bump`, and `--skip-clean`.
- Keep MSIX version synchronized with `pubspec.yaml`.
- Improve deterministic artifact/version reporting without claiming success for missing artifacts.
- Touch `pubspec.yaml` only if a real version/MSIX metadata correction is required.

## Validation (manual)

```bash
fvm flutter analyze
dart run tool/build.dart --check-version --expected-tag v0.2.1
```

## Acceptance

Existing build options remain compatible; version/MSIX behavior remains deterministic; artifact reporting is clearer and does not hide missing outputs.