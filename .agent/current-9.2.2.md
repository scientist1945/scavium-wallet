# Current Task — 9.2.2

Project: SCAVIUM Wallet
Phase: 9.2 — Build Version & MSIX Synchronization Hardening
Subphase: 9.2.2 — Build Tool Version and MSIX Behavior Hardening
Type: Code-only implementation

## Goal

Harden `tool/build.dart` so version mutation, `--no-version-bump`, expected tag validation, and MSIX synchronization are explicit, safe, and difficult to misinterpret.

## Scope

- Preserve the current contract from `pubspec.yaml`: `version: x.y.z+n`.
- Preserve build-number increment behavior when no `--version` override is provided.
- Preserve build-number reset to `1` when `--version x.y.z` changes the semantic version.
- Make `--no-version-bump` visibly intentional in logs/behavior.
- Keep MSIX synchronization derived from the resolved build version as `x.y.z.n`.
- Do not change release publication, signing policy, CI workflow ownership, or platform build commands.

## Allowed Files

- `tool/build.dart`
- `pubspec.yaml` only for read-only inspection; do not intentionally leave metadata changes in this subphase unless required and approved.

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Inspect only `tool/build.dart` and `pubspec.yaml` before planning.
- Do not run any command.
- Improve clarity with the smallest compatible changes.
- Keep existing function names unless a small extraction is required for 9.2.3 testability.
- Do not introduce a new release system.
- Do not modify `.github/workflows/release.yml`.
- Do not edit runtime identity, Settings UI, theme, routing, wallet, asset, signing, backup, restore, diagnostics, or documentation files.

## Validation (manual)

```bash
dart run tool/build.dart --check-version --expected-tag v0.2.2
fvm flutter analyze
```

## Acceptance

- Existing version parsing remains strict.
- `--no-version-bump` behavior is explicit and not confused with sync failure.
- MSIX version sync remains tied to the resolved version.
- No unrelated code or documentation is modified.
