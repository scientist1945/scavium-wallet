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

The wallet completed Phase 7 stabilization and Phase 8 product expansion and production maturity. Phase 8.5 security, reliability, and diagnostics maturity extended the expanded wallet surface with safer diagnostics, clearer signing and backup warnings, centralized lifecycle/lock reliability, and normalized invalid-state handling. Phase 8.6 release and distribution maturity closed the release-tooling extension with clearer artifact reporting, CI release metadata, checksum boundaries, and manual distribution expectations. Phase 9 is now open as the application identity, versioning, and visual theme maturity phase. Phase 9.1 closed the first visible identity gap by moving Settings/About from stale hardcoded version copy to dynamic runtime package metadata through a controlled app identity boundary. Phase 9.2 closed the build-version/MSIX synchronization hardening layer. Phase 9.3 is now closed as the token-first visual-system implementation step: `lib/app/theme/tokens/` owns the SCAVIUM token namespace, compatibility facades preserve existing theme consumers, shared visual widgets have begun token adoption, and focused token contract coverage locks the foundation for light/dark work. Phase 9.4 is now closed as the light/dark theme implementation bridge: `AppTheme.darkTheme` and `AppTheme.lightTheme` are built from a shared theme path, `ScavoThemeColors` owns the mode-specific palette boundary, shared visual surfaces consume theme-owned values, and runtime selection/persistence remains deferred to 9.5.

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
- Phase 8.3 — Transaction & Activity Maturity
- Phase 8.4 — Navigation Shell and Product Surface Scaling
- Phase 8.5 — Security, Reliability & Diagnostics Maturity
- Phase 8.6 — Release & Distribution Maturity Extension

Active Phase 9 work:
- Phase 9.0 completed — Application Identity, Versioning, and Visual Theme Maturity documentation lock.
- Phase 9.1 completed — Runtime App Version Surface.
- Phase 9.2 completed — Build Version & MSIX Synchronization Hardening; 9.2.1 completed the baseline inspection, 9.2.2/9.2.3 implemented build-tool hardening and focused validation, and 9.2.4 aligned release/development documentation ahead of closure.
- Phase 9.3 completed — Theme Token Normalization; 9.3.1 introduced `lib/app/theme/tokens/`, 9.3.2 hardened the token model and facade mappings, 9.3.3 adopted tokens in ThemeData and shared visual widgets, and 9.3.4 closed the documentation record while preserving dark-only runtime behavior.
- Phase 9.4 completed — Light/Dark Theme Implementation; implemented paired `AppTheme.darkTheme` / `AppTheme.lightTheme` construction, mode-aware `ScavoThemeColors`, shared component/navigation coherence, and focused light/dark theme validation while keeping runtime selection deferred.


Current Phase 8 milestone:

- Phase 8.2 completed — Asset & Portfolio Expansion
- Phase 8.3 completed — Transaction & Activity Maturity
- Phase 8.4 completed — Navigation Shell and Product Surface Scaling
- Phase 8.5 completed — Security, Reliability & Diagnostics Maturity
- Phase 8.6 completed — Release & Distribution Maturity Extension

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

Completed Phase 8.3 transaction and activity maturity work includes:

- 8.3.0 — Transaction & Activity Contract Definition and Baseline Inspection
- 8.3.1 — Transaction History State Model Maturity
- 8.3.2 — Transaction Detail and Receipt-Oriented Activity View
- 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity
- 8.3.4 — Message Signing Domain and Service Boundary
- 8.3.5 — Message Signing UX, Confirmation, and Result Display
- 8.3.close — Transaction & Activity Maturity Closure

Completed Phase 8.4 navigation and product-surface work includes:

- 8.4.0 — Navigation Shell Baseline Inspection and Product Surface Contract
- 8.4.1 — Route Inventory and Shell Navigation Contract
- 8.4.2 — Responsive App Shell Foundation
- 8.4.3 — Dashboard and Product Surface Segmentation
- 8.4.4 — Wallet and Account Surface Placement
- 8.4.5 — Settings, Diagnostics, and Secondary Action Organization
- 8.4.close — UX & Product Surface Maturity Closure

