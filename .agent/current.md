# Current Task — Phase 8.2.4

Project: SCAVIUM Wallet
Phase: 8.2 — Asset & Portfolio Expansion
Subphase: 8.2.4 — Asset Surface Polish
Type: code

## Goal

Improve asset list presentation for mobile, web, and desktop-sized layouts without introducing a new navigation shell or documentation changes.

## Scope

Polish existing asset display, native/token distinction, empty/loading/error states, and portfolio summary visibility if implemented by previous 8.2 subphases.

## Allowed Files

- `lib/features/assets/presentation/assets_screen.dart`
- `lib/features/assets/presentation/asset_detail_screen.dart`
- `lib/features/assets/presentation/add_token_screen.dart` only if needed for consistency
- `lib/shared/widgets/**` only if a tiny reusable UI helper is needed
- `test/**` only for focused tests if needed

## Forbidden

- `docs/**`
- `README.md`
- router redesign
- drawer/sidebar/bottom navigation shell changes
- transaction/signing maturity
- backup/storage changes
- automatic token discovery
- multi-chain support

## Implementation Requirements

- Keep current route names intact.
- Keep `GoRouter` behavior intact.
- Preserve send/receive/token flows.
- Improve responsive presentation without overbuilding the Phase 8.4 navigation scope.
- Maintain safe loading, empty, and error states.

## Validation

Run:

```bash
fvm flutter analyze
fvm flutter test
```

Fallback:

```bash
flutter analyze
flutter test
```

## Acceptance

- Asset list remains functional.
- Presentation improves without route or architecture churn.
- No documentation files are modified.
- Validation passes or remaining failures are unrelated and explicitly reported.
