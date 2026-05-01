# SCAVIUM Wallet

Self-custody Flutter wallet for the SCAVIUM network.

SCAVIUM Wallet is an EVM-compatible wallet focused on controlled production hardening, practical self-custody recovery, reproducible multiplatform release engineering, and controlled product expansion.

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

The wallet completed Phase 7 stabilization and is currently progressing through Phase 8 product expansion and production maturity.

Phase 8 focuses on controlled product growth from the Phase 7 release-hardened baseline, including:

- account model expansion
- asset and portfolio expansion
- transaction and activity maturity
- message signing preparation and implementation
- multi-surface navigation evolution
- security, reliability, diagnostics, and release maturity extensions

This phase does not replace the existing architecture, Riverpod state model, GoRouter navigation model, backup and restore semantics, or release pipeline baseline.

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
- Phase 8.1 — Account Model Expansion
- Phase 8.2 — Asset & Portfolio Expansion

Current Phase 8 milestone:

- Phase 8.2 completed — Asset & Portfolio Expansion
- Next planned product-expansion area: Phase 8.3 — Transaction & Activity Maturity

Completed Phase 7 stabilization work includes:

- 7.1 — Android biometrics stabilization
- 7.2 — Wallet persistence hardening
- 7.3 — Branding correction
- 7.4 — Build and versioning automation
- 7.5 — Encrypted backup and restore
- 7.6 — Windows MSIX signing and distribution readiness
- 7.7 — GitHub Release automation and artifact publishing hardening

Completed Phase 8.1 account expansion work includes:

- 8.1.0 — Account Model Contract Definition
- 8.1.1 — Domain Model Preparation
- 8.1.2 — Storage Migration Foundation
- 8.1.3 — Active Account Controller
- 8.1.4 — Account Switcher Basic UI
- 8.1.5 — Account Creation & Import Expansion
- 8.1.6 — Backup / Restore Multi-Account Compatibility

Completed Phase 8.2 asset expansion work includes:

- 8.2.0 — Asset Model Contract Definition and Baseline Inspection
- 8.2.1 — Portfolio Summary Model Foundation
- 8.2.2 — Account-Aware Asset Context
- 8.2.3 — Manual Token Safety & Metadata UX
- 8.2.4 — Asset Surface Polish
- 8.2.close — Asset & Portfolio Expansion Closure

---

## ✨ Key Characteristics

- self-custody wallet model
- EVM-compatible transaction support
- production-oriented release hardening
- encrypted local backup and restore flow
- multi-account wallet foundation
- account-aware asset surface
- deterministic manual ERC-20 token registry
- portfolio summary foundation
- multiplatform build orchestration through `tool/build.dart`
- GitHub Actions-based release artifact generation
- draft GitHub Release publication with attached assets
- controlled Phase 8 product expansion path

---

## 🗂️ Repository Structure

Main areas of interest:

- `lib/` — application source code
- `tool/build.dart` — build and release orchestration tool
- `.github/workflows/release.yml` — GitHub Actions release workflow
- `.agent/` — agent-execution prompts, rules, and current-task files used for staged implementation
- `docs/` — structured technical documentation by phase and topic

Important documentation includes:

- `docs/phase7_scavium_wallet.md`
- `docs/phase8_scavium_wallet.md`
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

This draft-first approach was introduced during stabilization and remains the release baseline while Phase 8 expands product capabilities.

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
- v1 backup restore compatibility
- v2 multi-account backup restore compatibility

This is treated as a release-quality concern because it materially affects self-custody safety.

---

## 👛 Phase 8.1 Account Model Expansion

Phase 8.1 completed the controlled transition from the Phase 7 single-account wallet baseline into a functional multi-account foundation.

Implemented capabilities include:

- multi-account domain model preparation
- parallel storage migration metadata
- active-account controller and repository support
- basic account switcher UI
- derived account creation for mnemonic wallets
- imported private-key account addition
- backup/restore v2 compatibility for multi-account profiles

The Phase 8.1 implementation preserves legacy wallet compatibility and keeps v1 backup restore support intact.

---

## 📊 Phase 8.2 Asset & Portfolio Expansion

Phase 8.2 completed asset and portfolio expansion on top of the Phase 8.1 account model.

Implemented capabilities include:

- portfolio summary model derived from visible asset data
- account-aware asset context attached to native and ERC-20 asset items
- deterministic manual token normalization
- duplicate-token protection
- safer token metadata error handling
- improved asset list presentation
- native/ERC-20 distinction in the asset surface
- responsive asset layout polish for mobile, web, and desktop-sized widths

The implementation remains intentionally bounded:

- no automatic token discovery
- no multi-chain expansion
- no route redesign
- no build or release pipeline change
- no backup payload change beyond the already-completed Phase 8.1.6 scope

---

## 🚧 Out of Scope

The current release engineering and Phase 8 product expansion scope does not yet include:

- automatic Play Store upload
- automatic Microsoft Store submission
- automatic iOS distribution
- full CI/CD promotion flows
- runtime updates
- automatic git tagging
- advanced changelog generation
- implemented message signing runtime behavior
- automatic token discovery
- multi-chain portfolio aggregation
- external dApp connectivity

---

## 📚 Documentation

For detailed release, stabilization, and product expansion documentation, see:

- `docs/release.md`
- `docs/phase7_scavium_wallet.md`
- `docs/phase8_scavium_wallet.md`

---

## 🎯 Goal

Deliver a stable, secure, production-oriented and operationally reproducible SCAVIUM Wallet product with:

- controlled regression handling
- safer repeatable build workflow
- practical self-custody recovery validation
- controlled product expansion from the Phase 7 baseline
- a scalable path toward accounts, assets, activity, signing, UX, security, and release maturity
- Windows distribution readiness
- GitHub-based release artifact publication
- lower operator error during release generation and distribution
