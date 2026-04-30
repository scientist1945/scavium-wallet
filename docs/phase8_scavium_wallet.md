# Phase 8 — Product Expansion & Production Maturity

## Overview

Phase 8 begins after SCAVIUM Wallet completed Phase 7 stabilization, bug fixing, release candidate hardening, encrypted recovery support, Windows MSIX readiness, and GitHub Release automation.

At the beginning of this phase the wallet is no longer treated as an unstable prototype or as a release-engineering-only project. It has a stable operational baseline and can now expand product capabilities in a controlled way.

The purpose of Phase 8 is to transform SCAVIUM Wallet from a stabilized wallet into a broader, production-mature product surface while preserving the architecture, release model, backup and restore semantics, and multiplatform compatibility achieved in the previous phases.

This phase introduces product expansion through clearly bounded areas:

- account model expansion
- asset and portfolio expansion
- transaction and activity maturity
- message signing capability
- navigation and product surface maturity
- security, reliability, and diagnostics hardening
- release and distribution maturity extension

Phase 8 must remain incremental and non-disruptive.

It must not convert the project into a broad redesign effort.

---

## Initial Context

Phase 7 ended with SCAVIUM Wallet in a stable release-oriented state.

The confirmed baseline includes:

- Flutter + Dart application structure
- Riverpod-based state management
- GoRouter-based navigation
- secure wallet persistence
- lock-aware runtime behavior
- transaction execution support
- asset and history surfaces
- RPC diagnostics
- encrypted backup export and restore
- Android App Bundle and APK build support
- Windows MSIX packaging support
- Dart-native build orchestration through `tool/build.dart`
- GitHub Actions release automation through `.github/workflows/release.yml`
- GitHub draft release publication with attached artifacts

Phase 7 also established a critical operating rule: stabilization work must not hide architectural drift inside small fixes.

Phase 8 continues that discipline while allowing controlled product expansion.

---

## Problem Statement

The wallet currently has enough stability to be released and tested, but its functional and UX model still reflects an earlier product stage.

The existing product surface is still close to a one-page or dashboard-centered wallet experience.

That model does not scale cleanly when the product needs to support:

- multiple accounts or wallets
- account switching
- richer account metadata
- broader asset organization
- portfolio summaries
- more mature activity history
- transaction status details
- message signing flows
- security confirmations
- a larger settings and diagnostics surface

If these capabilities are added without a controlled Phase 8 plan, the likely result is:

- overloaded screens
- duplicated UI logic
- inconsistent navigation
- unclear separation between wallet, assets, activity, and settings
- increased regression risk in backup and restore
- higher risk in sensitive signing flows
- release pipeline drift

Phase 8 solves this by expanding the wallet through explicit product layers rather than by accumulating unrelated UI additions.

---

## Root Cause Analysis

Phase 7 correctly optimized the project for release stabilization.

That required:

- fixing platform regressions
- hardening persistence
- validating recovery
- improving release reproducibility
- keeping fixes small and safe

The result is a solid baseline, but not yet a mature product expansion architecture.

The root issue is not that the existing architecture is wrong.

The root issue is that the current product surface needs to evolve from stabilized wallet functionality into a scalable multi-surface application while keeping the same architectural principles.

The solution is to introduce Phase 8 as a controlled expansion phase with clear subphase boundaries and strict compatibility requirements.

---

## Phase Goals

Phase 8 has the following goals:

1. Expand the account model without breaking existing wallet creation, import, secure persistence, backup, or restore.
2. Prepare the wallet for multiple accounts and account-specific product surfaces.
3. Improve asset and portfolio representation without introducing unstable token behavior.
4. Mature transaction and activity views, including status and receipt-oriented details.
5. Introduce message signing through explicit and safe UX flows.
6. Evolve navigation from a limited single-surface experience into a structured product shell.
7. Improve security, reliability, diagnostics, and user-facing safety feedback.
8. Extend release maturity only after product expansion work proves stable.

---

## Non-Goals

Phase 8 does not include:

- replacing Riverpod
- replacing GoRouter
- redesigning the full application architecture
- replacing the secure persistence model
- rewriting backup and restore
- introducing backend dependencies
- implementing full dApp browser support
- implementing complex multi-chain support
- automating store publication
- changing CI/CD fundamentals before product expansion stabilizes
- making broad visual redesigns unrelated to the phase goals

