# SCAVIUM Wallet — Development

## 🧭 Overview

Development follows a structured, phase-based approach to ensure stability and incremental progress.

From Phase 7 onward, development also includes a stabilization discipline oriented to release candidate quality.

---

## 🧱 Tech Stack

- Flutter
- Dart
- Riverpod
- Web3dart

---

## 📂 Project Structure

lib/
  app/
  core/
  shared/
  features/
tool/

---

## 🔁 Development Flow

1. Define phase scope
2. Implement feature or corrective fix
3. Integrate with existing architecture
4. Test manually on real targets
5. Consolidate phase
6. Document release impact

---

## 🧠 Principles

- Do not break existing functionality
- Maintain naming consistency
- Prefer extension over refactoring
- Keep controllers focused
- During stabilization, prefer minimal and isolated fixes

---

## 🔗 RPC Development

- Always use ScaviumRpcService
- Never call RPC directly from UI
- Respect read/write separation

---

## 🔒 Stabilization Rules

During Phase 7:

- do not redesign architecture
- do not rename existing structures
- do not introduce new features while fixing regressions
- prefer service-layer or platform-layer patches when possible
- validate fixes on real devices when the issue is platform-specific

These rules were applied directly in:

- Phase 7.1 for the Android biometric fix
- Phase 7.2 for wallet persistence hardening and startup-state validation
- Phase 7.3 for the shared-logo branding correction
- Phase 7.4 for build and versioning automation hardening
- Phase 7.5 for encrypted user backup and restore flow

---

## 🛠️ Build System

The project includes a custom build tool located at:

tool/build.dart

### Main responsibilities

- parse release/build arguments
- read version from `pubspec.yaml`
- increment build numbers safely
- optionally override semantic version base
- run multiplatform Flutter builds
- invoke MSIX packaging when requested

### Typical usage

Full build:

    dart run tool/build.dart --platform all

Android App Bundle only:

    dart run tool/build.dart --platform android-bundle

Version override:

    dart run tool/build.dart --platform all --version 0.2.2

No version bump:

    dart run tool/build.dart --platform web --no-version-bump

### Supported targets

- android-apk
- android-bundle
- web
- windows
- windows-msix
- all

---

## ♻️ Backup and Restore Development

The encrypted backup and restore implementation introduced in Phase 7.5 is structured around:

### Core services

- `backup_crypto_service.dart`
- `backup_file_service.dart`

### Wallet domain models

- `wallet_backup_payload.dart`
- `encrypted_wallet_backup.dart`

### Controller

- `wallet_backup_controller.dart`

### Presentation

- export backup screen in settings
- restore backup screen in wallet/onboarding flow

### Development rules for this area

- do not export unencrypted secrets
- do not bypass the main wallet repository on restore
- keep the encrypted backup format versioned
- validate payload and encrypted structure before restore
- keep user warnings explicit and non-optional

---

## 🧪 Testing Strategy

Currently:

- manual testing
- real-device validation
- internal tester feedback through Play Store Internal Testing
- local validation of build automation scenarios
- local validation of encrypted backup export/restore scenarios

Future:

- unit tests
- integration tests
- CI/CD pipeline validation

---

## 🎯 Goal

Maintain a stable, scalable and predictable codebase while hardening release candidates safely, making release operations more repeatable, and reducing operational wallet-loss risk for users.
---

## 🤖 Agent-Assisted Phase Execution

Phase 8.2 introduced a controlled agent-assisted implementation flow through `.agent/*` task files.

The agent flow is constrained by:

- one current task file per subphase;
- explicit allowed and forbidden files;
- no documentation changes during code-only subphases;
- validation through `fvm flutter analyze` and `fvm flutter test`;
- documentation closure after code subphases are implemented and reviewed.

This keeps the implementation loop faster while preserving the project rule that trunk documentation is updated only from the real working tree state.

### Phase 8.2 Development Boundary

Phase 8.2 code subphases were intentionally limited to asset, token, portfolio, and presentation polish areas.

They did not alter:

- backup formats;
- wallet account persistence;
- route names;
- build automation;
- release automation;
- navigation shell structure.

