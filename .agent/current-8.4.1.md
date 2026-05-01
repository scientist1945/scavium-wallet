# Current Task — 8.4.1

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.1 — Route Inventory and Shell Navigation Contract
Type: code

## Goal

Classify existing routes into primary destinations and secondary/detail/action routes before visible shell chrome is added.

## Scope

Preserve current named routes, lock-aware redirects, onboarding/wallet-entry behavior, and direct reachability. Add route metadata only if it prevents duplicated shell decisions.

## Allowed Files

- `lib/app/router/route_names.dart`
- `lib/app/router/app_router.dart`
- `lib/features/home/presentation/home_screen.dart`
- `test/widget_test.dart`
- `lib/app/router/app_route_category.dart`
- `test/app_route_category_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Keep GoRouter as routing owner.
- Do not rename existing routes unless required by real code.
- Keep onboarding, lock, splash, wallet-entry, detail, and action routes outside primary shell assumptions.
- Add `app_route_category.dart` only if classification would otherwise be duplicated.
- Keep changes minimal and prepare 8.4.2 without implementing full shell UI here.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/widget_test.dart
```

## Acceptance

Existing routes remain reachable; guards still work; primary vs secondary route classification is explicit enough for 8.4.2.
