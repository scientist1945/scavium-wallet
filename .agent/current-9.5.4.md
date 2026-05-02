# Current Task — 9.5.4

Project: SCAVIUM Wallet
Phase: 9.5 — Theme Mode Runtime Selection and Persistence
Subphase: 9.5.4 — Settings Appearance Selector and UX Integration
Type: Code-only

## Goal

Expose the runtime theme-mode preference through Settings without turning 9.5 into a broader Settings/About redesign.

## Scope

- Add an Appearance section or compact selector to Settings.
- Present clear labels for system, light, and dark modes.
- Update the theme-mode controller when the user selects a mode.
- Reflect the currently selected mode in the UI.
- Preserve existing Settings sections for Security & recovery, Signing, Diagnostics, Danger zone, and About.
- Defer broader Settings/About layout polish to 9.6.

## Allowed Files

- `lib/features/settings/presentation/settings_screen.dart`
- `lib/features/settings/presentation/widgets/settings_section_card.dart` (inspect only; modify only if needed for existing section-card behavior)
- `lib/features/settings/presentation/widgets/theme_mode_selector.dart` (new, optional)
- `lib/app/theme/theme_mode_preference.dart`
- `lib/app/theme/theme_mode_controller.dart`
- `test/settings_screen_test.dart`
- `test/theme_mode_selector_test.dart` (new, optional)

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Keep the selector bounded to `system`, `light`, and `dark`.
- Prefer a small extracted widget only if it keeps `settings_screen.dart` readable.
- Preserve existing Settings section order and behavior unless a minimal Appearance placement is required.
- Do not modify Security & recovery, Signing, Diagnostics, Danger zone, About behavior except for necessary layout insertion.
- Do not implement broader Settings/About polish; that belongs to 9.6.
- Do not change persistence serialization, app-root wiring, tokens, theme construction, docs, `.agent/*`, wallet flows, release tooling, or generated files.
- Add or update focused widget tests for labels, current selection, and update behavior with provider overrides where practical.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/settings_screen_test.dart
```

## Acceptance

- Settings exposes an Appearance control for system/light/dark.
- The selected value reflects provider state.
- User selection updates the controller.
- Existing Settings sections and destructive/security/diagnostics behavior remain intact.
- No docs, token/theme construction, release, routing, or unrelated changes are introduced by this subphase.