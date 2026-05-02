# Current Task — 9.3.3

Project: SCAVIUM Wallet
Phase: 9.3 — Theme Token Normalization
Subphase: 9.3.3 — ThemeData and Shared Widget Token Adoption
Type: Code-only implementation

## Goal

Adopt the normalized 9.3 token vocabulary in the active dark `ThemeData` and shared SCAVIUM widgets without changing runtime theme mode or broad screen behavior.

## Scope

- Rebuild or refine `AppTheme.darkTheme` from normalized token names.
- Align shared cards, inputs, primary/secondary buttons, section titles, snackbar/dialog feedback components, and shared scaffold where they directly own visual constants.
- Keep screen-level edits minimal and only when required by shared-widget token adoption.
- Preserve current navigation, Settings/About version display, signing, assets, activity, backup, diagnostics, and release behavior.

## Allowed Files

- `lib/app/theme/app_theme.dart`
- `lib/app/theme/app_text_styles.dart`
- `lib/app/theme/app_colors.dart`
- `lib/app/theme/tokens/scavo_colors.dart`
- `lib/app/theme/tokens/scavo_spacing.dart`
- `lib/app/theme/tokens/scavo_radius.dart`
- `lib/app/theme/tokens/scavo_elevation.dart`
- `lib/app/theme/tokens/scavo_typography.dart`
- `lib/app/theme/tokens/scavo_tokens.dart`
- `lib/shared/widgets/scavium_card.dart`
- `lib/shared/widgets/scavium_text_field.dart`
- `lib/shared/widgets/scavium_primary_button.dart`
- `lib/shared/widgets/scavium_secondary_button.dart`
- `lib/shared/widgets/section_title.dart`
- `lib/shared/widgets/feedback/app_snackbar.dart`
- `lib/shared/widgets/feedback/confirm_dialog.dart`
- `test/app_theme_tokens_test.dart`
- `test/widget_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- First inspect the allowed shared widgets and existing theme/token files.
- Replace direct legacy visual coupling with token/facade usage only where it improves the shared visual contract.
- Prefer centralized theme values over per-widget duplication.
- Do not create new screens, routes, services, providers, repositories, platform files, generated assets, or documentation.
- Do not introduce `AppTheme.lightTheme`, `ThemeMode.system`, Settings appearance controls, or local persistence.
- Update or add focused widget/token tests only if needed for deterministic coverage of the changed shared theme surface.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_theme_tokens_test.dart test/widget_test.dart
```

## Acceptance

- Active dark theme and shared widgets consume the normalized token vocabulary coherently.
- Visual behavior remains dark-only and functionally compatible.
- Shared widget changes are bounded to theme/token adoption.
- No feature flow, persistence, release, CI, git, or documentation files are modified.