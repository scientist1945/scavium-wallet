# Current Task — 9.1.2

Project: SCAVIUM Wallet
Phase: 9.1 — Runtime App Version Surface
Subphase: 9.1.2 — Settings/About Runtime Version Integration
Type: Code-only implementation

## Goal

Replace the hardcoded About version text in Settings with data from the runtime app identity/version boundary.

## Scope

- Convert the About tile from static copy to provider-backed version display.
- Preserve existing Settings sections and visual structure.
- Keep fallback behavior quiet and product-safe.
- Do not redesign Settings or introduce theme controls.

## Allowed Files

- `lib/features/settings/presentation/settings_screen.dart`
- `lib/core/app_identity/app_version_info.dart`
- `lib/core/app_identity/app_version_provider.dart`
- `test/settings_screen_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Read the allowed files and current Settings test before planning.
- Remove the stale literal `Version 0.4.0` from Settings runtime UI.
- Use the provider boundary from 9.1.1.
- Preserve `SCAVIUM Wallet` About title and existing section order.
- If async metadata is used, render a safe deterministic fallback until metadata resolves.
- Do not modify documentation or unrelated features.

## Validation (manual)

```bash
fvm flutter test test/settings_screen_test.dart
fvm flutter analyze
```

## Acceptance

- About still renders `SCAVIUM Wallet`.
- The hardcoded stale version literal is removed from Settings UI code.
- Displayed version comes from the app identity/version boundary.
- Existing Settings behavior remains intact.