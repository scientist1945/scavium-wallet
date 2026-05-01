# Current Task — 8.4.4

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.4 — Wallet and Account Surface Placement
Type: code

## Goal

Place account-oriented wallet controls deliberately within the navigation model while preserving wallet ownership and backup compatibility.

## Scope

Decide whether account management remains on Home or becomes a dedicated Wallet/Accounts surface. Do not expand account deletion/label editing unless already present in code.

## Allowed Files

- `lib/features/wallet/presentation/account_switcher.dart`
- `lib/features/wallet/presentation/add_account_sheet.dart`
- `lib/features/wallet/application/wallet_controller.dart`
- `lib/features/home/presentation/home_screen.dart`
- `lib/app/router/route_names.dart`
- `lib/app/router/app_router.dart`
- `test/asset_account_context_test.dart`
- `test/wallet_backup_payload_test.dart`
- `lib/features/wallet/presentation/accounts_screen.dart`
- `test/accounts_screen_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Keep `WalletController` as account-state owner.
- Preserve derived/imported account behavior.
- Preserve backup/restore compatibility.
- Add a Wallet/Accounts route only if it improves product clarity and follows 8.4.1/8.4.2 shell rules.
- Do not move reset/backup into shell chrome.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/asset_account_context_test.dart test/wallet_backup_payload_test.dart
```

## Acceptance

Active account selection works; account-aware assets remain correct; backup payload compatibility unchanged.
