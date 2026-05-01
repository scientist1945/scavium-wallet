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

---

## Phase 8.1.3 — Active Account Controller

Status: Implemented as an internal controller foundation.

Purpose:

- introduce active-account selection at the controller and repository boundary
- keep the app visually single-account compatible
- use the multi-account storage metadata introduced in Phase 8.1.2
- avoid introducing account switcher UI, additional routing, backup changes, build changes, or release changes

Implementation notes:

- `WalletRepository` now exposes `setActiveAccount(String accountId)`.
- `WalletRepositoryImpl` resolves the requested account from the stored `WalletProfile.accounts` list.
- The selected account is persisted through `wallet_active_account_id`.
- Account flags are normalized so that only the selected account is active and only the default account remains default.
- `WalletController` exposes the current active account and delegates active-account changes through the repository.
- `WalletProfile.account` remains the compatibility account used by existing UI and runtime code.

Compatibility rule:

```text
profile.account == profile.activeAccount
wallet_active_account_id == profile.activeAccountId
```

Behavioral constraints:

- No account switcher is introduced in this subphase.
- No multiple-account creation flow is introduced in this subphase.
- Backup/restore v1 remains unchanged.
- Existing wallet creation, import, loading, reset, and visible surfaces remain compatible.

Validation expectations:

- `fvm flutter analyze`
- `fvm flutter test`
- create wallet from mnemonic
- import wallet from mnemonic
- import wallet from private key
- load an existing wallet and verify the active account remains stable
- call the active-account controller path against the current account id and verify no visible behavior changes

Next subphase:

- 8.1.4 — Account Switcher Foundation, which can introduce a minimal UI surface for selecting among already-known accounts without changing the storage contract again.


---

## Phase 8.1.4 — Account Switcher Basic UI

Status: Implemented as a minimal user-facing switcher foundation.

Purpose:

- introduce a visible account switcher surface on the existing home/dashboard area
- display the currently active account through the account-aware profile model
- allow active-account selection only among accounts already known by the wallet profile
- preserve the Phase 7 single-account experience as a compatible fallback
- avoid introducing account creation, import, deletion, editing, backup changes, route changes, build changes, or release workflow changes

Implementation notes:

- `AccountSwitcher` was added as a reusable wallet presentation widget.
- `HomeScreen` now renders the account switcher as a separate card below the balance summary.
- The switcher reads `WalletProfile.accounts` and `WalletProfile.activeAccount`.
- Account changes are delegated through `WalletController.setActiveAccount(...)`.
- Single-account wallets render the current account as the only available account and keep switching disabled.
- Copy/explorer actions continue to use the active account address.

Compatibility rule:

```text
single-account wallet -> one visible account option
multi-account profile -> selectable existing account options
```

Behavioral constraints:

- No additional accounts are created by this UI.
- No imported account management flow is added in this subphase.
- No account deletion or label editing is added in this subphase.
- Backup/restore v1 remains unchanged.
- Existing routes remain unchanged.
- Build and release tooling remain unchanged.

Validation expectations:

- `fvm flutter analyze`
- `fvm flutter test`
- load a legacy single-account wallet and verify the switcher renders one account
- verify the selected account address is the address used by copy/explorer actions
- verify wallet creation/import/reset behavior remains unchanged
- verify no route, backup, release, or build behavior changed

Next subphase:

- 8.1.5 — Backup and restore compatibility upgrade, which can formalize backup payload evolution after the account model, storage foundation, controller path, and basic switcher surface are already in place.

---

## Phase 8.1.5 — Account Creation & Import Expansion

### Status

Implemented as a controlled functional expansion over the multi-account foundation introduced in 8.1.1, 8.1.2, 8.1.3, and 8.1.4.

### Objective

Enable the wallet to add real additional accounts while preserving the existing Phase 7 single-account compatibility model and without introducing backup v2 changes yet.

### Scope

This subphase introduces:

- derived account creation for mnemonic wallets;
- additional imported private-key accounts;
- secure persistence for imported account private keys;
- account append-and-activate behavior;
- duplicate address protection;
- a minimal add-account bottom sheet connected to the existing account switcher.

### Compatibility Rules

The implementation preserves the existing compatibility boundary:

- the original legacy wallet keys remain valid;
- backup/restore v1 remains unchanged;
- routes remain unchanged;
- release/build automation remains unchanged;
- account switcher remains the only new user-facing entry point;
- the existing active-account controller remains the runtime owner of account switching.

### Storage Rules

Additional accounts are persisted through the existing multi-account metadata store:

- `wallet_accounts_json`
- `wallet_active_account_id`
- `wallet_default_account_id`
- `wallet_storage_version`