---

## Implementation Rules

All Phase 8 work must follow these rules:

- changes must be incremental
- subphases must remain independently reviewable
- no feature may silently break backup or restore compatibility
- no feature may bypass secure storage expectations
- navigation changes must preserve existing routes unless explicitly migrated
- signing flows must include preview and explicit confirmation
- sensitive flows must prefer safe failure over silent success
- release automation must not be modified before the relevant release-maturity subphase
- documentation must remain cumulative and trunk-aligned

---

## Workflow Pilot Lock

Phase 8.0 is also used as the first controlled test of a lower-friction workflow.

The project keeps the same discipline used in previous phases:

- real project state first
- no assumptions outside the provided source tree
- phase-by-phase planning
- documentation before implementation
- small and reviewable changes
- explicit validation
- Git commands per subphase

The workflow change is limited to transport and execution model.

Previous workflow:

```text
Chat defines work
ZIP is exchanged manually
Files are copied and reviewed manually
Implementation is validated locally
New ZIP is sent back for review
```

Pilot workflow:

```text
Chat defines phase and contract
Working tree or ZIP is treated as source of truth
Agent-style execution reads real files
Only approved files are modified
Diff/review remains explicit
Validation remains local and controlled
```

The method does not change.

Only the transport is being tested.

For Phase 8.0, the pilot is intentionally documentation-only.

No Dart code, build tooling, CI workflow, backup logic, restore logic, routing behavior, or runtime feature code is modified.

---

## Phase Structure

## 8.0 — Phase 8 Definition & Workflow Pilot Lock

### Objective

Introduce Phase 8 into the documentation trunk and establish the workflow pilot boundary without touching functional code.

### Scope

This subphase includes:

- creation of the Phase 8 document
- documentation alignment from Phase 7 into Phase 8
- index updates
- README status updates
- architecture, features, and UX alignment where necessary
- explicit statement that Phase 8 begins after Phase 7 stabilization
- explicit preservation of build, release, backup, restore, Riverpod, and GoRouter baselines

### Out of Scope

This subphase does not include:

- Dart code changes
- account model implementation
- asset model implementation
- signing implementation
- navigation refactor
- `tool/build.dart` changes
- `.github/workflows/release.yml` changes
- backup or restore changes

### Completion Criteria

Phase 8.0 is complete when:

- `docs/phase8_scavium_wallet.md` exists
- documentation references Phase 8 as the current expansion phase
- Phase 7 remains preserved as the completed stabilization baseline
- no runtime code has been modified
- the next executable subphase is clearly identified as 8.1

---

## 8.1 — Account Model Expansion

### Objective

Expand the account model so the wallet can support multiple accounts or wallets while preserving the existing single-wallet behavior as the compatibility baseline.

### Scope

This subphase may include:

- multi-account structure
- active account selection
- account switcher foundation
- account metadata
- labels or aliases
- default account behavior
- secure persistence extension
- backup and restore compatibility analysis
- migration path from the current single-wallet model

### Architecture Constraints

The implementation must preserve:

- Riverpod controller ownership
- secure storage responsibility for sensitive material
- existing wallet creation and import paths
- existing lock flow
- existing recovery model

### Validation Requirements

Validation must confirm:

- existing single-wallet users remain valid
- wallet creation still works
- wallet import still works
- lock/unlock still works
- backup export still works
- restore still works
- active account is deterministic

### Impact

This subphase becomes the foundation for all later Phase 8 work.

Assets, activity, signing, and UX surfaces must eventually become account-aware.

---

## 8.1.0 — Account Model Contract Definition

### Objective

Define the technical and documentary contract for expanding SCAVIUM Wallet from the current single-account model into a future multi-account model without changing runtime behavior yet.

This subphase exists because account expansion affects secure storage, wallet profile shape, backup and restore payloads, Riverpod controller ownership, UI surfaces, and later asset, activity, and signing behavior.

It must therefore be defined before implementation starts.

### Current Baseline

The current Phase 7 / Phase 8.0 baseline is a stable single-account wallet.

The active model is conceptually:

```text
WalletProfile
└── WalletAccount account
```

The existing persisted wallet state is also single-wallet oriented and includes legacy storage keys for wallet type, mnemonic, private key, address, and account name.

The existing backup payload is versioned as a single-wallet backup and must remain restorable.

