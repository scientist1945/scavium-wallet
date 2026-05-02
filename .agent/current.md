# Current Task — 9.4.4

Project: SCAVIUM Wallet
Phase: 9.4 — Light/Dark Theme Implementation
Subphase: 9.4.4 — Light/Dark Theme Validation and Documentation Closure
Type: Code-only validation support

## Goal

Complete code-side validation support for the paired light/dark theme contract before the documentation closure is handled separately outside the agent.

## Scope

- Add or refine focused tests only if 9.4.2/9.4.3 left theme assertions incomplete.
- Confirm `AppTheme.lightTheme` and `AppTheme.darkTheme` both exist and expose the expected Material 3 contract.
- Confirm `MaterialApp.router` still does not expose runtime switching until 9.5.
- Do not perform the documentation closure in this agent task.

## Allowed Files

- `lib/app/app.dart` (read-only unless a prior 9.4 code task accidentally changed runtime switching and it must be reverted)
- `lib/app/theme/app_theme.dart`
- `lib/app/theme/tokens/scavo_colors.dart`
- `lib/app/theme/tokens/scavo_theme_colors.dart` (if created)
- `lib/app/theme/tokens/scavo_tokens.dart`
- `test/app_theme_tokens_test.dart`
- `test/app_theme_light_dark_test.dart` (if created)
- `test/app_shell_test.dart`
- `test/settings_screen_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Treat documentation closure as out of scope for the agent.
- Do not add runtime selector, persisted preference, system mode handling, or Settings appearance control.
- Prefer test-only changes unless a small code correction is required to satisfy the already implemented 9.4 contract.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_theme_tokens_test.dart test/app_shell_test.dart test/settings_screen_test.dart
fvm flutter test
```

## Acceptance

- Theme tests cover the paired light/dark contract sufficiently for 9.4 closure.
- `lib/app/app.dart` remains dark-forced for runtime behavior.
- No documentation is modified by the agent.