Imported account private keys are persisted separately in secure storage through:

- `wallet_imported_private_keys_json`

This avoids exposing imported private keys through account metadata and keeps backup v2 as a later, explicit compatibility phase.

### Functional Behavior

When a derived account is created:

1. the current wallet profile is loaded;
2. the existing mnemonic is required;
3. the next available `accountIndex` is selected;
4. the account is derived from the mnemonic;
5. the account is appended to `accounts[]`;
6. the new account becomes active.

When a private-key account is imported:

1. the private key is normalized and validated;
2. the address is extracted;
3. duplicate addresses are rejected;
4. the private key is stored in secure account-key storage;
5. the account is appended to `accounts[]`;
6. the new account becomes active.

### Explicit Non-Scope

This subphase does not add:

- account deletion;
- account label editing;
- backup payload v2;
- route restructuring;
- release pipeline changes;
- full multi-surface navigation.

### Validation Expectations

The expected validation gate remains:

```bash
fvm flutter analyze
fvm flutter test
```

The analyze baseline should not increase beyond known pre-existing issues.

---

## Phase 8.1.6 — Backup / Restore Multi-Account Compatibility

### Objective

Extend the wallet backup and restore flow so the Phase 8.1 multi-account model can be exported and restored without breaking existing Phase 7 / Phase 8.1 legacy backup payloads.

### Scope

This subphase formalizes backup payload version 2 as the account-aware backup format.

The backup payload now preserves:

- the current wallet root material contract (`wallet`);
- `accounts[]` metadata;
- `activeAccountId`;
- `defaultAccountId`;
- imported-account private keys when required for operational restore.

### Compatibility Rules

Backup compatibility remains strictly additive:

- backup payload v1 remains valid;
- restore of v1 payloads continues to rebuild a single-account profile;
- backup payload v2 restores the multi-account profile and persists account metadata;
- imported account private keys are included only inside encrypted backup payloads;
- derived accounts continue to rely on the mnemonic-backed wallet material.

### Security Rules

Imported private keys are not stored in account metadata. They remain in secure storage at runtime and are only serialized into encrypted backup payloads so imported accounts can remain usable after restore.

The encrypted backup envelope is not replaced in this subphase. The change is limited to the decrypted wallet payload schema.

### Explicit Non-Scope

This subphase does not add:

- backup v3;
- release/build changes;
- route changes;
- account deletion;
- account label editing;
- navigation restructuring.

### Validation Expectations

The expected validation gate remains:

```bash
fvm flutter analyze
fvm flutter test
```

The restore path must continue to accept v1 payloads while enabling v2 multi-account restore.

---

## 8.2.0 — Asset Model Contract Definition and Baseline Inspection

### Objective

Establish the Phase 8.2 asset and portfolio contract before accepting code-level expansion, using the real Phase 8.1 multi-account baseline and the existing asset/token implementation as the source of truth.

### Baseline Confirmed

Before Phase 8.2 code changes, the wallet already had:

- an Assets surface routed through the existing GoRouter configuration;
- native SCAVIUM balance loading through the RPC layer;
- manual ERC-20 token registration foundation;
- token metadata loading through the RPC service;
- ERC-20 balance loading through the active wallet address;
- local token registry persistence;
- asset detail and send-token flows;
- Phase 8.1 account model, active account, switcher, and backup compatibility.

### Contract

Phase 8.2 expands the asset surface without replacing the existing architecture.

The asset model must remain:

- deterministic;
- account-aware where the current architecture supports it;
- explicit about manual token registration;
- independent from automatic token discovery;
- independent from multi-chain aggregation;
- compatible with current routes;
- compatible with the Phase 8.1 active-account model.

### Non-Scope

Phase 8.2.0 and the subsequent 8.2 code subphases do not introduce:

- automatic token discovery;
- automatic indexer integration;
- multi-chain portfolio aggregation;
- route redesign;
- navigation shell redesign;
- backup format changes;
- release or build pipeline changes.

---

## 8.2.1 — Portfolio Summary Model Foundation

### Objective

Introduce a minimal portfolio summary foundation derived from currently visible assets, without changing persistence, token discovery, wallet storage, backup format, or navigation.

### Implementation Summary

Phase 8.2.1 adds the `PortfolioSummary` domain model.

The summary is computed from `AssetItem` entries and currently tracks:

- total visible assets;
- native asset count;
- ERC-20 asset count;
- non-zero asset count.

This keeps the summary deterministic and avoids unsupported assumptions about fiat valuation, token discovery, or chain-wide indexing.

### Runtime Behavior

The Assets screen can now display a summary card above the asset list.