This baseline is valid and must not be treated as incorrect.

Phase 8.1 expands it through compatibility, not replacement.

### Target Contract

The future account model should evolve toward:

```text
WalletProfile
├── accounts[]
├── activeAccountId
├── defaultAccountId
├── hasMnemonic
├── biometricEnabled
└── wallet source / type metadata
```

Each account should eventually expose a stable account record such as:

```text
WalletAccount
├── id
├── name / label
├── address
├── accountIndex
├── isDefault
├── isActive
├── isImportedByPrivateKey
├── createdAt
└── updatedAt
```

The exact code shape may be refined during implementation, but the compatibility semantics must remain stable.

### Legacy Compatibility Rule

The existing single account must migrate logically into the first account slot:

```text
legacy wallet account -> accounts[0]
activeAccountId -> accounts[0].id
defaultAccountId -> accounts[0].id
```

This must preserve:

- existing mnemonic material
- existing private-key import behavior
- existing wallet address
- existing account name
- existing PIN and lock behavior
- optional biometric unlock behavior
- existing backup export and restore behavior

No user with a valid Phase 7 wallet should be forced through onboarding again solely because multi-account support is introduced.

### Backup and Restore Contract

Backup compatibility is a first-class requirement of account expansion.

Future implementation should support a v2-style account-aware payload while keeping v1 restore compatibility.

The expected direction is:

```text
Backup v1
└── wallet

Backup v2
├── accounts[]
├── activeAccountId
├── defaultAccountId
└── wallet metadata
```

Restoring a v1 backup should create a valid single-account profile under the new model.

Exporting a multi-account backup must be delayed until the account model and migration semantics are explicit and validated.

### Provider and Controller Contract

Riverpod remains the state-management owner.

Future account expansion must not bypass the existing controller/repository boundaries.

The recommended direction is:

- repository owns persistence compatibility
- controller owns selected active account state
- UI observes account-aware read models
- secure storage remains the authority for sensitive wallet material
- account switcher UI must not directly mutate secure wallet state

### Implementation Order After 8.1.0

The recommended 8.1 sequence is:

1. 8.1.1 — Domain model preparation
2. 8.1.2 — Storage migration foundation
3. 8.1.3 — Active account controller
4. 8.1.4 — Account switcher foundation
5. 8.1.5 — Backup and restore compatibility upgrade

This order keeps the model stable before adding user-visible switching behavior.

### Out of Scope

This subphase does not implement:

- Dart runtime changes
- secure storage migrations
- account switcher UI
- backup v2 code
- route changes
- asset account partitioning
- signing account selection

### Completion Criteria

Phase 8.1.0 is complete when:

- the account expansion contract is documented
- legacy single-account migration semantics are explicit
- backup v1/v2 direction is documented
- provider ownership expectations are documented
- the next implementation subphase is identified as 8.1.1
- no runtime code, build tooling, CI workflow, or release automation has been modified

---

## 8.1.1 — Domain Model Preparation

### Objective

Prepare the wallet domain model for account-aware evolution while preserving the current single-account runtime behavior.

This subphase introduces the internal shape required by the 8.1.0 contract without changing storage layout, backup format, routes, UI behavior, release automation, or onboarding flows.

The application must continue to behave as a Phase 7 / Phase 8.0 single-account wallet from the user's perspective.

### Implementation Summary

The domain model now supports a compatibility bridge between the legacy single-account profile and the future multi-account profile.

The compatibility shape is:

```text
WalletProfile
├── account                 # legacy-compatible active account accessor
├── accounts[]              # future account collection foundation
├── activeAccountId         # selected account identity foundation
├── defaultAccountId        # default account identity foundation
├── hasMnemonic
└── biometricEnabled
```

`WalletAccount` now carries account metadata needed by later subphases:

```text
WalletAccount
├── id
├── name
├── label
├── address
├── accountIndex
├── isImportedByPrivateKey
├── isDefault
├── isActive
├── createdAt
└── updatedAt
```

The account id is derived deterministically for the current legacy account using address plus account index. This avoids introducing a new persistence dependency during this subphase.

### Compatibility Semantics

The existing account continues to be represented as:

```text
profile.account
```

At the same time, the same account is normalized into:

```text
profile.accounts[0]
profile.activeAccountId
profile.defaultAccountId
```

For the current single-account runtime, the active and default account are the same account.

