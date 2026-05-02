# Current Task — 8.5.1

Project: SCAVIUM Wallet
Phase: 8.5 — Security, Reliability & Diagnostics Maturity
Subphase: 8.5.1 — Sensitive Diagnostics Output Hardening
Type: code

## Goal

Harden RPC diagnostics and health output so troubleshooting remains useful without exposing wallet material, secrets, raw internal exceptions, or misleading security state.

## Scope

Keep diagnostics non-invasive. Preserve Settings reachability, active RPC/ping/cooldown visibility, and current blockchain ownership. Do not add telemetry, analytics, remote logging, or background reporting.

## Allowed Files

- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart`
- `lib/features/blockchain/application/rpc_health_controller.dart`
- `lib/features/blockchain/application/rpc_status_controller.dart`
- `lib/features/blockchain/domain/scavium_rpc_status.dart`
- `lib/core/errors/app_exception.dart`
- `test/widget_test.dart`
- `test/rpc_diagnostics_safety_test.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Read only the allowed diagnostics/error/test files before proposing edits.
- Normalize user-facing diagnostics copy without including wallet addresses, private keys, mnemonic material, backup passwords, raw signed messages, signatures, or backup payload contents.
- Prefer existing `AppException` and controller patterns.
- Create `test/rpc_diagnostics_safety_test.dart` only if existing tests cannot hold focused safety assertions.
- Keep changes small and limited to diagnostics safety.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/widget_test.dart test/rpc_diagnostics_safety_test.dart
```

## Acceptance

Diagnostics remain reachable from Settings, preserve useful RPC state, do not mutate wallet state, and do not expose sensitive wallet material.