The summary is intentionally derived from loaded assets only. It does not claim to represent off-chain valuation, undiscovered tokens, or assets outside the currently configured network and registry.

---

## 8.2.2 — Account-Aware Asset Context

### Objective

Attach the active wallet account context to loaded assets where supported by the current architecture.

### Implementation Summary

Phase 8.2.2 introduces `AssetAccountContext` and connects loaded native/ERC-20 asset items to the current active account from the wallet controller.

The context provides:

- account id;
- account name;
- optional account label;
- address;
- display name;
- shortened address presentation.

### Architecture Note

The RPC service continues to own blockchain reads. Asset loading remains dependent on the current wallet profile and active account semantics already introduced in Phase 8.1.

The implementation does not introduce a broad RPC redesign. It makes account context visible and traceable in the asset layer while preserving current balance and token behavior.

---

## 8.2.3 — Manual Token Safety & Metadata UX

### Objective

Harden manual ERC-20 token registration and metadata loading while preserving the current explicit manual-token model.

### Implementation Summary

Phase 8.2.3 improves token registration safety by introducing deterministic token address normalization and duplicate prevention.

The implementation includes:

- contract address validation before metadata loading;
- normalized lowercase storage address handling;
- duplicate-token prevention by normalized contract address;
- safe token metadata fallback behavior;
- user-visible metadata/loading errors through the add-token surface;
- non-destructive token registration behavior when errors occur.

### Safety Rule

Manual token registration remains explicit. The wallet does not scan for tokens automatically and does not infer user holdings from external indexers.

---

## 8.2.4 — Asset Surface Polish

### Objective

Improve the asset surface presentation for mobile, web, and desktop-sized layouts without introducing a new navigation shell or changing routes.

### Implementation Summary

Phase 8.2.4 improves the existing Assets screen by:

- displaying the portfolio summary card;
- showing the active account context when available;
- distinguishing native assets from ERC-20 tokens;
- improving list spacing and responsive width constraints;
- preserving refresh behavior;
- preserving asset detail navigation;
- preserving native and token send flows;
- keeping safe loading, empty, and error states.

### UX Constraint

This subphase intentionally avoids the Phase 8.4 navigation shell scope. It polishes the current asset surface without introducing drawer/sidebar/bottom navigation changes.

---

## 8.2.close — Asset & Portfolio Expansion Closure

### Objective

Close Phase 8.2 by confirming that the code-level implementation delivered by subphases 8.2.1 through 8.2.4 is coherently represented in the trunk documentation and remains aligned with the Phase 8 product expansion contract.

### Completed Scope

Phase 8.2 is complete with the following implemented capabilities:

- portfolio summary model foundation;
- account-aware asset context;
- native and ERC-20 asset items carrying account context;
- deterministic manual token address validation and normalization;
- duplicate-token protection;
- safer metadata loading and error presentation;
- improved asset list visual hierarchy;
- asset kind distinction;
- responsive asset surface polish.

### Boundaries Preserved

The completed implementation preserves the intended boundaries:

- no automatic token discovery;
- no multi-chain portfolio aggregation;
- no route redesign;
- no navigation shell redesign;
- no build or release automation changes;
- no wallet backup format change in Phase 8.2;
- no broad wallet account persistence change beyond the existing Phase 8.1 baseline.

### Validation Gate

The expected validation gate remains:

```bash
fvm flutter analyze
fvm flutter test
```

Any remaining analyzer warnings should be classified against the project baseline and not treated as Phase 8.2 regressions unless they are introduced by the Phase 8.2 files.

### Next Phase

The next planned Phase 8 area is:

```text
8.3 — Transaction & Activity Maturity
```

Phase 8.3 should build on the now-completed account-aware and asset-aware foundation.

---

## 8.3.0 — Transaction & Activity Contract Definition and Baseline Inspection

### Objective

Define the Phase 8.3 transaction, activity, and signing contract before implementation, using the real Phase 8.2-completed codebase as the baseline.

### Scope

This documentation-only subphase must inspect the current transaction and activity implementation and lock the intended execution boundaries for the rest of Phase 8.3.

The baseline currently includes:

- locally persisted outgoing transaction history;
- native and ERC-20 send flows;
- `TxHistoryEntry` as the stored activity record;
- `TxStatus` with pending, confirmed, and failed states;
- `TxKind` with native and ERC-20 send kinds;
- receipt refresh through `ScaviumRpcService.getReceipt(...)`;
- a `HistoryScreen` route backed by `TxHistoryController`.

### State

Implemented as a documentation-only baseline inspection and execution contract lock.

No runtime code was modified in this subphase. The current transaction and activity implementation was inspected and confirmed as the baseline for the remaining Phase 8.3 code subphases.