This preserves compatibility with existing screens and flows that already read:

```text
profile.account.address
profile.account.name
```

### Repository Boundary

`WalletRepositoryImpl` now builds a single-account profile through a dedicated internal helper instead of repeatedly constructing the legacy profile shape inline.

The repository remains responsible for adapting the current persisted wallet state into the domain model.

No new storage keys are introduced in this subphase.

No migration is executed in this subphase.

### Out of Scope

This subphase does not implement:

- multi-account persistence
- account creation beyond the existing wallet account
- account switching
- account switcher UI
- backup v2 export
- backup v2 restore
- token partitioning by account
- signing account selection
- route changes
- release pipeline changes

### Validation Expectations

The following behavior must remain unchanged:

- create wallet from mnemonic
- import wallet from mnemonic
- import wallet from private key
- load wallet profile
- export backup v1
- restore backup v1
- read `profile.account` from existing UI
- lock and biometric behavior

The expected technical validation remains:

```bash
flutter analyze
flutter test
```

### Completion Criteria

Phase 8.1.1 is complete when:

- `WalletAccount` exposes account metadata required by the 8.1 contract
- `WalletProfile` supports `accounts`, `activeAccountId`, and `defaultAccountId`
- `profile.account` remains backward-compatible
- repository-loaded wallets normalize into a single-account account list
- no storage migration is introduced
- no backup payload version is changed
- no UI behavior is changed
- no route, build, CI, or release automation is changed

---


## 8.1.1.fix1 — WalletProfile Constructor Lint Cleanup

### Objective

Clean up the constructor lint introduced during Phase 8.1.1 without changing runtime behavior, account compatibility semantics, storage behavior, backup behavior, routing, UI, build tooling, or release automation.

### Implementation Summary

`WalletProfile` now uses an initializing formal for the required legacy-compatible account field.

This keeps the existing compatibility contract intact:

```text
profile.account
profile.accounts[0]
profile.activeAccountId
profile.defaultAccountId
```

No account normalization logic changed.

No multi-account persistence was introduced.

No backup format changed.

### Completion Criteria

Phase 8.1.1.fix1 is complete when:

- the `prefer_initializing_formals` lint in `WalletProfile` is removed
- `WalletProfile` continues to normalize the legacy account into `accounts[]`
- no storage, backup, UI, routing, build, or release behavior changes
- Phase 8.1.1 remains ready for Phase 8.1.2

---
## 8.2 — Asset & Portfolio Expansion


### Objective

Improve asset representation and prepare the wallet for a richer portfolio view.

### Scope

This subphase may include:

- improved asset list presentation
- account-aware asset organization
- manual token registration foundation
- token metadata representation
- portfolio summary structure
- improved native and token balance visibility
- safer empty, loading, and error states

### Architecture Constraints

The implementation must not introduce an unstable token discovery system.

Manual token support should be explicit, deterministic, and safe.

Asset data should remain clearly separated from account state, RPC state, and UI rendering.

### Validation Requirements

Validation must confirm:

- existing native balance behavior remains intact
- existing token behavior remains intact
- assets can be organized by selected account once account support exists
- invalid token input is handled safely
- UI does not degrade on mobile, web, or desktop-sized layouts

### Impact

This subphase prepares the product for broader wallet usage without requiring multi-chain scope.

---

## 8.3 — Transaction & Activity Maturity

### Objective

Mature the operational activity layer of the wallet.

### Scope

This subphase may include:

- improved transaction history
- explicit transaction states
- pending, confirmed, failed, and unknown states
- transaction detail view
- receipt-oriented display
- filtering or grouping foundations
- safer error presentation

### Message Signing Scope

Phase 8.3 also introduces message signing maturity.

Supported planned signing capabilities include:

- `signPersonalMessage(...)`
- `signChallengeMessage(...)`

Signing UX must include:

- message preview
- account/address visibility
- explicit confirmation
- cancellation path
- success result display
- error handling
- clear distinction between signing a message and sending a transaction

### Architecture Constraints

Signing must not be treated as a background convenience operation.

It is a sensitive wallet action and must be handled with the same user-confirmation discipline as transaction submission.

### Validation Requirements

Validation must confirm:

- existing transaction flows still work
- transaction history remains available
- signing does not submit a blockchain transaction
- signing uses the intended active account
- signing output is deterministic for supported inputs
- cancellation does not mutate wallet state