Completed Phase 8.5 security, reliability, and diagnostics maturity work includes:

- 8.5.0 — Security, Reliability & Diagnostics Baseline Inspection and Execution Contract
- 8.5.1 — Sensitive Diagnostics Output Hardening
- 8.5.2 — Signing Safety Copy and Confirmation Hardening
- 8.5.3 — Backup and Recovery Warning Reliability
- 8.5.4 — Lock, Lifecycle, and Sensitive Surface Reliability
- 8.5.5 — Error Boundary and Invalid State Maturity
- 8.5.close — Security, Reliability & Diagnostics Maturity Closure


Completed Phase 8.6 release and distribution maturity work includes:

- 8.6.0 — Release & Distribution Baseline Inspection and Execution Contract
- 8.6.1 — Build Tool Artifact and Version Consistency Maturity
- 8.6.2 — GitHub Release Workflow Artifact Consistency
- 8.6.3 — Release Validation and Operator Reporting
- 8.6.4 — Distribution Metadata and Store-Readiness Documentation
- 8.6.5 — Cross-Platform Packaging Consistency and Release Closure Readiness
- 8.6.close — Release & Distribution Maturity Extension Closure

Phase 8.6 completed as a release-tooling and distribution-documentation maturity phase. It did not reopen wallet runtime behavior, account state, asset state, signing, backup semantics, routing, diagnostics, security ownership, telemetry, analytics, Play Store upload, Microsoft Store submission, iOS distribution, or runtime update delivery.

Planned Phase 9 identity and visual-theme maturity work includes:

- 9.0 — Phase Definition & Documentation Lock (completed)
- 9.1 — Runtime App Version Surface (completed)
  - 9.1.1 — Runtime Version Metadata Boundary
  - 9.1.2 — Settings/About Runtime Version Integration
  - 9.1.3 — Runtime Version Surface Test Coverage
  - 9.1.close — Runtime App Version Surface Closure
- 9.2 — Build Version & MSIX Synchronization Hardening (closed)
  - 9.2.1 — Build Version Baseline Inspection and Contract — completed
  - 9.2.2 — Build Tool Version and MSIX Behavior Hardening — implemented
  - 9.2.3 — Build Version Validation Coverage — implemented
  - 9.2.4 — Release and Development Documentation Alignment — documented
  - 9.2.close — Build Version & MSIX Synchronization Hardening Closure — closed
- 9.3 — Theme Token Normalization — closed
  - 9.3.1 — Theme Token Baseline Inventory and Naming Contract — closed
  - 9.3.2 — Core SCAVIUM Token Model Implementation — closed
  - 9.3.3 — ThemeData and Shared Widget Token Adoption — closed
  - 9.3.4 — Token Documentation and Implementation Closure — closed
- 9.4 — Light/Dark Theme Implementation — closed
  - 9.4.1 — Light/Dark Theme Baseline and Token Boundary — closed/documentation-only
  - 9.4.2 — AppTheme Light and Dark ThemeData Construction — closed/code-only
  - 9.4.3 — Component and Navigation Theme Coherence — closed/code-only
  - 9.4.4 — Light/Dark Theme Validation and Documentation Closure — closed
- 9.5 — Theme Mode Runtime Selection and Persistence — planned/documented
  - 9.5.1 — Theme Mode Baseline and Runtime Boundary — planned
  - 9.5.2 — Theme Mode Preference Model and Local Persistence — planned
  - 9.5.3 — Reactive App Root Theme Mode Wiring — planned
  - 9.5.4 — Settings Appearance Selector and UX Integration — planned
  - 9.5.5 — Theme Mode Runtime Selection Validation and Documentation Closure — planned
- 9.6 — Settings and About UX Alignment
- 9.close — Application Identity, Versioning, and Visual Theme Maturity Closure

