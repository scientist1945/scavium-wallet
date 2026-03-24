# SCAVIUM Wallet — Release

## 🧭 Overview

This document describes the release process, release hardening path, and current production-oriented distribution state for SCAVIUM Wallet.

It consolidates the release model across:

- packaging
- signing
- store preparation
- release candidate stabilization
- build automation
- backup and restore validation
- Windows distribution readiness
- GitHub Release automation

---

## 📦 Current State

The wallet has completed packaging and initial store distribution preparation and is currently operating under release candidate stabilization in Phase 7.

Current release state:

- packaged and signed
- distributed through Google Play Internal Testing
- Windows packaging flow implemented
- Windows MSIX generation operational
- release engineering hardened through a Dart-native build tool
- encrypted backup and restore integrated into release validation scope
- GitHub-based automated draft release generation implemented
- under release candidate stabilization in Phase 7

This means the application is no longer in early packaging preparation. The project now has a working release baseline and is focused on controlled hardening, regression reduction, and reproducible release execution.

---

## 🏗️ Release Steps

### Phase 6

1. Configure app metadata
2. Define branding (icons, splash)
3. Configure build targets
4. Setup signing
5. Generate production builds
6. Prepare store assets
7. Publish to internal testing

### Phase 7

1. Collect tester feedback
2. Identify regressions
3. Apply minimal corrective patches
4. Validate on real devices
5. Prepare next release candidate
6. Harden build and release process
7. Reduce operational release risk

Phase 7 does not introduce major product expansion.

Its purpose is to stabilize what already exists and improve release safety.

---

## 🔐 Signing

### Android

- Android keystore required
- release signing required for App Bundle and APK generation
- signing material must never be committed to the repository

### Windows

- MSIX certificate required for formal release packaging
- CI-compatible certificate restoration supported through GitHub Secrets
- local environments may still include stricter manual signature verification

### iOS

- iOS certificates remain part of the broader target landscape, but iOS release automation is not yet part of the current release pipeline

---

## 📱 Targets

Current release targets and release-related outputs include:

- Android
- iOS
- Web (optional / secondary)
- Windows
- Windows MSIX installer

### Current practical release outputs

The current hardened release process produces:

- Android App Bundle (`.aab`)
- Android APK (`.apk`)
- Windows MSIX (`.msix`)
- SHA256 checksums (`SHA256SUMS.txt`)

The Android App Bundle remains the primary Android distribution package for formal store-oriented delivery.

The Android APK is also generated as a secondary artifact for:

- direct installation
- internal testing
- validation
- debugging
- fallback technical distribution

The Windows MSIX package remains the primary Windows distribution artifact.

---

## 🛠️ Release Tooling (Phase 7.4)

The release workflow includes a Dart-native build tool:

`tool/build.dart`

This tool acts as the single source of truth for local and CI-driven build orchestration.

### Supported targets

- `android-apk`
- `android-bundle`
- `web`
- `windows`
- `windows-msix`
- `all`

### Typical commands

Android App Bundle:

    dart run tool/build.dart --platform android-bundle

Android APK:

    dart run tool/build.dart --platform android-apk

Windows MSIX:

    dart run tool/build.dart --platform windows-msix

Full build:

    dart run tool/build.dart --platform all

Version override:

    dart run tool/build.dart --platform all --version 0.2.2

No version bump:

    dart run tool/build.dart --platform web --no-version-bump

### Additional release validation mode

As of Phase 7.7, the build tool also supports release validation behavior:

    dart run tool/build.dart --check-version --expected-tag v0.2.1

This mode is used by GitHub Actions to enforce semantic consistency between:

- Git tag
- `pubspec.yaml` version

### Version behavior

- version is read from `pubspec.yaml`
- build number increments automatically when the base version stays the same
- build number resets to `1` when the base version changes

Example:

    0.2.1+3 → 0.2.1+4
    0.2.2+1

---

## ♻️ Recovery Readiness (Phase 7.5)

From Phase 7.5 onward, release candidates also include encrypted backup and restore behavior that must be validated during QA.

### Recommended validation scenarios

- export encrypted backup from settings
- desktop save dialog behavior on Windows
- mobile share/export behavior
- reset wallet after export
- restore from encrypted backup
- invalid password handling
- invalid/corrupt file handling
- restore flow returning to a valid wallet state

This recovery validation is especially important because it materially affects wallet-loss risk in real-world usage.

Backup and restore behavior therefore became part of release quality expectations, not just a product-side utility.

---

## 🪟 Windows Distribution Readiness (Phase 7.6)

Phase 7.6 consolidated Windows release readiness around:

- MSIX generation
- signing compatibility
- distribution-oriented packaging flow
- release verification improvements

This established the operational baseline that later enabled GitHub-based Windows artifact generation in Phase 7.7.

Windows release validation at this stage should still include:

