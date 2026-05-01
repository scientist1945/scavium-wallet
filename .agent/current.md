# Current Task — 8.4.2

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.2 — Responsive App Shell Foundation
Type: code

## Goal

Introduce a reusable responsive authenticated product shell for primary wallet destinations without moving feature state into shell code.

## Scope

Add shell structure for Home, Assets, Activity/History, Settings, and any route inventory from 8.4.1. Keep public, lock, detail, and action routes safe.

## Allowed Files

- `lib/shared/widgets/scavium_scaffold.dart`
- `lib/app/router/app_router.dart`
- `lib/app/router/route_names.dart`
- `lib/features/home/presentation/home_screen.dart`
- `lib/features/assets/presentation/assets_screen.dart`
- `lib/features/assets/presentation/history_screen.dart`
- `lib/features/settings/presentation/settings_screen.dart`
- `lib/app/shell/app_shell.dart`
- `lib/app/shell/app_shell_destination.dart`
- `lib/app/shell/responsive_navigation.dart`
- `test/app_shell_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Build a shell only around authenticated primary destinations.
- Use responsive navigation suitable for compact and wide layouts.
- Keep Riverpod controllers in feature modules.
- Do not introduce route loops.
- Preserve `ScaviumScaffold` compatibility for secondary/action screens.
- Create shell files only if needed by real implementation.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_shell_test.dart test/widget_test.dart
```

## Acceptance

Primary destinations render through shell; public/onboarding/lock routes stay outside; no feature state is owned by shell.
