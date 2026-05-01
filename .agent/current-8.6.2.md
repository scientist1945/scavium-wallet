# Current Task — 8.6.2

Project: SCAVIUM Wallet
Phase: 8.6 — Release & Distribution Maturity Extension
Subphase: 8.6.2 — GitHub Release Workflow Artifact Consistency
Type: code

## Goal

Mature the GitHub Release workflow so CI artifacts are consistently named, grouped, checksummed, and published as draft releases.

## Scope

Refine the existing release workflow only. Keep tag validation, Android/Windows artifact generation, checksum generation, and draft-first publication.

## Allowed Files

- `.github/workflows/release.yml`
- `tool/build.dart`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Read only `.github/workflows/release.yml` and `tool/build.dart` before proposing edits.
- Preserve tag-triggered validation against `pubspec.yaml`.
- Preserve manual `workflow_dispatch`.
- Preserve Android signing secret requirements and MSIX certificate secret requirements.
- Preserve draft GitHub Release behavior.
- Do not add automatic store submission.
- Adjust `tool/build.dart` only if workflow consistency requires matching local support.

## Validation (manual)

```bash
fvm flutter analyze
dart run tool/build.dart --check-version --expected-tag v0.2.1
```

## Acceptance

Release workflow remains draft-first; Android and Windows artifacts are consistently collected; `SHA256SUMS.txt` remains generated deterministically.