### Existing Files Intervened

- `docs/phase8_scavium_wallet.md` — records the completed Phase 8.3.0 baseline inspection, confirms the Phase 8.3 execution contract, and preserves the remaining subphase map.
- `docs/index.md` — records Phase 8.3.0 as completed while keeping Phase 8.3.1 through 8.3.close planned.

The following documents were reviewed as trunk documentation but did not require modification in this subphase:

- `README.md`
- `docs/architecture.md`
- `docs/architecture_deep.md`
- `docs/decisions.md`
- `docs/development.md`
- `docs/features.md`
- `docs/flows.md`
- `docs/phase1_scavium_wallet.md`
- `docs/phase2_scavium_wallet.md`
- `docs/phase3_scavium_wallet.md`
- `docs/phase4_scavium_wallet.md`
- `docs/phase5_scavium_wallet.md`
- `docs/phase6_scavium_wallet.md`
- `docs/phase7_scavium_wallet.md`
- `docs/privacy_policy.md`
- `docs/release.md`
- `docs/rpc.md`
- `docs/s.md`
- `docs/security.md`
- `docs/ux.md`

### New Files Created

No new files were created in this documentation-only subphase.

### Technical Justification

Phase 8.3 expands a sensitive wallet area. Transaction history, receipt interpretation, activity display, and message signing must be planned before code changes so signing is not implemented as a hidden convenience action and activity maturity does not become an uncontrolled explorer/indexer rewrite.

### Baseline Inspection Result

Phase 8.3.0 confirms that the Phase 8.2-completed codebase already contains a local outgoing-transaction baseline suitable for controlled Phase 8.3 expansion. The inspected runtime baseline includes:

- `lib/features/assets/domain/tx_history_entry.dart` as the persisted transaction-history record;
- `lib/features/assets/domain/tx_status.dart` with `pending`, `confirmed`, and `failed`;
- `lib/features/assets/domain/tx_kind.dart` with `nativeSend` and `erc20Send`;
- `lib/features/assets/domain/tx_history_repository.dart` as the persistence contract;
- `lib/features/assets/data/tx_history_repository_impl.dart` as the local JSON-backed repository implementation;
- `lib/features/assets/application/tx_history_controller.dart` as the Riverpod state owner for history loading, insertion, and receipt refresh;
- `lib/features/assets/presentation/history_screen.dart` as the current first-party history route;
- `lib/features/blockchain/application/send_transaction_controller.dart` as the native-send writer of local history entries;
- `lib/features/blockchain/application/send_token_controller.dart` as the ERC-20-send writer of local history entries;
- `lib/features/blockchain/data/scavium_rpc_service.dart` as the owner of receipt reads through `getReceipt(...)`;
- `lib/features/assets/domain/transaction_feed_item.dart`, `lib/features/assets/domain/transaction_feed_repository.dart`, and `lib/features/assets/data/transaction_feed_repository_impl.dart` as an existing but currently empty transaction-feed boundary.

### Execution Contract Locked for Remaining Phase 8.3 Subphases

The remaining Phase 8.3 implementation must preserve these boundaries:

- local outgoing history remains the current first-party activity source;
- incoming activity remains out of scope unless a durable explorer/indexer boundary is explicitly introduced later;
- receipt refresh must stay explicit and must not imply full chain indexing;
- transaction detail maturity must build on existing local records and available receipts;
- activity filtering/grouping must operate over locally available data first;
- message signing must be implemented as a separate domain/service boundary, not as a transaction submission shortcut;
- signing UX must require explicit preview, confirmation, cancellation, and visible result handling;
- Phase 8.3 must not change backup payloads, release tooling, or the Phase 8.4 navigation shell scope.

### Expected Validations

- Confirm that Phase 8.3.0 is completed without modifying runtime code.
- Confirm that `.agent/*` files are not generated.
- Confirm that documentation changes are incremental and do not rewrite trunk documents.
- Confirm that the remaining Phase 8.3 subphases are still planned and not marked as implemented by this baseline-only step.

---

## 8.3.1 — Transaction History State Model Maturity

### Objective

Mature the transaction history domain model so stored activity records can represent operational transaction states more explicitly and safely.

### Scope

This subphase should focus on transaction/activity domain correctness before UI expansion.

Expected work may include:

- extending transaction status semantics to include an explicit unknown or unresolved state if required;
- preserving pending, confirmed, and failed behavior;
- making receipt refresh behavior deterministic for absent receipts;
- protecting stored transaction history from malformed or older entries;
- keeping native and ERC-20 send records compatible with the existing local history repository;
- preparing the model for later transaction detail rendering.

### State

New subphase generated from the existing Phase 8.3 parent section.

