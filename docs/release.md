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

### Phase 9.2.1 version/MSIX baseline contract

Phase 9.2.1 confirms the release-facing version contract before further build-tool hardening:

- `pubspec.yaml` is the canonical committed source for `version: x.y.z+n`;
- the current inspected baseline is `version: 0.2.2+1`;
- `msix_config.msix_version` must mirror that value as `x.y.z.n`;
- the current inspected MSIX baseline is `0.2.2.1`;
- `tool/build.dart` owns build-time version interpretation, optional mutation, expected-tag validation, and Windows MSIX synchronization;
- `--no-version-bump` is intentional non-mutation, not a synchronization failure;
- `--check-version --expected-tag vX.Y.Z` validates the semantic version against the tag and does not mutate build metadata.

This contract does not introduce a new publication target, automatic store upload, Microsoft Store submission, or runtime update mechanism. It preserves the Phase 8.6 release automation boundary while giving 9.2.2 and 9.2.3 a stable baseline for hardening and validation.

Phase 9.2.2 and 9.2.3 then implemented that contract through the existing build tool instead of adding a parallel release mechanism:

- normal build execution resolves the current version and may update `pubspec.yaml` by incrementing the build number;
- `--version x.y.z` preserves the semantic version contract and resets the build number to `1` only when the semantic version changes;
- `--no-version-bump` intentionally leaves `pubspec.yaml` unchanged and should be read as a no-mutation operator choice, not as a failed synchronization;
- `--check-version --expected-tag vX.Y.Z` validates the Git tag against the semantic version only and does not mutate metadata;
- Windows MSIX packaging synchronizes `msix_config.msix_version` from the resolved build version as `x.y.z.n`;
- `test/build_tool_version_test.dart` is the focused validation surface for version parsing, tag normalization, bump/no-bump behavior, and MSIX derivation.

9.2.close records that the committed `pubspec.yaml` layout has been normalized and confirmed: `identity_name` and `msix_version` appear as separate normal YAML lines while preserving the intended values `com.scavium.wallet` and `0.2.2.1`. This completes the release-facing version/MSIX synchronization contract without introducing store publication or release-upload behavior.

Example:

    0.2.1+3 → 0.2.1+4
    0.2.2+1 → 0.2.2.1 for MSIX

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
---

## 🛡️ Phase 8.5 Release-Quality Validation Expectations

Phase 8.5 does not change the release pipeline, build tool, GitHub Actions workflow, artifact format, or distribution automation.

It does, however, add runtime behaviors that should be treated as release-quality validation expectations before broader distribution:

- RPC diagnostics should display safe normalized failures rather than raw exception dumps.
- Signing should reject empty/oversized messages and show explicit warnings before confirmation.
- Signing results should be presented as signatures, not transactions or receipts.
- Backup export and restore should display clear password/file responsibility warnings.
- Backup and restore failures should not expose raw backup payloads, mnemonic text, passwords, ciphertext, private keys, addresses, or signatures.
- Lifecycle lock behavior should prevent refresh restart while locked.
- Android screenshot protection failures should be non-fatal.
- Invalid send, token-send, asset-refresh, transaction-history, and async UI states should fail safely with actionable user-facing copy.

These checks complement existing release validation. They do not replace `fvm flutter analyze`, `fvm flutter test`, platform packaging checks, or the later Phase 8.6 release/distribution maturity scope.

---

## ✅ Phase 8.6 Release & Distribution Maturity

Phase 8.6 is complete as the release/distribution maturity extension after Phase 8.5 closure. It starts from the existing Phase 7 release-hardening baseline and the Phase 8 runtime-hardening state, but it does not reopen runtime wallet behavior.

The closed Phase 8.6 release baseline now includes:

- `tool/build.dart` for local build automation, version handling, platform selection, MSIX synchronization, CI overrides, artifact discovery, artifact expectation checks, generated release reports, and local signing/verification behavior.
- `.github/workflows/release.yml` for tag/manual release validation, Android release artifact generation, Windows MSIX generation, versioned release asset collection, platform release-report publication, CI-generated `release-manifest.json`, SHA256 checksum generation, artifact upload/download, and draft GitHub Release publication.
- `pubspec.yaml` as the version and packaging metadata source, currently `version: 0.2.1+12` with `msix_config.msix_version: 0.2.1.12`.
- this document as the operator-facing release and distribution reference.

Phase 8.6 completed work:

- 8.6.0 — Release & Distribution Baseline Inspection and Execution Contract
- 8.6.1 — Build Tool Artifact and Version Consistency Maturity
- 8.6.2 — GitHub Release Workflow Artifact Consistency
- 8.6.3 — Release Validation and Operator Reporting
- 8.6.4 — Distribution Metadata and Store-Readiness Documentation
- 8.6.5 — Cross-Platform Packaging Consistency and Release Closure Readiness
- 8.6.close — Release & Distribution Maturity Extension Closure

### Generated release reports

