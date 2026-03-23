# SCAVIUM Wallet — Release

## 🧭 Overview

This document describes the release process and release hardening path for SCAVIUM Wallet.

---

## 📦 Current State

The wallet has completed packaging and initial store distribution.

Current release state:

- packaged and signed
- distributed through Google Play Internal Testing
- under release candidate stabilization in Phase 7

---

## 🏗️ Release Steps

### Phase 6

1. Configure app metadata
2. Define branding (icons, splash)
3. Configure build targets
4. Setup signing (Android / iOS)
5. Generate production builds
6. Prepare store assets
7. Publish to internal testing

### Phase 7

1. collect tester feedback
2. identify regressions
3. apply minimal corrective patches
4. validate on real devices
5. prepare next release candidate

---

## 🔐 Signing

- Android keystore required
- iOS certificates required

---

## 📱 Targets

- Android
- iOS
- Web (optional)
- Windows (packaging-ready)
- Windows MSIX installer

---

## 🛠️ Release Tooling (Phase 7.4)

The release workflow now includes a Dart-native build tool:

tool/build.dart

### Supported targets

- android-apk
- android-bundle
- web
- windows
- windows-msix
- all

### Typical commands

Android App Bundle:

    dart run tool/build.dart --platform android-bundle

Full build:

    dart run tool/build.dart --platform all

Version override:

    dart run tool/build.dart --platform all --version 0.2.2

No version bump:

    dart run tool/build.dart --platform web --no-version-bump

### Version behavior

- version is read from `pubspec.yaml`
- build number increments automatically when the base version stays the same
- build number resets to `1` when the base version changes

Example:

    0.2.1+3 → 0.2.1+4
    0.2.2+1

---

## ♻️ Recovery Readiness (Phase 7.5)

From Phase 7.5 onward, release candidates also include encrypted backup and restore behavior that should be validated during QA.

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

---

## 🧪 Release Candidate Validation

The current release process now includes:

- internal testing on Play Store
- real-device Android validation
- regression verification
- stabilization before broader rollout

Phase 7.1 specifically validated:

- Android biometric unlock recovery after a production-distributed regression

Phase 7.2 specifically validated:

- hardened wallet persistence behavior
- startup consistency under real persisted-state checks
- safer backup progression behavior

Phase 7.3 specifically validated:

- in-app branding consistency for the shared splash/logo widget
- correct runtime usage of official SCAVIUM visual assets

Phase 7.4 specifically validated:

- automated version handling
- stable multiplatform build execution
- version override path
- no-version-bump path
- Windows MSIX packaging invocation

Phase 7.5 specifically validated:

- encrypted backup generation
- platform-appropriate backup export
- encrypted restore path
- repository-backed restore persistence
- password failure handling

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

---

## 🚧 Out of Scope for Current Release Tooling

The current tooling does not yet include:

- automatic Play Store upload
- automatic Microsoft Store submission
- CI/CD remote runners
- automatic git tagging
- automatic changelog generation

The current recovery model also does not yet include:

- cloud backup
- remote sync
- server-side restore
- custodial fallback

These remain future release engineering or product-scope steps.

---

## 🎯 Goal

Deliver a stable, secure and production-ready build with controlled regression handling between release candidates, a safer repeatable build workflow, and a practical self-custody recovery path.