### Existing Files Tentatively Intervened

- `lib/features/assets/domain/tx_status.dart` — extend or clarify transaction status values if the implementation requires an explicit unknown/unresolved state.
- `lib/features/assets/domain/tx_kind.dart` — preserve existing native and ERC-20 send kinds; extend only if later activity categories require it.
- `lib/features/assets/domain/tx_history_entry.dart` — harden serialization/deserialization and add fields only if needed for detail or receipt maturity.
- `lib/features/assets/domain/tx_history_repository.dart` — preserve the repository contract while supporting any required model evolution.
- `lib/features/assets/data/tx_history_repository_impl.dart` — preserve local persistence while safely reading older entries.
- `lib/features/assets/application/tx_history_controller.dart` — keep receipt refresh logic centralized and prevent UI-owned RPC status mutation.
- `lib/features/blockchain/data/scavium_rpc_service.dart` — preserve `getReceipt(...)` as the RPC boundary for receipt lookup.

### New Files Tentatively Created

- `test/tx_history_entry_test.dart` — validate history serialization compatibility and status handling if domain model changes are introduced.
- `test/tx_history_controller_test.dart` — validate pending/confirmed/failed/unknown refresh behavior if controller logic is expanded.

### Technical Justification

The current history model already exists and should be evolved rather than replaced. This preserves the Phase 8.2 asset/account-aware foundation while making transaction state handling safer for real wallet use.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Additional targeted tests should confirm that existing stored entries remain readable and that pending transactions without receipts are not incorrectly marked as failed.

---

## 8.3.2 — Transaction Detail and Receipt-Oriented Activity View

### Objective

Introduce a clearer transaction detail experience for locally tracked activity without adding external indexer or explorer ownership to the app.

### Scope

This subphase should improve activity readability and receipt-oriented display while preserving the current local-history limitation.

Expected work may include:

- transaction detail route or detail presentation;
- visible transaction hash, destination, amount, symbol, kind, status, and timestamp;
- receipt-oriented status explanation;
- safer explorer-link handling;
- responsive detail layout for mobile, web, and desktop sizes;
- clear copy/open affordances where appropriate;
- preservation of the current `HistoryScreen` refresh behavior.

### State

New subphase generated from the existing Phase 8.3 parent section.

### Existing Files Tentatively Intervened

- `lib/features/assets/presentation/history_screen.dart` — change list item navigation from direct-only explorer opening to an explicit detail experience if required.
- `lib/app/router/route_names.dart` — add a route name for transaction detail only if a dedicated screen is introduced.
- `lib/app/router/app_router.dart` — register the transaction detail route while preserving GoRouter ownership.
- `lib/features/assets/domain/tx_history_entry.dart` — expose any detail-safe derived values only if needed by the UI.
- `lib/core/config/app_config.dart` — preserve explorer path usage and avoid hardcoding environment-specific URLs in UI code.
- `lib/shared/widgets/feedback/state_message.dart` — reuse existing empty/error feedback patterns where possible.
- `lib/shared/widgets/scavium_card.dart` — reuse existing visual primitives instead of introducing unrelated UI containers.

### New Files Tentatively Created

- `lib/features/assets/presentation/transaction_detail_screen.dart` — dedicated transaction detail surface, if the implementation chooses a route-based detail view.
- `test/transaction_detail_screen_test.dart` — optional widget test for rendered transaction detail behavior if practical.

### Technical Justification

Opening an explorer directly from the list is useful but not sufficient for activity maturity. A wallet should show a first-party, explicit interpretation of locally known transaction data before sending users to an external explorer.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm that history remains available, explorer links still work, and no route guard regression is introduced.

---

## 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity

### Objective

Improve the activity surface so users can understand local wallet activity more clearly without introducing unsupported incoming-transaction discovery.

### Scope

This subphase should enhance the current history list around local activity presentation.

Expected work may include:

- filtering by status;
- filtering or grouping by transaction kind;
- date grouping foundations;
- safer empty-state copy;
- clearer distinction between local outgoing history and full blockchain activity;
- refresh-state feedback;
- preservation of locally tracked outgoing transaction scope.

### State

New subphase generated from the existing Phase 8.3 parent section.

### Existing Files Tentatively Intervened

- `lib/features/assets/presentation/history_screen.dart` — add filtering/grouping controls and improved state messaging.
- `lib/features/assets/application/tx_history_controller.dart` — expose clean state refresh behavior without making the UI own repository mutation.
- `lib/features/assets/domain/tx_history_entry.dart` — provide grouping-friendly fields only if needed.
- `lib/features/assets/domain/tx_status.dart` — ensure status labels remain deterministic if status semantics are expanded.
- `lib/features/assets/domain/tx_kind.dart` — ensure kind labels remain deterministic for native and ERC-20 sends.
- `lib/shared/widgets/feedback/state_message.dart` — reuse existing feedback conventions for empty/error states.

