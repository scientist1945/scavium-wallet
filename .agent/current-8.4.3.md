# Current Task — 8.4.3

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.3 — Dashboard and Product Surface Segmentation
Type: code

## Goal

Reduce Home overload by making Home a summary dashboard while product surfaces own detailed workflows.

## Scope

Keep balance/account/network summary and recent activity preview on Home. Avoid duplicating shell navigation. Preserve intentional quick actions for send, receive, signing, and explorer flows.

## Allowed Files

- `lib/features/home/presentation/home_screen.dart`
- `lib/features/wallet/presentation/account_switcher.dart`
- `lib/features/assets/presentation/assets_screen.dart`
- `lib/features/assets/presentation/history_screen.dart`
- `lib/features/assets/presentation/transaction_detail_screen.dart`
- `test/portfolio_summary_test.dart`
- `test/transaction_detail_screen_test.dart`
- `lib/features/home/presentation/widgets/dashboard_balance_card.dart`
- `lib/features/home/presentation/widgets/dashboard_recent_activity_card.dart`
- `test/home_screen_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Keep Home as summary, not a replacement for Assets/Activity/Settings.
- Preserve account switching unless 8.4.4 moves it deliberately.
- Recent activity preview must be read-only and open details intentionally.
- Do not duplicate feature state in Home-specific controllers.
- Extract widgets only if Home becomes too large.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/portfolio_summary_test.dart test/transaction_detail_screen_test.dart
```

## Acceptance

Home is usable on compact and wide layouts; feature routes remain reachable; no feature ownership moved into Home.