The closed Phase 8.6 state keeps release ownership concentrated in the existing surfaces: `tool/build.dart` owns local build automation, version/MSIX synchronization, artifact expectations, build summaries, and generated release reports; `.github/workflows/release.yml` owns tag/manual release validation, Android and Windows artifact jobs, versioned release assets, CI-generated release manifest, checksum generation, and draft GitHub Release publication; `pubspec.yaml` owns the project version and `msix_config.msix_version`; `docs/release.md` owns operator-facing release and distribution guidance.

Phase 9 is now open as the next product-maturity phase. Phase 9.0 completed the documentation lock for application identity and visual-system consistency. Phase 9.1 then implemented the runtime app version surface: `package_info_plus` resolves package metadata, `lib/core/app_identity` owns the application version boundary, Settings/About consumes that boundary through Riverpod, and focused tests prove deterministic version formatting and provider override behavior. Phase 9.2 is now closed as the compact build-version hardening sequence: 9.2.1 locked the version/MSIX contract, 9.2.2 hardened build-tool behavior, 9.2.3 added deterministic validation coverage, 9.2.4 aligned release/development documentation, and 9.2.close records the final closure after the `pubspec.yaml` MSIX layout normalization was confirmed. The closed contract remains that `pubspec.yaml` owns `version: 0.2.2+1`, `msix_config.msix_version` mirrors it as `0.2.2.1`, and `tool/build.dart` owns build-time interpretation, mutation, tag validation, and MSIX synchronization. The implemented work keeps that boundary in `tool/build.dart`, uses `test/build_tool_version_test.dart` as focused validation coverage, and does not change release publication, runtime Settings/About version display, wallet custody, assets, transactions, signing, backup, restore, diagnostics, routing, or theme behavior. The remaining Phase 9 work now continues through first-class light/dark themes, persisted theme-mode selection, and broader Settings/About alignment. Phase 9.3 is closed as the token-normalization sequence: `lib/app/theme/tokens/` owns the semantic SCAVIUM token namespace, `AppColors` and `AppTextStyles` remain compatibility facades, `AppTheme.darkTheme` consumes token names, shared visual widgets have adopted token values, and `test/app_theme_tokens_test.dart` locks facade mappings, compact scales, typography aliases, and dark-theme construction. The 9.3 sequence remains intentionally bounded to the app theme layer and shared visual components: it does not expose light mode yet, does not change `themeMode`, and does not reopen runtime version, build/MSIX, wallet, signing, backup, diagnostics, routing, release, or CI behavior. Phase 9.4 then closed the light/dark theme implementation bridge: the app still runs dark-only at runtime, but `AppTheme.lightTheme` now exists beside `AppTheme.darkTheme`, `ScavoThemeColors` owns the paired palette boundary, shared visual widgets rely on theme-owned values, and Phase 9.5 is now documented as the planned runtime selection and persistence sequence. Its nested plan keeps 9.5 limited to preference modeling, local persistence, app-root wiring, Settings appearance selection, validation, and documentation closure, without reopening token construction or broader Settings/About redesign.



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
- generated release reports, CI release manifest, and SHA256 checksum publication
- draft GitHub Release publication with attached assets
- controlled Phase 8 product expansion path
- dynamic runtime app version display in Settings/About

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
- `docs/phase9_scavium_wallet.md`
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

## 🧾 Phase 8.3 Transaction & Activity Maturity

Phase 8.3 completed transaction/activity maturity and message-signing implementation on top of the Phase 8.2 asset and portfolio foundation.

Implemented capabilities include:

- safer local outgoing transaction-history deserialization;
- deterministic pending/confirmed/failed receipt refresh behavior;
- transaction detail route with receipt-oriented status explanation;
- explicit explorer opening from transaction detail;
- local activity filtering by status and transaction kind;
- local-day activity grouping;
- distinct empty, filtered-empty, loading, and error states;
- personal-message and challenge-message signing service boundary;
- signing preview and confirmation before signature creation;
- visible signing result display and signature copy feedback.

The implementation remains intentionally bounded:

