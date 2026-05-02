# Current Task — 9.4.2

Project: SCAVIUM Wallet
Phase: 9.4 — Light/Dark Theme Implementation
Subphase: 9.4.2 — AppTheme Light and Dark ThemeData Construction
Type: Code-only

## Goal

Implement `AppTheme.lightTheme` and keep `AppTheme.darkTheme` as the compatible dark baseline, both built from the SCAVIUM token layer.

## Scope

- Add a complete light `ThemeData` beside the existing dark theme.
- Preserve current dark appearance and 9.3 token expectations.
- Keep `MaterialApp.router` forced to dark mode during this subphase.
- Add focused theme assertions only where needed.

## Allowed Files

- `lib/app/theme/app_theme.dart`
- `lib/app/theme/tokens/scavo_colors.dart`
- `lib/app/theme/tokens/scavo_tokens.dart`
- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_text_styles.dart`
- `test/app_theme_tokens_test.dart`
- `test/app_theme_light_dark_test.dart` (new, optional)
- `lib/app/theme/tokens/scavo_theme_colors.dart` (new, optional)

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Do not modify `lib/app/app.dart`; runtime switching belongs to 9.5.
- Prefer centralized helpers inside `AppTheme` or a token-layer owner over screen-local color branches.
- If creating `scavo_theme_colors.dart`, export it from `scavo_tokens.dart`.
- Keep compatibility facades stable unless a real implementation need requires a small additive alias.
- Add or update focused tests for light/dark theme brightness and key color-scheme/component-theme construction.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_theme_tokens_test.dart
```

## Acceptance

- `AppTheme.lightTheme` exists.
- `AppTheme.darkTheme` remains available and compatible.
- Light and dark themes expose correct `ColorScheme` brightness values.
- No runtime theme selector, persistence, Settings control, docs, or `.agent/*` changes are introduced by the code edit.
