# Current Task — 9.1.3

Project: SCAVIUM Wallet
Phase: 9.1 — Runtime App Version Surface
Subphase: 9.1.3 — Runtime Version Surface Test Coverage
Type: Code-only implementation

## Goal

Add focused tests proving that the Settings/About version surface is dynamic, deterministic under test, and not dependent on local runtime package metadata.

## Scope

- Extend Settings widget coverage with provider overrides or mocks.
- Add focused AppVersionInfo formatting coverage if a value object exists.
- Avoid assertions that depend on machine-local build artifacts.
- Keep tests scoped and low-noise.

## Allowed Files

- `test/settings_screen_test.dart`
- `test/app_version_info_test.dart`
- `lib/core/app_identity/app_version_info.dart`
- `lib/core/app_identity/app_version_provider.dart`
- `lib/features/settings/presentation/settings_screen.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Read only the allowed files before planning.
- Prefer a provider override with a fixed test value such as `0.2.2+1`.
- Validate display-label formatting without depending on `PackageInfo.fromPlatform()` in widget tests.
- Keep existing Settings section assertions.
- Do not add broad golden tests or unrelated widget coverage.

## Validation (manual)

```bash
fvm flutter test test/settings_screen_test.dart test/app_version_info_test.dart
fvm flutter analyze
```

## Acceptance

- Tests prove the About section renders deterministic dynamic version text.
- Tests do not rely on platform package metadata.
- Existing Settings tests continue to cover the organized sections.
- No unrelated tests or documentation are modified.