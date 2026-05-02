# Current Task — 8.5.3

Project: SCAVIUM Wallet
Phase: 8.5 — Security, Reliability & Diagnostics Maturity
Subphase: 8.5.3 — Backup and Recovery Warning Reliability
Type: code

## Goal

Improve backup and recovery warning reliability so export, restore, password, compatibility, and invalid-payload states are explicit and safe.

## Scope

Preserve backup encryption semantics and backup payload compatibility. Do not change payload format unless a real defect is found and reported before editing.

## Allowed Files

- `lib/features/settings/presentation/export_backup_screen.dart`
- `lib/features/wallet/presentation/restore_backup_screen.dart`
- `lib/features/wallet/application/wallet_backup_controller.dart`
- `lib/features/wallet/domain/wallet_backup_payload.dart`
- `lib/core/services/backup_crypto_service.dart`
- `test/wallet_backup_payload_test.dart`
- `test/backup_recovery_warning_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Improve export and restore warning copy without weakening existing password gating.
- Normalize unsafe or confusing backup/restore errors only inside existing ownership boundaries.
- Preserve v1/v2 and multi-account compatibility semantics.
- Do not expose password, key, mnemonic, encrypted payload, or raw backup content in UI/errors.
- Create `test/backup_recovery_warning_test.dart` only if existing tests cannot cover the focused warning behavior.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/wallet_backup_payload_test.dart test/backup_recovery_warning_test.dart
```

## Acceptance

Backup export remains password-gated; restore remains explicit; invalid payloads fail safely; compatibility remains intact; no secret material appears in messages.
