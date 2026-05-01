# Current Task — 8.3.5

Project: SCAVIUM Wallet
Phase: 8.3 — Transaction & Activity Maturity
Subphase: 8.3.5 — Message Signing UX, Confirmation, and Result Display
Type: code

## Goal

Add explicit user-facing signing UX with preview, confirmation, cancellation, result display, and safe errors.

## Scope

Build on the signing boundary from 8.3.4. Keep signing visually distinct from sending transactions.

## Allowed Files

- `lib/app/router/route_names.dart`
- `lib/app/router/app_router.dart`
- `lib/features/home/presentation/home_screen.dart`
- `lib/features/settings/presentation/settings_screen.dart`
- `lib/features/wallet/presentation/account_switcher.dart`
- `lib/shared/widgets/feedback/confirm_dialog.dart`
- `lib/shared/widgets/feedback/app_snackbar.dart`
- `lib/shared/widgets/scavium_text_field.dart`
- `lib/features/signing/presentation/signing_screen.dart`
- `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart`
- `lib/features/signing/presentation/widgets/signing_result_card.dart`
- `test/signing_screen_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Show message/challenge, active account/address, action type, and result explicitly.
- Require confirmation before signing.
- Support cancellation without wallet mutation.
- Provide copy-to-clipboard for signature output.
- Add route/entry point only with minimal routing impact; do not implement Phase 8.4 navigation shell.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/signing_screen_test.dart
```

## Acceptance

Cancel changes nothing; success displays signature only; no transaction submission; route access remains compatible with guards.