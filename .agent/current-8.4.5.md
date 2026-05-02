# Current Task — 8.4.5

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.5 — Settings, Diagnostics, and Secondary Action Organization
Type: code

## Goal

Organize settings, diagnostics, signing access, backup export, reset, and about information without weakening safety gates.

## Scope

Refine primary vs secondary placement. Keep signing explicit, diagnostics reachable, backup export reachable, and reset confirmation-gated.

## Allowed Files

- `lib/features/settings/presentation/settings_screen.dart`
- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart`
- `lib/features/signing/presentation/signing_screen.dart`
- `lib/features/settings/presentation/export_backup_screen.dart`
- `lib/shared/widgets/feedback/confirm_dialog.dart`
- `test/signing_screen_test.dart`
- `test/signing_controller_test.dart`
- `lib/features/settings/presentation/widgets/settings_section_card.dart`
- `test/settings_screen_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Reorganize settings sections without moving feature ownership.
- Keep RPC diagnostics explicit and reachable.
- Keep signing explicit with preview/confirmation behavior.
- Keep backup export and reset under safe, visible paths.
- Do not add hidden signing shortcuts or background signing behavior.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/signing_screen_test.dart test/signing_controller_test.dart
```

## Acceptance

Diagnostics, signing, backup export, reset, and about/settings behavior remain reachable and safety-gated.