---

## Phase 8.3 Development Boundary

Phase 8.3 continued the controlled agent-assisted implementation flow established during Phase 8.2.

The code subphases were intentionally limited to:

- local outgoing transaction-history state maturity;
- transaction detail presentation;
- local activity filtering, grouping, and empty/error states;
- message-signing domain and service boundaries;
- message-signing UX with preview, confirmation, cancellation, and result display.

They did not alter:

- backup formats;
- wallet account persistence ownership;
- release automation;
- build automation;
- store publication flow;
- external transaction indexing;
- dApp connectivity;
- Phase 8.4 navigation shell structure.

Expected local validation remains:

```bash
fvm flutter analyze
fvm flutter test
```

Documentation closure must be performed after code subphases are reviewed so trunk documents describe the real working tree rather than planned implementation text.
---

## Phase 8.4 Development Boundary

Phase 8.4 continued the controlled agent-assisted implementation flow and completed navigation-shell/product-surface maturity.

The code subphases were intentionally limited to:

- route classification and shell eligibility;
- authenticated shell composition for primary destinations;
- responsive compact and wide navigation chrome;
- Home dashboard segmentation;
- dedicated Accounts surface placement;
- Settings organization for secondary actions and diagnostics.

They did not alter:

- backup payload formats;
- wallet encryption;
- transaction submission semantics;
- release automation;
- build automation;
- store publication flow;
- external transaction indexing;
- automatic token discovery;
- dApp connectivity;
- shell-owned feature state.

Expected local validation remains:

```bash
fvm flutter analyze
fvm flutter test
```

During documentation closure in this environment, those commands could not be executed because `fvm`, `flutter`, and `dart` were not available in the execution container. The project-local validation expectation remains unchanged.


---

## Phase 8.5 Development Boundary

Phase 8.5 continued the controlled agent-assisted implementation flow and completed security, reliability, diagnostics, warning, lock/lifecycle, and invalid-state maturity.

The code subphases were intentionally limited to:

- safe RPC diagnostics output;
- signing request limits, warnings, confirmation copy, cancellation behavior, and result copy;
- backup/export and restore warning consistency plus safe backup error normalization;
- lifecycle refresh behavior while locked and platform-safe screenshot protection;
- safe user-facing error helpers for invalid state, refresh, send, token, and async UI surfaces;
- pending transaction-history preservation when receipt refresh cannot complete;
- focused tests for diagnostics, signing, backup warnings, route boundaries, error safety, and pending transaction-history preservation.

They did not alter:

- wallet account persistence ownership;
- encrypted backup payload format semantics;
- route ownership by `GoRouter`;
- shell presentation-only ownership;
- release automation;
- build automation;
- telemetry or analytics behavior;
- dApp or WalletConnect scope.

### Phase 8.5 Closure Validation Boundary

The closure was processed as a documentation-only close over the implemented runtime work. The expected project-local validation commands remain:

```bash
fvm flutter analyze
fvm flutter test
```

Those commands are the correct validation gate for the developer workstation or CI environment. The closure documentation does not replace those commands; it records the real implementation scope and keeps the next Phase 8 work from inheriting ambiguous assumptions.

---

## Phase 8.6 Development Boundary

Phase 8.6 is complete as a release and distribution maturity extension after Phase 8.5. It closed without modifying wallet runtime behavior or introducing a new release ownership model.

The phase remained limited to release-tooling and distribution-documentation concerns:

- `tool/build.dart` build automation maturity;
- `.github/workflows/release.yml` release workflow consistency;
- version, artifact, checksum, manifest, and report consistency;
- release validation and operator reporting;
- distribution metadata and store-readiness documentation;
- cross-platform packaging expectations for Android, Web, and Windows.

It did not alter:

- wallet account persistence ownership;
- asset, transaction, signing, backup, restore, diagnostics, routing, or lock runtime behavior;
- encrypted backup payload semantics;
- GoRouter ownership;
- Riverpod feature-state ownership;
- telemetry or analytics behavior;
- automatic Play Store upload, Microsoft Store submission, iOS distribution, or runtime update delivery.

