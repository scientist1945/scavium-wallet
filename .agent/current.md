# Current Task — 8.6.3

Project: SCAVIUM Wallet
Phase: 8.6 — Release & Distribution Maturity Extension
Subphase: 8.6.3 — Release Validation and Operator Reporting
Type: code

## Goal

Add or mature release validation/reporting so operators can see what was built, validated, skipped, or missing for a release.

## Scope

Introduce focused release reports, validation summaries, missing-artifact checks, or generated manifest output only where supported by the existing release pipeline.

## Allowed Files

- `tool/build.dart`
- `.github/workflows/release.yml`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Read only allowed release-tool/workflow files before proposing edits.
- Prefer extending existing `tool/build.dart` unless separation is technically necessary.
- A new `tool/release_validate.dart` may be proposed only if validation logic would make `tool/build.dart` too large or unclear.
- Reports must not include secrets, signing passwords, private keys, mnemonic data, wallet addresses, signatures, or backup payload data.
- Generated reports must be treated as build/distribution outputs, not runtime wallet data.

## Validation (manual)

```bash
fvm flutter analyze
dart run tool/build.dart --check-version --expected-tag v0.2.1
```

## Acceptance

Release output/reporting identifies version, build number, expected artifacts, missing artifacts, and checksum/report boundaries without exposing sensitive data.