### Impact

This subphase turns the wallet into a more complete operational tool while keeping sensitive actions explicit and reviewable.

---

## 8.4 — UX & Product Surface Maturity

### Objective

Evolve the wallet UI from a limited or one-page-oriented surface into a scalable multi-surface product shell.

### Scope

This subphase may include:

- navigation shell evolution
- desktop and web sidebar
- mobile drawer or bottom navigation
- clearer screen segmentation
- Home or Dashboard surface
- Wallet or Accounts surface
- Assets surface
- Activity surface
- Settings surface
- responsive layout consistency
- preservation of existing route names where safe

### Implementation Order Note

A partial navigation evolution may be introduced before Phase 8.3 if needed to prevent UI overload.

The recommended implementation order allows:

1. account model expansion
2. asset and portfolio expansion
3. partial navigation evolution
4. transaction and signing maturity
5. remaining UX consolidation

### Architecture Constraints

Navigation must continue to use GoRouter.

The product shell must not become a hidden state-management layer.

Feature state remains owned by Riverpod controllers and feature modules.

### Validation Requirements

Validation must confirm:

- existing routes remain reachable
- mobile layout remains usable
- desktop/web layout gains scalable navigation
- settings and diagnostics remain accessible
- no route loops are introduced
- lock-aware routing remains valid

### Impact

This subphase prevents product expansion from degrading UX as features grow.

---

## 8.5 — Security, Reliability & Diagnostics Maturity

### Objective

Strengthen production behavior around sensitive flows, recovery assumptions, error handling, and diagnostics.

### Scope

This subphase may include:

- additional validations around signing
- additional validations around recovery
- improved error handling
- improved user-facing warnings
- confirmation improvements
- diagnostics that remain non-invasive
- safety checks for account-aware behavior
- stricter handling of invalid or partial state

### Architecture Constraints

Diagnostics must not leak sensitive wallet material.

Security UX must not create false confidence.

Sensitive action confirmations must remain explicit.

### Validation Requirements

Validation must confirm:

- invalid states fail safely
- sensitive data is not exposed in logs or UI
- backup and restore warnings remain clear
- signing warnings are visible before confirmation
- diagnostics do not alter wallet state

### Impact

This subphase raises confidence in the expanded wallet without turning diagnostics into telemetry or invasive monitoring.

---

## 8.6 — Release & Distribution Maturity Extension

### Objective

Extend the release and distribution pipeline after product expansion work is stable enough to justify release-process improvements.

### Scope

This subphase may include:

- extension of `tool/build.dart`
- extension of `.github/workflows/release.yml`
- additional release validation checks
- metadata improvements
- artifact consistency improvements
- clearer release reporting
- packaging consistency across supported platforms

### Architecture Constraints

Release tooling changes must not destabilize the proven Phase 7 release baseline.

The existing build commands and GitHub Release automation must remain compatible unless a change is explicitly documented and validated.

### Validation Requirements

Validation must confirm:

- existing build commands still work
- Android App Bundle generation still works
- Android APK generation still works
- Windows MSIX generation still works
- SHA256 checksum generation remains intact
- release validation remains deterministic

### Impact

This subphase consolidates production maturity after product functionality has expanded.

---

## Recommended Implementation Order

The recommended Phase 8 order is:

1. 8.0 — Phase 8 Definition & Workflow Pilot Lock
2. 8.1 — Account Model Expansion
3. 8.2 — Asset & Portfolio Expansion
4. 8.4 (partial) — Navigation Evolution
5. 8.3 — Transaction & Activity Maturity, including signing
6. 8.4 (remaining) — UX Consolidation
7. 8.5 — Security, Reliability & Diagnostics Maturity
8. 8.6 — Release & Distribution Maturity Extension

This order is intentional.

Account modeling comes before account-aware assets and activity.

Navigation evolves before the UI becomes overloaded by activity and signing features.

Security and release hardening happen after the expanded product surface is sufficiently concrete.

---

## Documentation Rules

Phase 8 documentation must remain cumulative.

The following documents act as trunk references:

- `README.md`
- `docs/index.md`
- `docs/architecture.md`
- `docs/features.md`
- `docs/ux.md`
- `docs/release.md`
- `docs/phase7_scavium_wallet.md`
- `docs/phase8_scavium_wallet.md`