Expected local validation for release-tooling work remains:

```bash
fvm flutter analyze
fvm flutter test
dart run tool/build.dart --check-version --expected-tag v0.2.1
dart run tool/build.dart --platform android-apk --no-version-bump
dart run tool/build.dart --platform android-bundle --no-version-bump
dart run tool/build.dart --platform web --no-version-bump
dart run tool/build.dart --platform windows-msix --no-version-bump
```

Phase 8.6 generated release reports under `build/release/` and CI release metadata under the GitHub Release asset directory. Those outputs are generated evidence and must not be confused with committed source files.

Future development phases must preserve the Phase 8.6 boundary unless a later phase explicitly expands release automation. Store upload, store submission, runtime update delivery, analytics, telemetry, iOS distribution, WalletConnect, dApp connectivity, and wallet runtime feature expansion remain out of scope after this closure.


---

## Phase 9 Development Boundary

Phase 9 development must remain bounded to application identity, versioning, and visual theme maturity. Phase 9.0 is complete as a documentation-only lock. Phase 9.1 is complete as the first implementation slice and introduces only the runtime app version surface.

Expected implementation areas are:

- runtime app version resolution and Settings/About display — completed in 9.1 through `lib/core/app_identity`, `package_info_plus`, and Settings provider integration;
- build tool validation or hardening around `pubspec.yaml` and `msix_config.msix_version`;
- SCAVIUM design token normalization inside the app theme layer;
- light and dark theme implementation;
- local theme-mode selection and persistence;
- Settings/About alignment for version and appearance controls.

Development rules:

- do not change wallet custody, transaction, signing, backup, restore, RPC, diagnostics, or release publication semantics unless directly required by the version/theme task;
- keep theme logic centralized under the app/theme boundary where possible;
- avoid scattered per-screen color fixes before the token layer is defined;
- use focused tests for Settings/About version display and theme preference behavior where practical;
- continue using `fvm flutter analyze` and `fvm flutter test` as the baseline validation commands.

Build/version hardening in Phase 9 should document whether a command mutates `pubspec.yaml`, synchronizes MSIX metadata, or intentionally leaves version data unchanged because `--no-version-bump` was requested.

### Phase 9.2 Build Version & MSIX Synchronization Hardening

Phase 9.2 is planned as the next compact implementation sequence after the completed runtime version surface. Development should execute it without changing release publication semantics, wallet runtime behavior, or theme behavior.

The planned nested sequence is:

- 9.2.1 — Build Version Baseline Inspection and Contract;
- 9.2.2 — Build Tool Version and MSIX Behavior Hardening;
- 9.2.3 — Build Version Validation Coverage;
- 9.2.4 — Release and Development Documentation Alignment;
- 9.2.close — Build Version & MSIX Synchronization Hardening Closure.

The expected implementation files are `tool/build.dart`, optional focused build-version validation tests or helpers, and trunk documentation. `pubspec.yaml` may be touched only by intentional build/version behavior or dependency/test needs, and it must remain coherent after validation. `.github/workflows/release.yml` should remain outside the default 9.2 scope unless code inspection proves a real CI inconsistency.

### Phase 9.1 Runtime Version Surface

Phase 9.1 establishes the first concrete Phase 9 development pattern: keep application identity behind a narrow boundary and test UI behavior through provider overrides rather than machine-local package metadata.

The implemented runtime version surface uses `AppVersionInfo` for display formatting and `appVersionInfoProvider` for Settings/About consumption. Development of later Settings/About work should preserve this boundary instead of reintroducing direct package metadata reads into UI widgets.

### Phase 9.0 Documentation Lock

Phase 9.0 validates the phase contract before implementation:

- Phase 8.6 remains closed and is not reopened by identity/theme work.
- Phase 9 scope is limited to runtime version identity, build/MSIX version consistency, SCAVIUM design tokens, light/dark themes, theme-mode persistence, and Settings/About alignment.
- No code validation command is required for the documentation-only lock, but later implementation subphases must return to `fvm flutter analyze` and `fvm flutter test`.
- Generated `.agent/*` files are not part of this closure unless a later task explicitly requests agent generation.

