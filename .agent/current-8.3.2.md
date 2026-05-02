# Current Task — 8.3.2

Project: SCAVIUM Wallet
Phase: 8.3 — Transaction & Activity Maturity
Subphase: 8.3.2 — Transaction Detail and Receipt-Oriented Activity View
Type: code

## Goal

Add a clearer first-party transaction detail/receipt-oriented experience for locally tracked activity.

## Scope

Improve transaction detail readability without adding explorer/indexer ownership.

## Allowed Files

- `lib/features/assets/presentation/history_screen.dart`
- `lib/app/router/route_names.dart`
- `lib/app/router/app_router.dart`
- `lib/features/assets/domain/tx_history_entry.dart`
- `lib/core/config/app_config.dart`
- `lib/shared/widgets/feedback/state_message.dart`
- `lib/shared/widgets/scavium_card.dart`
- `lib/features/assets/presentation/transaction_detail_screen.dart`
- `test/transaction_detail_screen_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Prefer a small dedicated detail screen only if warranted.
- Show hash, destination, amount, symbol, kind, status, timestamp, and receipt-oriented explanation.
- Preserve existing history refresh behavior.
- Keep explorer URL handling centralized/config-safe.
- Do not introduce full chain activity discovery.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/transaction_detail_screen_test.dart
```

## Acceptance

History remains usable; detail route/presentation works; explorer link still works; no route guard regression.