### New Files Tentatively Created

- `lib/features/assets/domain/tx_history_filter.dart` — optional value object for filter state if inline UI state becomes too large.
- `test/tx_history_filter_test.dart` — optional unit test if a dedicated filter value object is introduced.

### Technical Justification

The project already has local outgoing transaction history. This subphase makes that surface more understandable while explicitly avoiding unsupported full activity indexing, incoming transaction discovery, or multi-chain aggregation.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm that filters do not hide data permanently, refresh still updates pending entries, and empty/error states remain truthful about current product scope.

---

## 8.3.4 — Message Signing Domain and Service Boundary

### Objective

Introduce the domain and service boundary required for explicit message signing without treating signing as a transaction or background operation.

### Scope

This subphase should add the non-UI signing foundation for:

- `signPersonalMessage(...)`;
- `signChallengeMessage(...)`;
- deterministic signing input normalization;
- active-account-aware signer selection;
- cancellation-safe execution boundaries;
- error normalization consistent with the existing wallet and RPC style.

This subphase must not submit blockchain transactions and must not mutate wallet balances or transaction history.

### State

New subphase generated from the existing Phase 8.3 parent section.

### Existing Files Tentatively Intervened

- `lib/features/blockchain/data/scavium_rpc_service.dart` — add signing service methods only if signing belongs at the current RPC/web3 boundary.
- `lib/features/wallet/domain/wallet_repository.dart` — expose signing capability only if repository ownership of wallet credentials is required.
- `lib/features/wallet/data/wallet_repository_impl.dart` — use secure wallet material safely without exposing private keys to presentation code.
- `lib/features/wallet/application/wallet_controller.dart` — provide active-account context required by signing flows if needed.
- `lib/core/errors/app_exception.dart` — reuse or extend app-level error semantics for signing errors if required.
- `lib/core/utils/evm_format.dart` — reuse existing EVM formatting utilities only if signing output presentation needs it.

### New Files Tentatively Created

- `lib/features/signing/domain/signing_request.dart` — value object describing message, account/address, and signing mode.
- `lib/features/signing/domain/signing_result.dart` — value object carrying signature output and metadata required by the UI.
- `lib/features/signing/domain/signing_mode.dart` — enum distinguishing personal message signing from challenge signing.
- `lib/features/signing/application/signing_controller.dart` — Riverpod controller for explicit signing execution.
- `test/signing_request_test.dart` — validate deterministic request construction and input safety.
- `test/signing_controller_test.dart` — validate success, cancellation-safe behavior, and error paths if controller dependencies can be tested cleanly.

### Technical Justification

Message signing is sensitive wallet behavior. It must be modeled explicitly, tied to the intended active account, and kept separate from transaction submission and activity history. A dedicated signing boundary prevents UI widgets from directly handling private-key-sensitive operations.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm that signing does not create transaction history entries, does not refresh balances, does not submit RPC transactions, and uses the intended active account.

---

## 8.3.5 — Message Signing UX, Confirmation, and Result Display

### Objective

Add the user-facing signing flow with explicit preview, confirmation, cancellation, result display, and error handling.

### Scope

This subphase should introduce signing UX on top of the signing domain/service foundation.

Expected work may include:

- signing entry surface;
- message/challenge input;
- active account/address visibility;
- confirmation dialog or confirmation screen;
- clear distinction between signing and sending;
- cancellation path that does not mutate wallet state;
- signature result display;
- copy-to-clipboard behavior for signature output;
- safe error presentation.

### State

New subphase generated from the existing Phase 8.3 parent section.

### Existing Files Tentatively Intervened

- `lib/app/router/route_names.dart` — add a signing route only if a dedicated signing screen is introduced.
- `lib/app/router/app_router.dart` — register the signing route while preserving existing guarded routing behavior.
- `lib/features/home/presentation/home_screen.dart` — add a controlled entry point only if Phase 8.4 navigation shell is not yet available.
- `lib/features/settings/presentation/settings_screen.dart` — optional entry point only if signing is treated as a tool/settings-adjacent action.
- `lib/features/wallet/presentation/account_switcher.dart` — avoid changing account switching unless active-account display is required by the signing flow.
- `lib/shared/widgets/feedback/confirm_dialog.dart` — reuse the existing confirmation pattern where appropriate.
- `lib/shared/widgets/feedback/app_snackbar.dart` — reuse existing feedback style for success/error copy.
- `lib/shared/widgets/scavium_text_field.dart` — reuse existing input styling for signing message/challenge input.

