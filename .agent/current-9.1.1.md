# Current Task — 9.1.1

Project: SCAVIUM Wallet
Phase: 9.1 — Runtime App Version Surface
Subphase: 9.1.1 — Runtime Version Metadata Boundary
Type: Code-only implementation

## Goal

Introduce a minimal runtime app identity/version boundary that can expose app name, semantic version, build number, and display label without coupling Settings UI directly to platform/package APIs.

## Scope

- Add runtime metadata support only if needed by the selected strategy.
- Create the smallest app identity boundary under `lib/core/app_identity/`.
- Centralize version display formatting.
- Do not change Settings UI yet beyond what is required for compile safety.

## Allowed Files

- `pubspec.yaml`
- `pubspec.lock`
- `lib/core/app_identity/app_version_info.dart`
- `lib/core/app_identity/app_version_provider.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Inspect only the allowed files before planning.
- If using `package_info_plus`, add it to `pubspec.yaml` but do not run `flutter pub get`; tell the user to run it.
- Implement a small `AppVersionInfo` value object with a stable display label.
- Implement a Riverpod provider/service boundary that Settings can override in tests.
- Keep names and structure aligned with existing `lib/core` and Riverpod patterns.
- Do not edit docs, release tooling, theme files, routing, wallet, assets, signing, backup, or diagnostics code.

## Validation (manual)

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test test/app_version_info_test.dart
```

## Acceptance

- App identity/version boundary exists.
- Display formatting is centralized.
- Settings does not directly depend on package/platform APIs.
- No unrelated code or documentation is modified.