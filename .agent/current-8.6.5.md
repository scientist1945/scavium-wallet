# Current Task — 8.6.5

Project: SCAVIUM Wallet
Phase: 8.6 — Release & Distribution Maturity Extension
Subphase: 8.6.5 — Cross-Platform Packaging Consistency and Release Closure Readiness
Type: code

## Goal

Consolidate cross-platform packaging expectations before Phase 8.6 closure so Android, Web, and Windows release paths stay coherent.

## Scope

Apply final consistency adjustments for artifact discovery, platform build reporting, checksum expectations, and local/CI release alignment. Do not introduce new product surfaces.

## Allowed Files

- `tool/build.dart`
- `.github/workflows/release.yml`
- `pubspec.yaml`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Read only allowed release and metadata files before proposing edits.
- Preserve Android APK and App Bundle behavior.
- Preserve Windows MSIX behavior.
- Preserve Web build support in `tool/build.dart` even if Web is not currently published as a GitHub Release asset.
- Keep local and CI release flows consistent.
- Touch `pubspec.yaml` only for a real packaging metadata correction.
- Do not modify docs in this code-only flow.

## Validation (manual)

```bash
fvm flutter analyze
dart run tool/build.dart --check-version --expected-tag v0.2.1
```

## Acceptance

Android, Web, and Windows packaging behavior is consistently represented in release tooling; checksums remain coherent; no runtime wallet behavior changes.