### New Files Tentatively Created

- `lib/features/signing/presentation/signing_screen.dart` — signing entry and result surface.
- `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart` — dedicated confirmation dialog if the shared confirm dialog is insufficient for message preview.
- `lib/features/signing/presentation/widgets/signing_result_card.dart` — reusable result display if the screen would otherwise become too large.
- `test/signing_screen_test.dart` — optional widget test for confirmation, cancellation, and result display behavior.

### Technical Justification

Signing UX must be explicit because users can confuse signed messages with submitted transactions. The UI must show the message, the account/address, the action type, and the output clearly before and after signing.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm that cancellation leaves wallet state unchanged, success displays a signature without submitting a transaction, and route access remains compatible with existing wallet guards.

---

## 8.3.close — Transaction & Activity Maturity Closure

### Objective

Close Phase 8.3 by confirming that transaction/activity maturity and message-signing behavior are implemented, validated against the real codebase, and coherently represented in trunk documentation.

### Scope

This closure records the actual implementation delivered by Phase 8.3.1 through Phase 8.3.5 and updates trunk documentation without changing runtime code.

The closure confirms:

- local outgoing transaction history remains the first-party activity source;
- transaction-history entries are deserialized defensively and remain compatible with older stored records;
- pending transactions without receipts remain pending instead of being marked failed;
- transaction detail is available as an app route and presents receipt-oriented status explanation;
- activity history supports local status/type filtering and local-day grouping;
- message signing is implemented as a separate signing feature boundary;
- signing requires user preview and confirmation before producing a signature;
- signing does not submit transactions, refresh balances, or write transaction-history entries.

### State

Implemented and closed as a documentation-only closure over the completed Phase 8.3 runtime subphases.

No runtime code was modified in this closure step.

### Phase 8.3 Runtime Implementation Validated

The final Phase 8.3 runtime state includes the following implemented areas.

#### 8.3.1 — Transaction History State Model Maturity

Implemented through the existing assets feature boundary.

Validated implementation points:

- `TxHistoryEntry.fromJson(...)` now reads stored entries defensively;
- malformed or missing status values fall back safely to `TxStatus.pending`;
- malformed or missing kind values fall back safely to `TxKind.nativeSend`;
- missing IDs fall back to the transaction hash where available;
- malformed timestamps fall back to a deterministic epoch value;
- receipt refresh remains centralized in `TxHistoryController`;
- pending entries without receipts remain pending;
- receipt status updates only occur when a receipt is available.

#### 8.3.2 — Transaction Detail and Receipt-Oriented Activity View

Implemented through a dedicated transaction-detail route and screen.

Validated implementation points:

- `RouteNames.transactionDetail` defines the transaction-detail route;
- `app_router.dart` registers `TransactionDetailScreen` using the selected `TxHistoryEntry`;
- `HistoryScreen` opens the detail route instead of treating the history row as a direct-only external explorer action;
- `TransactionDetailScreen` presents kind, status, destination, amount, symbol, token address when present, transaction hash, and timestamp;
- the detail screen explains pending, confirmed, and failed receipt-oriented states;
- explorer opening remains explicit through an external-action button.

#### 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity

Implemented as local filtering and grouping over existing first-party outgoing history.

Validated implementation points:

- `TxHistoryFilter` supports status filters for all, pending, confirmed, and failed;
- `TxHistoryFilter` supports kind filters for all, native sends, and ERC-20 sends;
- `TxHistoryFilter.groupByLocalDay(...)` groups filtered entries by local calendar day;
- `HistoryScreen` exposes status/type filters using `ChoiceChip` controls;
- history entries are grouped by day and sorted newest-first within each group;
- empty and filtered-empty states are distinct;
- error copy clarifies that existing local entries are not modified by a load/receipt failure.

#### 8.3.4 — Message Signing Domain and Service Boundary

Implemented as a dedicated signing feature separated from transaction submission.

Validated implementation points:

- `lib/features/signing/domain/signing_mode.dart` defines supported signing modes;
- `SigningRequest` validates message content and account address format;
- `SigningResult` captures mode, account, message, signature, and signing timestamp;
- `SigningService` defines the signing boundary;
- `RpcSigningService` adapts the boundary to `ScaviumRpcService`;
- `ScaviumRpcService.signPersonalMessage(...)` and `ScaviumRpcService.signChallengeMessage(...)` sign with the active wallet credentials;
- `SigningController` verifies that the signed account matches the requested active account;
- signing does not create transaction history entries and does not submit an EVM transaction.

#### 8.3.5 — Message Signing UX, Confirmation, and Result Display

