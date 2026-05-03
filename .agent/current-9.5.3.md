# Current Task — 9.5.3

Project: SCAVIUM Wallet
Phase: 9.5 — Theme Mode Runtime Selection and Persistence
Subphase: 9.5.3 — Reactive App Root Theme Mode Wiring
Type: Code-only

## Goal

Wire the persisted theme-mode preference into `ScaviumWalletApp` so runtime selection becomes reactive at the application root.

## Scope

- Add a Riverpod controller/provider that loads the persisted preference and exposes the selected mode.
- Update `ScaviumWalletApp` to watch the selected mode.
- Pass `theme: AppTheme.lightTheme`, `darkTheme: AppTheme.darkTheme`, and selected `themeMode` into `MaterialApp.router`.
- Preserve router, lifecycle guard, lock behavior, wallet behavior, onboarding behavior, diagnostics, and release behavior.
- Use a deterministic safe fallback while preference loading completes.

## Allowed Files

- `lib/app/app.dart`
- `lib/app/theme/theme_mode_preference.dart`
- `lib/app/theme/theme_mode_repository.dart` (if created by 9.5.2)
- `lib/app/theme/theme_mode_repository_impl.dart` (if created by 9.5.2)
- `lib/app/theme/theme_mode_controller.dart` (new)
- `lib/core/providers/service_providers.dart`
- `test/theme_mode_controller_test.dart` (new)
- `test/widget_test.dart` (only if app-root expectations are affected)

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Build on the 9.5.2 preference/repository contract; do not duplicate storage logic in `app.dart`.
- Keep `ScaviumWalletApp` as a `ConsumerStatefulWidget` and preserve `AppLifecycleGuard` observer behavior.
- Replace the hardcoded `ThemeMode.dark` runtime setting with provider-driven selected mode.
- Ensure `MaterialApp.router` uses `theme: AppTheme.lightTheme` and `darkTheme: AppTheme.darkTheme`.
- Keep router provider wiring unchanged.
- Do not add Settings UI; that belongs to 9.5.4.
- Do not alter token values, theme construction, docs, `.agent/*`, wallet flows, release tooling, or generated files.
- Add focused tests for initial/fallback state, persisted load, update persistence, and app-root theme-mode wiring where practical.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/theme_mode_controller_test.dart test/widget_test.dart
```

## Acceptance

- `MaterialApp.router` no longer forces `ThemeMode.dark`.
- `theme`, `darkTheme`, and provider-selected `themeMode` are wired at the app root.
- Preference loading has a safe deterministic fallback.
- Router and lifecycle guard behavior remain unchanged.
- No Settings selector, docs, token/theme construction, or unrelated behavior changes are introduced by this subphase.