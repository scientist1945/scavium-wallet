# SCAVIUM Wallet

Self-custody Flutter wallet for the SCAVIUM network.

SCAVIUM Wallet is an EVM-compatible wallet focused on controlled production hardening, practical self-custody recovery, and reproducible multiplatform release engineering.

---

## 🧭 Overview

The project is built with:

- Flutter
- Dart
- Riverpod
- GoRouter

Current platform and release scope includes:

- Android
- Windows
- Web support path
- Windows MSIX packaging
- GitHub Release automation

The wallet is currently under Phase 7 stabilization, which means the focus is on:

- hardening
- fixes
- operational safety
- production readiness
- release engineering improvements

This phase does not introduce major architecture redesign or broad new product features.

---

## 📦 Current Project Status

Completed phases:

- Phase 1 — Core setup
- Phase 2 — Wallet creation and import
- Phase 3 — Blockchain integration
- Phase 4 — Transaction flows
- Phase 5 — Production readiness
- Phase 6 — Packaging, branding, and store deployment
- Phase 7 — Stabilization

Current implemented stabilization work includes:

- 7.1 — Android biometrics stabilization
- 7.2 — Wallet persistence hardening
- 7.3 — Branding correction
- 7.4 — Build and versioning automation
- 7.5 — Encrypted backup and restore
- 7.6 — Windows MSIX signing and distribution readiness
- 7.7 — GitHub Release automation and artifact publishing hardening

---

## ✨ Key Characteristics

- self-custody wallet model
- EVM-compatible transaction support
- production-oriented release hardening
- encrypted local backup and restore flow
- multiplatform build orchestration through `tool/build.dart`
- GitHub Actions-based release artifact generation
- draft GitHub Release publication with attached assets

---

## 🗂️ Repository Structure

Main areas of interest:

- `lib/` — application source code
- `tool/build.dart` — build and release orchestration tool
- `.github/workflows/release.yml` — GitHub Actions release workflow
- `docs/` — structured technical documentation by phase and topic

Important documentation includes:

- `docs/phase7_scavium_wallet.md`
- `docs/release.md`

---

## 🛠️ Build Tool

The project uses a Dart-native build tool:

`tool/build.dart`

Supported targets:

- `android-apk`
- `android-bundle`
- `web`
- `windows`
- `windows-msix`
- `all`

Typical commands:

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

Release validation mode:

    dart run tool/build.dart --check-version --expected-tag v0.2.1

---

## 📦 Release Artifacts

The current release pipeline generates:

- Android App Bundle (`.aab`)
- Android APK (`.apk`)
- Windows MSIX (`.msix`)
- SHA256 checksums (`SHA256SUMS.txt`)

The Android App Bundle is the primary Android distribution package.

The Android APK is included as a secondary release artifact for:

- direct installation
- internal testing
- technical validation
- debugging
- fallback distribution

The Windows MSIX package is the primary Windows release artifact.

---

## 🚀 Release Flow

Recommended formal release path:

1. Update version in `pubspec.yaml` if needed
2. Commit release state
3. Create and push tag

Example:

    git tag v0.2.1
    git push origin v0.2.1

This triggers the GitHub Actions release workflow, which:

- validates release state
- builds Android artifacts
- builds Windows MSIX
- generates checksums
- creates a GitHub draft release
- attaches release artifacts

Manual execution through GitHub Actions is also supported for CI testing and validation.

---

## 🔐 Signing and Secrets

Sensitive signing material must never be committed to the repository.

This includes:

- Android keystore (`.jks`)
- Windows certificate (`.pfx`)
- passwords
- raw signing configuration files containing secrets

CI restores these through GitHub Secrets.

---

## 📝 Current Release Behavior

As of Phase 7.7:

- releases are created as Draft on GitHub
- artifacts are attached automatically
- source archives are exposed automatically by GitHub
- manual review remains possible before publication

This draft-first approach is intentional during stabilization.

---

## ♻️ Recovery Validation

Encrypted backup and restore is now part of release validation expectations.

Release candidates should validate:

- encrypted backup generation
- platform-appropriate export behavior
- restore success
- invalid password handling
- invalid file handling
- safe return to a valid wallet state after restore

This is treated as a release-quality concern because it materially affects self-custody safety.

---

## 🚧 Out of Scope

The current release engineering scope does not yet include:

- automatic Play Store upload
- automatic Microsoft Store submission
- automatic iOS distribution
- full CI/CD promotion flows
- runtime updates
- automatic git tagging
- advanced changelog generation

---

## 📚 Documentation

For detailed release and stabilization documentation, see:

- `docs/release.md`
- `docs/phase7_scavium_wallet.md`

---

## 🎯 Goal

Deliver a stable, secure, production-oriented and operationally reproducible SCAVIUM Wallet build with:

- controlled regression handling
- safer repeatable build workflow
- practical self-custody recovery validation
- Windows distribution readiness
- GitHub-based release artifact publication
- lower operator error during release generation and distribution