Implemented as an explicit user-facing signing flow.

Validated implementation points:

- `RouteNames.signing` defines the signing route;
- `app_router.dart` registers `SigningScreen` under the existing guarded routing model;
- `SigningScreen` displays the active account before signing;
- signing copy clearly states that signing is not a transaction and does not move funds;
- the user selects personal-message or challenge signing mode;
- message/challenge text is normalized and validated before signing;
- `SigningConfirmDialog` previews mode, account, and message before the signing call;
- cancellation returns without mutating wallet state;
- `SigningResultCard` displays the produced signature and signing metadata;
- signature copy-to-clipboard uses the existing feedback pattern.

### Existing Files Intervened by This Closure

- `docs/phase8_scavium_wallet.md` — closes Phase 8.3 from the real implemented state and records actual runtime validation.
- `docs/index.md` — moves Phase 8.3 from active/planned to completed.
- `README.md` — updates the project-level Phase 8 status and removes message signing from the not-yet-implemented list.
- `docs/features.md` — records implemented transaction/activity and signing capabilities.
- `docs/architecture.md` — records the durable Phase 8.3 activity/signing boundaries.
- `docs/flows.md` — records the implemented transaction detail, activity filtering, and signing flows.
- `docs/ux.md` — records the implemented activity and signing UX behavior.
- `docs/development.md` — records the Phase 8.3 agent-assisted execution boundary.

### Runtime Files Reviewed During Closure

The closure validation reviewed the Phase 8.3 runtime surface, including:

- `lib/features/assets/domain/tx_history_entry.dart`
- `lib/features/assets/domain/tx_history_filter.dart`
- `lib/features/assets/domain/tx_status.dart`
- `lib/features/assets/domain/tx_kind.dart`
- `lib/features/assets/application/tx_history_controller.dart`
- `lib/features/assets/data/tx_history_repository_impl.dart`
- `lib/features/assets/data/transaction_feed_repository_impl.dart`
- `lib/features/assets/presentation/history_screen.dart`
- `lib/features/assets/presentation/transaction_detail_screen.dart`
- `lib/features/signing/domain/signing_mode.dart`
- `lib/features/signing/domain/signing_request.dart`
- `lib/features/signing/domain/signing_result.dart`
- `lib/features/signing/application/signing_controller.dart`
- `lib/features/signing/presentation/signing_screen.dart`
- `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart`
- `lib/features/signing/presentation/widgets/signing_result_card.dart`
- `lib/features/blockchain/data/scavium_rpc_service.dart`
- `lib/app/router/route_names.dart`
- `lib/app/router/app_router.dart`
- `test/tx_history_entry_test.dart`
- `test/tx_history_controller_test.dart`
- `test/tx_history_filter_test.dart`
- `test/transaction_detail_screen_test.dart`
- `test/signing_request_test.dart`
- `test/signing_controller_test.dart`
- `test/signing_screen_test.dart`

### New Files Created by This Closure

No new documentation files were created.

### Technical Justification

Phase 8.3 closes a sensitive wallet capability area. The implementation intentionally matures locally tracked outgoing activity and signing behavior without turning the app into an explorer, external indexer, dApp connector, or automatic activity aggregator.

The closure documents the implemented boundaries from the real working tree so later phases can build on the completed transaction/activity/signing baseline without reinterpreting planned text as runtime truth.

### Preserved Boundaries

Phase 8.3 preserves these boundaries:

- local outgoing transaction history remains the first-party activity source;
- incoming transactions remain out of scope without a future explicit explorer/indexer boundary;
- `TransactionFeedRepositoryImpl` remains an empty future extension seam and is not represented as implemented external activity indexing;
- signing remains separate from sending;
- signing does not write local transaction history;
- signing does not update balances or receipt state;
- active-account ownership remains in the wallet feature;
- RPC ownership remains in `ScaviumRpcService`;
- the Phase 8.4 navigation shell is not introduced here;
- backup payloads, release tooling, and store publication flows are unchanged.

### Validation Result

Manual closure validation confirmed the implemented Phase 8.3 code paths and trunk documentation alignment.

The following local command validation could not be executed in this environment because neither `fvm` nor `flutter` is installed in the execution container:

```bash
fvm flutter analyze
fvm flutter test
```

The commands remain the expected local validation gate for the developer workstation before merge.

### Next Phase

The next planned Phase 8 area remains:

```text
8.4 — Navigation Shell and Product Surface Scaling
```

Phase 8.4 should build on the completed Phase 8.1 account model, Phase 8.2 asset/portfolio surface, and Phase 8.3 transaction/activity/signing maturity without retroactively moving their ownership boundaries.