`tool/build.dart` writes generated release reports under `build/release/` using the selected platform label. These reports are generated evidence, not committed source-controlled documentation.

A report records:

- tool identity;
- generation timestamp;
- selected platform;
- semantic version, build number, and full version;
- artifact labels, paths, existence state, and release-published classification;
- missing artifact labels;
- release-published platform labels;
- local-support-only platform labels;
- checksum responsibility boundary;
- sensitive-data exclusion policy.

The report is intended to reduce operator ambiguity during local and CI release generation. It must not contain signing passwords, certificates, private keys, mnemonic data, wallet addresses, signatures, backup payload material, or other wallet-sensitive runtime data.

### Release-published and local-support platform boundary

Phase 8.6 makes the platform boundary explicit:

- Android APK is a release-published artifact.
- Android App Bundle is a release-published artifact.
- Windows MSIX is a release-published artifact.
- Web build output is local-support-only in the current release automation.
- Unpackaged Windows runner output is local-support-only in the current release automation.

The `all` build path may validate or produce multiple outputs locally, but GitHub Release publication remains limited to the supported release asset set collected by the workflow.

### CI release manifest

The release workflow generates `release-manifest.json` as a GitHub Release asset. It is not a committed source file.

The manifest records:

- application name;
- version;
- draft release status;
- release-published platforms;
- local-support-only platforms;
- checksum file name;
- checksum boundary;
- sensitive-data policy.

This manifest is operator-facing release metadata. It does not replace `pubspec.yaml`, does not become runtime configuration, and does not authorize automatic store submission.

### Checksum boundary

`SHA256SUMS.txt` is generated by the GitHub Release workflow after Android artifacts, Windows artifacts, platform reports, and `release-manifest.json` are collected under the release asset directory.

Operators should treat checksums as release-asset verification evidence for the draft GitHub Release asset set. The checksum file does not validate source code, signing secrets, store submission state, or runtime wallet behavior.

### Manual distribution boundary

Phase 8.6 improves release readiness but keeps distribution submission manual.

The following remain outside the implemented automation:

- automatic Play Store upload;
- automatic Microsoft Store submission;
- iOS distribution;
- runtime update delivery;
- telemetry or analytics;
- remote diagnostics reporting;
- wallet-secret handling changes;
- backup format changes;
- dApp connectivity or WalletConnect.

Before publishing outside GitHub Releases, an operator must still review the draft release, verify attached assets and checksums, confirm signing expectations, prepare store metadata where applicable, and perform the relevant manual distribution action.

### Closure result

Phase 8.6 closes with a clearer release evidence chain from local build execution to CI draft-release publication. The build tool reports expected outputs, the workflow carries generated reports and manifest metadata into the draft release, checksums cover the release asset set, and documentation distinguishes implemented release automation from manual distribution responsibilities.


---

## 🧭 Phase 9 Version Identity Follow-Up

Phase 8.6 closed the release/distribution tooling maturity layer. Phase 9 is open to follow that work by aligning the user-visible runtime version with the same project identity chain used by build and packaging flows. Phase 9.0 documented this boundary without changing release tooling, and Phase 9.1 now implements the runtime Settings/About version surface without changing release publication behavior.

The Phase 9 versioning follow-up now separates completed runtime identity work from remaining build/MSIX hardening.

Completed in 9.1:

- Settings/About displays version data from runtime package metadata instead of static copy;
- the stale `Version 0.4.0` UI literal is removed from the runtime Settings surface;
- tests validate version display through deterministic provider overrides rather than release artifacts.

Completed in 9.2.1:

- the baseline contract confirms `pubspec.yaml` as the source of `version: 0.2.2+1`;
- the baseline contract confirms `msix_config.msix_version: 0.2.2.1` as the aligned Windows MSIX metadata representation;
- the baseline contract separates tag validation, version mutation, no-bump behavior, and MSIX synchronization before code hardening.

Remaining for later Phase 9 implementation:
- whether `tool/build.dart` version bump behavior and `msix_config.msix_version` synchronization logs/guardrails remain explicit enough for operators;
- whether `--no-version-bump` behavior is documented clearly enough that operators do not confuse intentional non-mutation with a synchronization failure;
- whether runtime version display, `pubspec.yaml`, MSIX metadata, CI artifact naming, and release documentation remain conceptually aligned.

Phase 9.2 is now documented as the closed implementation sequence that handled this build/version hardening:

- 9.2.1 — Build Version Baseline Inspection and Contract — completed;
- 9.2.2 — Build Tool Version and MSIX Behavior Hardening;
- 9.2.3 — Build Version Validation Coverage;
- 9.2.4 — Release and Development Documentation Alignment;
- 9.2.close — Build Version & MSIX Synchronization Hardening Closure — closed.

This is not a new release publication feature. It is an identity/version consistency hardening step over the existing release tooling baseline. Phase 9.1 does not change `tool/build.dart`, `.github/workflows/release.yml`, MSIX metadata, artifact naming, or publishing behavior; those boundaries remain for 9.2 implementation.
