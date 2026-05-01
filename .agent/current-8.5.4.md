# Current Task — 8.5.4

Project: SCAVIUM Wallet
Phase: 8.5 — Security, Reliability & Diagnostics Maturity
Subphase: 8.5.4 — Lock, Lifecycle, and Sensitive Surface Reliability
Type: code

## Goal

Improve reliability around lifecycle locking, screenshot protection, and sensitive route behavior without moving security ownership into shell widgets.

## Scope

Preserve GoRouter as routing owner and AppShell as navigation chrome only. Keep onboarding, wallet-entry, lock, detail, action, diagnostics, and shell route boundaries explicit.

## Allowed Files

- `lib/core/security/app_lifecycle_guard.dart`
- `lib/core/security/lock_policy.dart`
- `lib/core/security/screenshot_guard.dart`
- `lib/app/router/app_route_category.dart`
- `lib/app/router/app_router.dart`
- `lib/app/shell/app_shell.dart`
- `test/app_route_category_test.dart`
- `test/app_shell_test.dart`
- `test/app_lifecycle_guard_test.dart`
- `test/sensitive_route_guard_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Review lifecycle lock/refresh ordering and harden only if needed.
- Keep lock-aware redirects centralized in `app_router.dart`.
- Harden screenshot guard platform/failure handling only if current behavior can affect runtime stability.
- Update route categories only if sensitive route classification requires it.
- Create lifecycle/route guard tests only if existing tests cannot cover the change.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_route_category_test.dart test/app_shell_test.dart test/widget_test.dart
```

## Acceptance

Lock-aware routing remains centralized; shell remains presentation-only; sensitive routes stay explicit; lifecycle/screenshot failures fail safely.
