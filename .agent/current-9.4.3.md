# Current Task — 9.4.3

Project: SCAVIUM Wallet
Phase: 9.4 — Light/Dark Theme Implementation
Subphase: 9.4.3 — Component and Navigation Theme Coherence
Type: Code-only

## Goal

Ensure shared components and shell/navigation surfaces remain coherent with the paired light/dark theme contract without adding screen-local theme branches.

## Scope

- Inspect shared cards, inputs, buttons, feedback surfaces, Settings section cards, and responsive navigation.
- Move reusable color behavior into `ThemeData` where appropriate.
- Keep local widget styling limited to structure, spacing, radius, and semantic intent.
- Preserve wallet, asset, signing, backup, diagnostics, routing, persistence, and release behavior.

## Allowed Files

- `lib/app/theme/app_theme.dart`
- `lib/app/shell/responsive_navigation.dart`
- `lib/features/settings/presentation/widgets/settings_section_card.dart`
- `lib/shared/widgets/scavium_card.dart`
- `lib/shared/widgets/scavium_primary_button.dart`
- `lib/shared/widgets/scavium_secondary_button.dart`
- `lib/shared/widgets/scavium_text_field.dart`
- `lib/shared/widgets/feedback/app_snackbar.dart`
- `lib/shared/widgets/feedback/confirm_dialog.dart`
- `test/app_theme_tokens_test.dart`
- `test/app_theme_light_dark_test.dart` (if already created in 9.4.2)
- `test/app_shell_test.dart`
- `test/settings_screen_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Do not introduce runtime theme selection or persisted preferences.
- Do not add feature-screen light/dark conditionals.
- Prefer app-level component themes and token-owned colors.
- Keep changes minimal and compatible with existing tests.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_theme_tokens_test.dart test/app_shell_test.dart test/settings_screen_test.dart
```

## Acceptance

- Shared components render from theme/token-owned values where 9.4 requires it.
- Navigation and Settings surfaces are compatible with both theme definitions.
- No docs, runtime selector, persistence, or Settings appearance control is added.