- successful local execution after install
- correct package metadata
- icon and branding consistency
- lock/unlock behavior
- backup/export behavior when applicable
- install/update/uninstall sanity checks when relevant

---

## 🚀 GitHub Release Automation (Phase 7.7)

Phase 7.7 introduced GitHub-based release automation and artifact publishing hardening.

### Main additions

- GitHub Actions workflow for release generation
- CI-driven execution of `tool/build.dart`
- automatic release artifact generation
- automatic checksum generation
- automatic GitHub draft release creation
- automatic artifact attachment to GitHub Releases

### Current workflow outputs

The release workflow currently publishes:

- `scavium_wallet-<version>-android.aab`
- `scavium_wallet-<version>-android.apk`
- `scavium_wallet-<version>-windows.msix`
- `SHA256SUMS.txt`

GitHub also exposes:

- Source code (`zip`)
- Source code (`tar.gz`)

### Trigger modes

#### Tag-based release

Recommended formal path:

    git tag vX.Y.Z
    git push origin vX.Y.Z

Example:

    git tag v0.2.1
    git push origin v0.2.1

This triggers:

- release validation
- Android artifact generation
- Windows MSIX generation
- checksum generation
- GitHub draft release publication

#### Manual workflow dispatch

The workflow can also be executed manually through:

- Actions → Release → Run workflow

This is useful for:

- CI testing
- pipeline validation
- release debugging

Manual runs skip strict tag validation because the GitHub ref name is a branch name instead of a release tag.

### Draft release behavior

The release is currently created as:

- Draft

This is intentional and appropriate for the current stabilization phase because it allows:

- inspection of generated assets
- review before public publication
- checksum validation
- artifact verification
- controlled visibility

### CI-specific hardening already validated

During implementation, the following CI issues were identified and resolved:

- manual workflow runs initially failed because branch names were treated as tags
- Android signing initially failed due to keystore filename mismatch in CI restoration
- Windows CI initially failed because extra `signtool` assumptions were not reliable in the hosted runner environment

These corrections are now part of the current hardened release behavior.

---

## 🧪 Release Candidate Validation

The current release process now includes:

- internal testing on Play Store
- real-device Android validation
- regression verification
- stabilization before broader rollout
- repeatable build execution
- backup/restore validation
- Windows packaging validation
- CI-based artifact generation and release draft creation

### Phase 7.1 specifically validated

- Android biometric unlock recovery after a production-distributed regression

### Phase 7.2 specifically validated

- hardened wallet persistence behavior
- startup consistency under real persisted-state checks
- safer backup progression behavior

### Phase 7.3 specifically validated

- in-app branding consistency for the shared splash/logo widget
- correct runtime usage of official SCAVIUM visual assets

### Phase 7.4 specifically validated

- automated version handling
- stable multiplatform build execution
- version override path
- no-version-bump path
- Windows MSIX packaging invocation

### Phase 7.5 specifically validated

- encrypted backup generation
- platform-appropriate backup export
- encrypted restore path
- repository-backed restore persistence
- password failure handling

### Phase 7.6 specifically validated

- Windows MSIX signing and distribution readiness
- packaging consistency for Windows release flow
- operational installable Windows artifact generation

### Phase 7.7 specifically validated

- GitHub Actions release execution
- tag-aware release flow
- manual workflow execution for CI testing
- Android App Bundle generation in CI
- Android APK generation in CI
- Windows MSIX generation in CI
- checksum generation
- GitHub draft release creation
- artifact attachment to GitHub Releases

---

## 🧠 Notes

- Ensure RPC endpoints are production-ready
- Disable debug logs
- Validate transaction flows
- Validate lock/unlock flows on real devices
- Prefer minimal patches during release stabilization
- Treat uninstall/reinstall recovery assumptions carefully in self-custody flows
- Validate visible branding consistency in runtime UI, not only packaged native assets
- Prefer the build tool over manual command repetition for release builds
- Validate backup and restore before broader release expansion
- Treat Git tags as part of formal release state
- Prefer draft release review before broad publication during stabilization
- Keep signing material outside the repository and inside GitHub Secrets or secured local storage

---

## 🚧 Out of Scope for Current Release Tooling

The current tooling does not yet include:

- automatic Play Store upload
- automatic Microsoft Store submission
- automatic iOS distribution
- full multi-stage CI/CD promotion
- automatic git tagging
- advanced automatic changelog generation
- runtime package delivery
- in-app update orchestration

The current recovery model also does not yet include:

- cloud backup
- remote sync
- server-side restore
- custodial fallback

These remain future release engineering or product-scope steps.

---

## 🎯 Goal

Deliver a stable, secure, production-oriented and operationally reproducible build with:

- controlled regression handling between release candidates
- safer repeatable build workflow
- practical self-custody recovery validation
- Windows distribution readiness
- GitHub-based release artifact publication
- lower operator error during release generation and distribution