# Current Task — 8.5.5

Project: SCAVIUM Wallet
Phase: 8.5 — Security, Reliability & Diagnostics Maturity
Subphase: 8.5.5 — Error Boundary and Invalid State Maturity
Type: code

## Goal

Normalize user-facing error and invalid-state behavior across account-aware assets, activity, signing, backup, diagnostics, and settings surfaces.

## Scope

Reuse AppException, StateMessage, AppSnackbar, async UI helpers, and controller-level patterns. Avoid broad rewrites or a premature global error framework.

## Allowed Files

- `lib/core/errors/app_exception.dart`
- `lib/core/utils/async_value_ui.dart`
- `lib/shared/widgets/feedback/state_message.dart`
- `lib/shared/widgets/feedback/app_snackbar.dart`
- `lib/features/assets/application/assets_controller.dart`
- `lib/features/assets/application/tx_history_controller.dart`
- `lib/features/blockchain/application/send_transaction_controller.dart`
- `lib/features/blockchain/application/send_token_controller.dart`
- `lib/features/settings/presentation/settings_screen.dart`
- `test/tx_history_controller_test.dart`
- `test/token_registry_safety_test.dart`
- `test/settings_screen_test.dart`
- `test/app_error_boundary_test.dart`
- `test/invalid_state_maturity_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Improve missing wallet/profile/account, invalid token/transaction, backup, RPC, signing mismatch, and secondary-action states only where real code requires it.
- Do not destroy local state on refresh/read errors.
- Do not include wallet addresses, private keys, mnemonic material, passwords, signatures, or backup payload content in error text.
- Create focused error/invalid-state tests only if existing tests are insufficient.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/tx_history_controller_test.dart test/token_registry_safety_test.dart test/settings_screen_test.dart
```

## Acceptance

Invalid states are safe and actionable; existing local data is preserved; sensitive values are not leaked; retry/cancel flows remain predictable.
