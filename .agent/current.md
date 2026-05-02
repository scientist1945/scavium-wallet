# Current Task — 9.6.3

Project: SCAVIUM Wallet
Phase: 9.6 — Settings and About UX Alignment
Subphase: 9.6.3 — Appearance Selector UX and Accessibility Polish
Type: Code-only

## Goal

Polish the existing Appearance selector for clarity, accessibility, selected-state feedback, and narrow/wide layout without changing persistence ownership.

## Scope

- Improve `ThemeModeSelector` presentation only.
- Preserve `ThemeModeController` as the state boundary and `ThemeModePreference` as the value/label boundary.
- Adjust preference labels/descriptions only if required for UX clarity and covered by tests.

## Allowed Files

- `lib/features/settings/presentation/widgets/theme_mode_selector.dart`
- `lib/app/theme/theme_mode_preference.dart` (only if labels/descriptions need correction)
- `test/theme_mode_selector_test.dart`
- `test/theme_mode_preference_test.dart` (only if preference labels/descriptions change)

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Do not change storage values: `system`, `light`, `dark`.
- Do not change repository/provider/app-root theme-mode wiring.
- Do not modify Settings section hierarchy unless strictly necessary to host the selector polish; if needed, stop and ask approval to include `settings_screen.dart`.
- Do not modify docs, `.agent/*`, routing, release tooling, platform files, generated files, or unrelated tests.
- Add or adjust focused tests for selector rendering, selected value, and preference update behavior.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/theme_mode_selector_test.dart test/theme_mode_preference_test.dart
```

## Acceptance

- Appearance selector remains wired to `themeModeControllerProvider`.
- Selector labels/descriptions are clear and accessible.
- Selecting System/Light/Dark still saves the selected preference.
- No persistence or app-root logic is duplicated.
