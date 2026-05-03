# Current Task — 9.5.2

Project: SCAVIUM Wallet
Phase: 9.5 — Theme Mode Runtime Selection and Persistence
Subphase: 9.5.2 — Theme Mode Preference Model and Local Persistence
Type: Code-only

## Goal

Introduce the local preference model and persistence boundary for `system`, `light`, and `dark` theme modes.

## Scope

- Add a small theme-mode preference value model or enum-like owner.
- Map supported values to Flutter `ThemeMode.system`, `ThemeMode.light`, and `ThemeMode.dark`.
- Persist the selected value as a stable local string.
- Missing or invalid stored values must fall back safely, preferably to `system`.
- Keep persistence local-only and unrelated to wallet, blockchain, backup, diagnostics, release, and CI behavior.

## Allowed Files

- `lib/core/constants/storage_keys.dart`
- `lib/core/services/local_storage_service.dart` (inspect/reuse; modify only for a generic helper if truly required)
- `lib/core/providers/service_providers.dart` (inspect/reuse; modify only if needed for provider exposure)
- `lib/app/theme/app_theme.dart` (inspect only)
- `lib/app/theme/theme_mode_preference.dart` (new)
- `lib/app/theme/theme_mode_repository.dart` (new, optional)
- `lib/app/theme/theme_mode_repository_impl.dart` (new, optional)
- `test/theme_mode_preference_test.dart` (new)

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Add one centralized storage key such as `themeModePreference`.
- Keep string values stable: `system`, `light`, `dark`.
- Avoid literal preference strings outside the preference model/repository boundary.
- Prefer a small repository only if it reduces coupling between the future controller and `LocalStorageService`.
- Do not change `lib/app/app.dart`; app-root wiring belongs to 9.5.3.
- Do not change Settings UI; selector integration belongs to 9.5.4.
- Do not change tokens, palettes, `ThemeData`, docs, `.agent/*`, routing, wallet flows, release tooling, or generated files.
- Add focused tests for parsing, serialization, fallback, and Flutter `ThemeMode` mapping.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/theme_mode_preference_test.dart
```

## Acceptance

- Supported values `system`, `light`, and `dark` are modeled centrally.
- Each value maps to the expected Flutter `ThemeMode`.
- Missing or invalid stored values fall back safely.
- Preference persistence uses the existing `LocalStorageService` path.
- No app-root runtime switching, Settings selector, docs, or token/theme construction changes are introduced by this subphase.