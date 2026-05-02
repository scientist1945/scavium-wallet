# Current Task — 8.3.1

Project: SCAVIUM Wallet
Phase: 8.3 — Transaction & Activity Maturity
Subphase: 8.3.1 — Transaction History State Model Maturity
Type: code

## Goal

Mature transaction history model/state handling while preserving existing local outgoing history compatibility.

## Scope

Focus on domain correctness, safe JSON compatibility, deterministic pending/receipt behavior, and existing native/ERC-20 history records.

## Allowed Files

- `lib/features/assets/domain/tx_status.dart`
- `lib/features/assets/domain/tx_kind.dart`
- `lib/features/assets/domain/tx_history_entry.dart`
- `lib/features/assets/domain/tx_history_repository.dart`
- `lib/features/assets/data/tx_history_repository_impl.dart`
- `lib/features/assets/application/tx_history_controller.dart`
- `lib/features/blockchain/data/scavium_rpc_service.dart`
- `test/tx_history_entry_test.dart`
- `test/tx_history_controller_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Evolve existing model; do not replace it.
- Preserve pending/confirmed/failed behavior.
- Add unknown/unresolved only if required by real code.
- Keep receipt refresh centralized in `TxHistoryController`.
- Keep older stored entries readable.
- Do not add incoming activity indexing.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/tx_history_entry_test.dart test/tx_history_controller_test.dart
```

## Acceptance

Stored entries remain readable; pending entries without receipts are not falsely failed; existing send flows remain compatible.