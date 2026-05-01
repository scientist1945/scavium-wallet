# Current Task — 8.3.3

Project: SCAVIUM Wallet
Phase: 8.3 — Transaction & Activity Maturity
Subphase: 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity
Type: code

## Goal

Improve the local activity surface with lightweight filtering/grouping and truthful empty/error states.

## Scope

Enhance local outgoing history presentation only. Do not imply full blockchain activity indexing.

## Allowed Files

- `lib/features/assets/presentation/history_screen.dart`
- `lib/features/assets/application/tx_history_controller.dart`
- `lib/features/assets/domain/tx_history_entry.dart`
- `lib/features/assets/domain/tx_status.dart`
- `lib/features/assets/domain/tx_kind.dart`
- `lib/shared/widgets/feedback/state_message.dart`
- `lib/features/assets/domain/tx_history_filter.dart`
- `test/tx_history_filter_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Add status/kind/date grouping only as small local transformations.
- Keep repository mutation out of UI.
- Make empty/error copy explicit about local outgoing history scope.
- Do not hide data permanently.
- Create `tx_history_filter.dart` only if inline UI state becomes too large.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/tx_history_filter_test.dart
```

## Acceptance

Filters/grouping are reversible; refresh still updates pending entries; empty/error states are truthful.