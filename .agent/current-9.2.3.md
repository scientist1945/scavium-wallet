# Current Task — 9.2.3

Project: SCAVIUM Wallet
Phase: 9.2 — Build Version & MSIX Synchronization Hardening
Subphase: 9.2.3 — Build Version Validation Coverage
Type: Code-only implementation

## Goal

Add focused validation for version parsing, tag normalization, version bumping, no-bump behavior, and MSIX synchronization without requiring full platform builds.

## Scope

- Prefer deterministic Dart/Flutter tests for pure build-version behavior.
- Validate `version: x.y.z+n` parsing.
- Validate expected tag normalization for `vX.Y.Z` and `refs/tags/vX.Y.Z`.
- Validate build-number increment and semantic-version reset behavior.
- Validate no-bump behavior preserves the current version.
- Validate MSIX version derivation as `x.y.z.n`.
- Avoid invoking actual Flutter builds, MSIX packaging, signing, CI release publication, or generated artifacts.

## Allowed Files

- `tool/build.dart`
- `test/build_tool_version_test.dart`
- `pubspec.yaml` only if a real dev dependency change is strictly required; avoid by default.

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Inspect only `tool/build.dart`, `pubspec.yaml`, and existing nearby tests before planning.
- Do not run any command.
- Prefer adding `test/build_tool_version_test.dart`.
- If `tool/build.dart` must be adjusted for testability, keep extraction minimal and do not change production release behavior.
- Use temporary files/directories in tests; never rely on or mutate the real project `pubspec.yaml`.
- Do not edit release workflow, runtime identity, Settings UI, theme, wallet, asset, signing, backup, restore, diagnostics, or documentation files.

## Validation (manual)

```bash
fvm flutter test test/build_tool_version_test.dart
fvm flutter analyze
```

## Acceptance

- Focused validation exists for build-version/MSIX behavior.
- Tests do not run platform builds or mutate source-controlled project metadata.
- Existing build tool behavior remains compatible with 9.2.1 contract.
- No unrelated code or documentation is modified.
