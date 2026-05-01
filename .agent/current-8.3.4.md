# Current Task — 8.3.4

Project: SCAVIUM Wallet
Phase: 8.3 — Transaction & Activity Maturity
Subphase: 8.3.4 — Message Signing Domain and Service Boundary
Type: code

## Goal

Introduce a safe non-UI signing domain/service boundary for personal and challenge messages.

## Scope

Add signing foundation only. No transaction submission, balance mutation, or history mutation.

## Allowed Files

- `lib/features/blockchain/data/scavium_rpc_service.dart`
- `lib/features/wallet/domain/wallet_repository.dart`
- `lib/features/wallet/data/wallet_repository_impl.dart`
- `lib/features/wallet/application/wallet_controller.dart`
- `lib/core/errors/app_exception.dart`
- `lib/core/utils/evm_format.dart`
- `lib/features/signing/domain/signing_request.dart`
- `lib/features/signing/domain/signing_result.dart`
- `lib/features/signing/domain/signing_mode.dart`
- `lib/features/signing/application/signing_controller.dart`
- `test/signing_request_test.dart`
- `test/signing_controller_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Implement `signPersonalMessage(...)` and `signChallengeMessage(...)` behind explicit domain/service boundaries.
- Bind signing to the intended active account.
- Keep private-key-sensitive logic out of presentation code.
- Normalize errors consistently.
- Do not create transaction history entries or send RPC transactions.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/signing_request_test.dart test/signing_controller_test.dart
```

## Acceptance

Signing works through domain/controller boundaries; no history/balance/transaction side effects; intended active account is used.