Phase 8 documentation must not erase Phase 7 history.

Phase 7 remains the stabilization and release-hardening baseline.

Phase 8 begins product expansion from that baseline.

---

## Validation Model

Every Phase 8 subphase should be validated with the appropriate level of checks for its scope.

Documentation-only subphases should validate:

- modified document list
- no code changes
- phase narrative consistency
- index and README alignment

Runtime subphases should validate:

- `flutter analyze`
- relevant Flutter tests if present
- platform build checks when practical
- route and navigation checks
- backup and restore compatibility checks
- signing-specific checks when applicable

Release subphases should validate:

- existing build commands
- version checks
- artifact creation
- release metadata consistency
- GitHub Actions compatibility

---

## Risk Register

### UI Overload

Risk:

- New features may overload the existing home-centered interface.

Mitigation:

- Introduce navigation evolution before activity and signing surfaces become too large.

### Account Migration Risk

Risk:

- Multi-account support may disrupt existing single-wallet users.

Mitigation:

- Treat the current wallet as the default account compatibility baseline.

### Backup and Restore Drift

Risk:

- Account expansion may create backup payload ambiguity.

Mitigation:

- Keep backup compatibility analysis inside account model work.

### Signing UX Risk

Risk:

- Message signing may be confused with transaction submission or treated too casually.

Mitigation:

- Require preview, explicit confirmation, and clear result handling.

### Release Pipeline Drift

Risk:

- Tooling changes may destabilize the proven Phase 7 release baseline.

Mitigation:

- Defer release tooling changes until 8.6.

---

## Completion Criteria for Phase 8

Phase 8 can be considered complete when:

- account expansion is implemented safely
- assets and portfolio surfaces are improved
- activity and transaction details are more mature
- message signing is implemented with explicit UX safety
- product navigation supports expanded surfaces across form factors
- security and diagnostics are strengthened without exposing secrets
- release tooling is extended without breaking the Phase 7 baseline
- documentation remains aligned with the implemented state

---

## Conclusion

Phase 8 represents the transition from a release-stabilized SCAVIUM Wallet into a more complete production-mature wallet product.

The phase does not discard the Phase 7 baseline.

It builds on it.

The key principle is controlled expansion:

- expand accounts before account-aware product surfaces
- expand assets before portfolio maturity
- evolve navigation before UI overload
- introduce signing only with explicit confirmation UX
- harden security and release processes after product expansion is concrete

This keeps SCAVIUM Wallet on a safe path from stabilized release candidate to mature user-facing product.

---

## Phase 8.1.2 — Storage Migration Foundation

Status: Implemented as a compatibility foundation.

Purpose:

- prepare wallet persistence for the multi-account model introduced by 8.1.1
- keep all legacy single-wallet keys intact
- avoid changing visible behavior, navigation, backup/restore, or release tooling

Implementation notes:

- The existing wallet remains the compatibility baseline.
- Legacy keys continue to be written and read:
  - `wallet_type`
  - `wallet_mnemonic`
  - `wallet_private_key`
  - `wallet_address`
  - `wallet_account_name`
- Multi-account metadata is now persisted in parallel:
  - `wallet_accounts_json`
  - `wallet_active_account_id`
  - `wallet_default_account_id`
  - `wallet_storage_version`
- The current single wallet is migrated into `accounts[0]` when multi-account metadata is missing.
- Runtime loading prefers the stored account metadata when present, but falls back safely to the legacy wallet.
- `clearWallet()` removes both legacy and multi-account storage keys.

Compatibility rule:

```text
legacy wallet -> accounts[0]
activeAccountId = accounts[0].id
defaultAccountId = accounts[0].id
wallet_storage_version = 2
```

Behavioral constraints:

- No account switcher is introduced in this subphase.
- No additional account creation UI is introduced.
- Backup/restore v1 remains unchanged.
- Existing wallet creation, mnemonic import, private-key import, and profile loading remain single-account compatible.

Validation expectations:

- `fvm flutter analyze`
- `fvm flutter test`
- create wallet from mnemonic
- import wallet from mnemonic
- import wallet from private key
- load an existing legacy wallet and verify it receives parallel multi-account metadata
- clear wallet and verify legacy plus multi-account keys are removed

Next subphase:

- 8.1.3 — Active Account Controller, which can begin using the persisted account metadata without changing the storage contract again.