- no external transaction indexer;
- no incoming transaction discovery;
- no dApp connectivity;
- no transaction submission from signing;
- no backup payload change;
- no release pipeline change.

---

## 🧭 Phase 8.4 Navigation Shell and Product Surface Scaling

Phase 8.4 completed navigation-shell and product-surface maturity on top of the Phase 8.3 transaction/activity/signing baseline.

Implemented capabilities include:

- formal route classification for primary, public, lock, action, detail, and secondary routes;
- authenticated `ShellRoute` usage for primary destinations;
- responsive navigation chrome with compact bottom navigation and wide-layout navigation rail;
- primary destinations for Home, Assets, Activity, and Settings;
- Home dashboard segmentation with balance, account context, network/RPC summaries, quick actions, and recent activity preview;
- dedicated Accounts surface for account-oriented wallet controls;
- organized Settings sections for security/recovery, signing, diagnostics, danger-zone actions, and about information;
- explicit preservation of send, receive, signing, add-token, token-send, asset-detail, transaction-detail, RPC diagnostics, backup export, and reset flows as secondary/action/detail destinations.

The implementation remains intentionally bounded:

- no external transaction indexer;
- no automatic token discovery;
- no dApp connectivity;
- no account deletion or account label editing;
- no backup payload change;
- no wallet encryption change;
- no release pipeline change;
- no shell-owned business state.

---

## 🛡️ Phase 8.5 Security, Reliability & Diagnostics Maturity

Phase 8.5 completed the first cross-cutting hardening pass over the expanded Phase 8 product surface.

Unlike Phase 8.1 through 8.4, this phase did not add a new primary product surface. It hardened the already-expanded wallet by revisiting the places where production users can be most affected by unclear behavior: diagnostics, signing confirmation, backup/export and restore warnings, lifecycle locking, screenshot protection, refresh failures, send errors, token errors, transaction-history receipt refresh, and generic async error presentation.

Implemented capabilities include:

- safe RPC diagnostics copy that preserves useful chain, block, endpoint, and cooldown information without exposing raw exception text;
- signing request validation for empty or oversized messages;
- explicit signing copy that makes clear a signature is not a transaction, does not move funds, and is not a receipt;
- personal-message and challenge-message warning copy before confirmation;
- backup export and restore warnings that reinforce password responsibility, file privacy, and self-custody consequences;
- safe backup/export and restore failure copy that avoids leaking raw payload, mnemonic, password, ciphertext, private-key, address, or signature material;
- centralized lifecycle lock behavior that prevents background refresh restart while the app is locked;
- platform-safe Android screenshot protection behavior where plugin failures are non-fatal;
- safe user-facing error helpers reused by send, token-send, asset refresh, transaction-history refresh, and async UI states;
- pending transaction-history preservation when receipt refresh is unavailable or fails.

The implementation remains intentionally bounded:

- no telemetry or analytics;
- no remote diagnostics reporting;
- no dApp connectivity or WalletConnect;
- no automatic challenge ingestion;
- no background signing;
- no backup payload format change;
- no release pipeline change;
- no shell-owned security state.

Phase 8.5 is therefore a maturity layer over the existing architecture, not a replacement of the architecture.

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
- automatic token discovery
- multi-chain portfolio aggregation
- external dApp connectivity

---

## 📚 Documentation

For detailed release, stabilization, and product expansion documentation, see:

- `docs/release.md`
- `docs/phase7_scavium_wallet.md`
- `docs/phase8_scavium_wallet.md`
- `docs/phase9_scavium_wallet.md`

---

## 🎯 Goal

Deliver a stable, secure, production-oriented and operationally reproducible SCAVIUM Wallet product with:

- controlled regression handling
- safer repeatable build workflow
- practical self-custody recovery validation
- controlled product expansion from the Phase 7 baseline
- application identity, versioning, and visual theme maturity through Phase 9
- a scalable path toward accounts, assets, activity, signing, UX, security, release maturity, and product identity consistency
- Windows distribution readiness
- GitHub-based release artifact publication
- lower operator error during release generation and distribution
