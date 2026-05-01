# Current Task — 8.5.2

Project: SCAVIUM Wallet
Phase: 8.5 — Security, Reliability & Diagnostics Maturity
Subphase: 8.5.2 — Signing Safety Copy and Confirmation Hardening
Type: code

## Goal

Strengthen message-signing safety copy, validation clarity, confirmation behavior, cancellation handling, and result display without changing Phase 8.3 signing architecture.

## Scope

Keep signing explicit and separate from transactions. Do not add dApp connectivity, WalletConnect, automatic challenge ingestion, transaction submission, or background signing.

## Allowed Files

- `lib/features/signing/domain/signing_request.dart`
- `lib/features/signing/application/signing_controller.dart`
- `lib/features/signing/presentation/signing_screen.dart`
- `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart`
- `lib/features/signing/presentation/widgets/signing_result_card.dart`
- `lib/shared/widgets/feedback/app_snackbar.dart`
- `test/signing_request_test.dart`
- `test/signing_controller_test.dart`
- `test/signing_screen_test.dart`
- `test/signing_safety_copy_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Preserve signing service/controller/domain/presentation separation.
- Keep active-account verification intact.
- Improve warnings for personal message and challenge signing.
- Make confirmation copy explicit that signing is not sending a transaction.
- Keep cancellation non-mutating.
- Create `test/signing_safety_copy_test.dart` only if existing signing tests become too broad.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/signing_request_test.dart test/signing_controller_test.dart test/signing_screen_test.dart
```

## Acceptance

Signing still requires explicit preview/confirmation; cancellation does not mutate state; no transaction history entry is created; result copy is clear and safe.
