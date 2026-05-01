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

---

## 8.4.0 — Navigation Shell Baseline Inspection and Product Surface Contract

### Objective

Define the Phase 8.4 navigation-shell and product-surface contract before runtime implementation, using the real Phase 8.3-completed codebase as the baseline.

### Scope

This documentation-only subphase inspects the current UI, routing, and feature-surface state and locks the intended execution boundaries for the remaining Phase 8.4 implementation subphases.

The current baseline includes:

- `GoRouter` as the only application router;
- `RouteNames` as the central route-name registry;
- a guarded route model with onboarding, wallet-created, and lock-aware redirects;
- `HomeScreen` as the current dashboard-like entry surface;
- first-party routes for settings, send, receive, signing, assets, add token, history, transaction detail, asset detail, token send, and RPC diagnostics;
- `ScaviumScaffold` as a simple shared scaffold wrapper;
- feature state owned by Riverpod controllers inside each feature boundary;
- no drawer, sidebar, bottom navigation, or shell route yet.

### State

Implemented as a documentation-only baseline inspection and product-surface contract lock.

No runtime code was modified in this subphase. The current Phase 8.3-completed routing, shared scaffold, dashboard, asset, activity, settings, signing, and account-selection surfaces were inspected and confirmed as the baseline for the remaining Phase 8.4 implementation subphases.

### Existing Files Intervened

- `docs/phase8_scavium_wallet.md` — records the completed Phase 8.4.0 baseline inspection, confirms the Phase 8.4 navigation-shell/product-surface execution contract, and preserves the remaining subphase map as planned.
- `docs/index.md` — records Phase 8.4.0 as completed while keeping Phase 8.4.1 through 8.4.close planned.

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

### Runtime Files Reviewed for Baseline

- `lib/app/router/app_router.dart` — confirms the current flat route registration and lock-aware redirect behavior that the shell must preserve.
- `lib/app/router/route_names.dart` — confirms the current route registry that should remain stable where safe.
- `lib/shared/widgets/scavium_scaffold.dart` — confirms the current shared scaffold is intentionally minimal and not yet a navigation shell.
- `lib/features/home/presentation/home_screen.dart` — confirms the current product entry surface combines dashboard content, quick actions, account switcher, network/RPC cards, and recent activity.
- `lib/features/assets/presentation/assets_screen.dart` — confirms the assets surface already owns its own refresh and responsive width handling.
- `lib/features/assets/presentation/history_screen.dart` — confirms the activity surface already owns local outgoing-history filtering and grouping.
- `lib/features/settings/presentation/settings_screen.dart` — confirms settings currently groups diagnostics, backup export, signing, reset, and about actions.
- `lib/features/signing/presentation/signing_screen.dart` — confirms signing exists as a dedicated route and must remain explicit, not hidden in shell chrome.
- `lib/features/wallet/presentation/account_switcher.dart` — confirms account selection currently lives inside the home surface.

### New Files Created

No new files were created in this documentation-only subphase.

### Technical Justification

Phase 8.4 changes a cross-cutting UX layer. Before introducing a shell, the project needs a documented baseline so navigation changes do not accidentally move business state into UI chrome, bypass lock-aware routing, duplicate feature ownership, or degrade the surfaces completed in Phase 8.1, Phase 8.2, and Phase 8.3.

### Baseline Inspection Result

Phase 8.4.0 confirms that the Phase 8.3-completed codebase already contains the route and feature surfaces needed to introduce a controlled navigation shell in later subphases. The inspected runtime baseline includes:

- `lib/app/router/app_router.dart` as the only route registration and redirect boundary;
- `lib/app/router/route_names.dart` as the stable route-name registry;
- `lib/shared/widgets/scavium_scaffold.dart` as the current shared page scaffold, without shell navigation ownership;
- `lib/features/home/presentation/home_screen.dart` as the current dashboard/product entry surface;
- `lib/features/wallet/presentation/account_switcher.dart` as the current account-selection UI embedded in Home;
- `lib/features/assets/presentation/assets_screen.dart` as the first-party assets surface;
- `lib/features/assets/presentation/history_screen.dart` as the first-party activity surface;
- `lib/features/assets/presentation/transaction_detail_screen.dart` as the first-party transaction detail surface introduced in Phase 8.3;
- `lib/features/blockchain/presentation/send_screen.dart` and `lib/features/blockchain/presentation/receive_screen.dart` as the native transfer surfaces;
- `lib/features/assets/presentation/send_token_screen.dart` as the ERC-20 transfer surface;
- `lib/features/signing/presentation/signing_screen.dart` as the explicit message-signing surface;
- `lib/features/settings/presentation/settings_screen.dart` as the current secondary-action and diagnostics entry surface;
- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart` as the explicit RPC diagnostics route.

### Execution Contract Locked for Remaining Phase 8.4 Subphases

The remaining Phase 8.4 implementation must preserve these boundaries:

- `GoRouter` remains the application router and route guards must stay centralized in the router layer;
- lock-aware redirects, onboarding redirects, and wallet-created redirects must not be bypassed by shell navigation;
- `RouteNames` should remain the stable registry for first-party destinations;
- shell navigation must remain UI composition, not business-state ownership;
- feature controllers must remain inside their existing Riverpod/application boundaries;
- Home may be segmented visually, but asset, activity, signing, and settings ownership must not be collapsed into Home-only logic;
- signing must remain an explicit user-selected destination with preview/confirmation behavior preserved;
- settings and diagnostics may be organized, but destructive or sensitive actions must remain explicit and confirmation-gated;
- Phase 8.4 must not change backup payload formats, wallet encryption, transaction submission semantics, or release tooling.

### Expected Validations

- Confirm that Phase 8.4.0 is completed without modifying runtime code.
- Confirm that `.agent/*` files are not generated or modified.
- Confirm that documentation changes are incremental and do not rewrite trunk documents.
- Confirm that the remaining Phase 8.4 subphases are still planned and not marked as implemented by this baseline-only step.
---

## 8.4.1 — Route Inventory and Shell Navigation Contract

### Objective

Define the application navigation inventory and shell contract before adding visible navigation chrome.

### Scope

This subphase should classify existing routes into stable product destinations and secondary/detail/action routes.

Expected work may include:

- identifying primary destinations such as Home, Assets, Activity, Settings, and optional Wallet/Accounts;
- keeping send, receive, add token, token send, signing, asset detail, transaction detail, RPC diagnostics, backup, and onboarding routes as explicit secondary or action routes where appropriate;
- defining how selected navigation state maps to the current route;
- preserving direct route reachability for existing screens;
- preserving lock-aware routing and onboarding redirects;
- avoiding route renames unless there is a documented compatibility reason.

### State

Implemented.

Phase 8.4.1 introduced a formal route classification boundary through `AppRouteClassifier`, preserving existing route names while defining primary, public, lock, action, detail, and secondary route categories for shell-safe navigation.

### Existing Files Intervened

- `lib/app/router/route_names.dart` — preserve and, only if necessary, add route names for new primary product surfaces such as a wallet/accounts route.
- `lib/app/router/app_router.dart` — prepare shell-compatible route grouping while preserving onboarding, lock, splash, wallet-entry, and detail/action routes.
- `lib/features/home/presentation/home_screen.dart` — align quick actions and destination entry points with the formal route inventory without moving controller ownership.
- `test/widget_test.dart` — adjust or add smoke expectations if the app shell changes the first rendered authenticated surface.

### New Files Created

- `lib/app/router/app_route_category.dart` — route metadata helper used to classify primary, public, lock, action, detail, and secondary routes without duplicating route-category decisions in widgets.
- `test/app_route_category_test.dart` — focused coverage for primary and shell-eligibility classification behavior.

### Technical Justification

A product shell should not be built by scattering route decisions across multiple screens. A route inventory allows Phase 8.4 to introduce navigation in a controlled way while preserving current route behavior, detail routes, and lock-aware guards.

### Expected Validations

- Existing named paths remain reachable.
- Lock routing still redirects protected routes to the lock screen when required.
- Onboarding and wallet-entry routes remain outside the authenticated shell.
- Detail/action routes continue to work when opened from their owning feature screens.

---

## 8.4.2 — Responsive App Shell Foundation

### Objective

Introduce a reusable responsive product shell that can host primary wallet destinations without becoming a state-management owner.

### Scope

This subphase should add the shared shell foundation used by authenticated primary destinations.

Expected work may include:

- adding a shared shell widget around authenticated primary destinations;
- using a desktop/web sidebar or rail for wider layouts;
- using a mobile drawer or bottom navigation pattern for compact layouts;
- keeping `GoRouter` as the routing owner;
- keeping Riverpod feature controllers inside feature modules;
- preserving existing `ScaviumScaffold` behavior for secondary/action screens where a full shell is not appropriate;
- ensuring shell UI reflects the current route without introducing route loops.

### State

Implemented.

Phase 8.4.2 introduced the reusable authenticated shell through `ShellRoute`, `AppShell`, destination metadata, and responsive navigation. Primary authenticated destinations now share shell navigation while public, lock, action, detail, onboarding, wallet-entry, and diagnostics routes remain outside shell ownership unless explicitly navigated from their owning surfaces.

### Existing Files Intervened

- `lib/shared/widgets/scavium_scaffold.dart` — either remain as a simple screen scaffold or receive compatible optional hooks if the shell builds on it without breaking existing screens.
- `lib/app/router/app_router.dart` — wrap authenticated primary routes with the shell while keeping public, lock, detail, and action routes safe.
- `lib/app/router/route_names.dart` — preserve current route constants and add only necessary shell destinations.
- `lib/features/home/presentation/home_screen.dart` — adapt app bar and quick-action behavior so it does not duplicate shell navigation.
- `lib/features/assets/presentation/assets_screen.dart` — verify assets can run inside the shell without nested navigation conflicts.
- `lib/features/assets/presentation/history_screen.dart` — verify activity can run inside the shell without losing filters, grouping, or refresh behavior.
- `lib/features/settings/presentation/settings_screen.dart` — verify settings can run inside the shell without losing diagnostics, backup, signing, reset, and about actions.

### New Files Created

- `lib/app/shell/app_shell.dart` — reusable authenticated product shell for primary destinations.
- `lib/app/shell/app_shell_destination.dart` — destination metadata for labels, icons, routes, and selection behavior.
- `lib/app/shell/responsive_navigation.dart` — extracted responsive navigation widget using a rail on wide layouts and bottom navigation on compact layouts.
- `test/app_shell_test.dart` — widget and selection coverage for the shell destinations.

### Technical Justification

The wallet has grown beyond a one-page surface. A shell foundation prevents feature expansion from overloading `HomeScreen` while keeping product navigation consistent across mobile, web, and desktop layouts.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Primary destinations render inside the shell.
- Public/onboarding/lock routes remain outside the authenticated shell.
- No route loop is introduced by shell destination selection.
- Feature controllers are not moved into shell code.

---

## 8.4.3 — Dashboard and Product Surface Segmentation

### Objective

Reduce Home-screen overload by turning Home into a clearer dashboard and moving destination-specific content to the appropriate product surfaces.

### Scope

This subphase should keep Home useful as a summary surface while relying on the new shell for navigation.

Expected work may include:

- keeping balance, active account summary, network summary, and recent activity preview on Home;
- reducing duplicated navigation actions now provided by the shell;
- preserving explicit send, receive, signing, and explorer actions as intentional quick actions;
- keeping detailed asset management on the Assets surface;
- keeping full transaction/activity filtering on the Activity/History surface;
- ensuring recent activity rows still open transaction detail when appropriate;
- preserving account-switcher visibility until a dedicated Wallet/Accounts surface is introduced or formally deferred.

### State

Implemented.

Phase 8.4.3 segmented the Home surface into a clearer dashboard by extracting reusable dashboard cards while keeping feature state in existing Riverpod controllers. Home remains a summary and quick-action surface, while full assets, activity/history, signing, send, receive, settings, and diagnostics workflows remain owned by their dedicated routes.

### Existing Files Intervened

- `lib/features/home/presentation/home_screen.dart` — simplify dashboard composition, avoid duplicated shell navigation, and preserve summary cards and quick actions.
- `lib/features/wallet/presentation/account_switcher.dart` — preserve account-selection behavior and adjust placement only if Home/dashboard structure requires it.
- `lib/features/assets/presentation/assets_screen.dart` — ensure asset detail and token-management entry points remain on the assets surface.
- `lib/features/assets/presentation/history_screen.dart` — ensure full activity behavior remains on the activity surface, not duplicated on Home.
- `lib/features/assets/presentation/transaction_detail_screen.dart` — preserve transaction-detail navigation from recent activity and full history lists.
- `test/portfolio_summary_test.dart` — keep summary expectations valid if dashboard wording changes around visible asset totals.
- `test/transaction_detail_screen_test.dart` — keep transaction-detail reachability valid from activity-related surfaces.

### New Files Created

- `lib/features/home/presentation/widgets/dashboard_balance_card.dart` — extracted balance summary card used by the dashboard surface.
- `lib/features/home/presentation/widgets/dashboard_recent_activity_card.dart` — extracted recent-activity preview card that keeps detailed activity ownership in the History surface.

`test/home_screen_test.dart` was not required because focused shell, route, transaction-detail, and existing feature tests cover the durable behavior changed in this subphase.

### Technical Justification

Phase 8.1, 8.2, and 8.3 added account, asset, activity, and signing capabilities. Home should no longer act as the only product map. It should summarize the wallet state while the shell and feature surfaces carry navigation and detailed workflows.

### Expected Validations

- Home remains usable on compact layouts.
- Home remains useful on wide layouts.
- Recent activity preview remains read-only and opens detail intentionally.
- Asset, activity, signing, send, receive, and settings routes remain reachable.
- No feature state is duplicated in Home-specific controllers.

---

## 8.4.4 — Wallet and Account Surface Placement

### Objective

Decide and implement the correct product placement for account-oriented wallet controls within the new navigation model.

### Scope

This subphase should clarify whether account management remains on Home for now or becomes a dedicated Wallet/Accounts surface.

Expected work may include:

- reviewing current account switcher, account creation/import, and backup/restore entry points;
- introducing a dedicated Wallet or Accounts surface only if it improves product clarity;
- keeping active-account ownership in the wallet feature;
- preserving Phase 8.1 backup/restore compatibility;
- preserving imported/derived account behavior;
- avoiding account deletion or label-editing expansion unless already documented as part of a later phase.

### State

Implemented.

Phase 8.4.4 introduced a dedicated `AccountsScreen` for account-oriented wallet controls while preserving account state ownership in `WalletController` and preserving backup/restore semantics. Home keeps an account summary/switcher for dashboard context, and the explicit Accounts route provides product placement for account selection without adding account deletion, label editing, or backup-format changes.

### Existing Files Intervened

- `lib/features/wallet/presentation/account_switcher.dart` — preserve and possibly reposition account switching inside the chosen product surface.
- `lib/features/wallet/presentation/add_account_sheet.dart` — preserve account creation/import entry behavior if surfaced from a dedicated Wallet/Accounts screen.
- `lib/features/wallet/application/wallet_controller.dart` — should remain the account-state owner; intervention should be avoided unless UI placement exposes a missing read model.
- `lib/features/home/presentation/home_screen.dart` — remove or keep account switcher depending on the documented placement decision.
- `lib/app/router/route_names.dart` — add a wallet/accounts route only if a dedicated screen is introduced.
- `lib/app/router/app_router.dart` — register the wallet/accounts route only if introduced.
- `test/asset_account_context_test.dart` — preserve account-aware asset-context behavior.
- `test/wallet_backup_payload_test.dart` — preserve backup payload compatibility if account controls are repositioned.

### New Files Created

- `lib/features/wallet/presentation/accounts_screen.dart` — dedicated account/wallet surface for active-account selection and account-placement clarity.
- `test/accounts_screen_test.dart` — widget coverage for the dedicated account surface.

### Technical Justification

The account model is now broader than the original single-wallet surface. Phase 8.4 must place account controls deliberately so the navigation shell clarifies product structure without changing wallet-domain ownership or backup compatibility.

### Expected Validations

- Active account selection continues to work.
- Account-aware assets still resolve against the active account.
- Backup/restore compatibility remains unchanged.
- No wallet reset or backup flow is accidentally moved into shell chrome.
- Route reachability remains stable if a new Wallet/Accounts destination is added.

---

## 8.4.5 — Settings, Diagnostics, and Secondary Action Organization

### Objective

Organize settings, diagnostics, signing access, backup export, reset, and about information so secondary actions remain discoverable but do not overload primary navigation.

### Scope

This subphase should refine the relationship between primary shell destinations and secondary actions.

Expected work may include:

- preserving Settings as a primary or secondary destination according to the shell contract;
- keeping RPC diagnostics reachable from Settings and/or a diagnostics entry point;
- keeping signing access explicit and safely described;
- keeping backup export and reset under Settings or wallet-management placement;
- ensuring destructive actions remain confirmation-gated;
- preserving visible app/about information;
- avoiding hidden signing shortcuts or background signing behavior.

### State

Implemented.

Phase 8.4.5 reorganized Settings into explicit sections for security/recovery, signing, diagnostics, danger-zone actions, and about information. RPC diagnostics, signing, backup export, and wallet reset remain explicit flows; reset remains confirmation-gated and signing remains preview/confirmation driven.

### Existing Files Intervened

- `lib/features/settings/presentation/settings_screen.dart` — reorganize settings sections without changing the underlying feature ownership.
- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart` — preserve diagnostics as an explicit route and ensure shell placement does not make it unreachable.
- `lib/features/signing/presentation/signing_screen.dart` — preserve explicit signing flow and confirmation behavior.
- `lib/features/settings/presentation/export_backup_screen.dart` — preserve backup export path if settings grouping changes.
- `lib/shared/widgets/feedback/confirm_dialog.dart` — should remain the destructive-action confirmation pattern; intervention should be avoided unless UI consistency requires it.
- `test/signing_screen_test.dart` — preserve signing UX expectations.
- `test/signing_controller_test.dart` — preserve signing boundary behavior independent of navigation placement.

### New Files Created

- `lib/features/settings/presentation/widgets/settings_section_card.dart` — reusable Settings section card used to group secondary actions clearly.
- `test/settings_screen_test.dart` — widget coverage for the organized settings sections and durable action labels.

### Technical Justification

Settings currently contains several unrelated but valid secondary actions. Phase 8.4 should make those actions easier to understand without moving sensitive behavior into implicit shell actions or weakening confirmation/preview gates.

### Expected Validations

- RPC diagnostics remains reachable.
- Signing remains explicit and still requires preview/confirmation.
- Backup export remains reachable.
- Reset wallet remains confirmation-gated.
- Settings remains usable on mobile and wide layouts.

---

## 8.4.close — UX & Product Surface Maturity Closure

### Objective

Close Phase 8.4 by confirming that navigation-shell and product-surface maturity are implemented, validated against the real codebase, and coherently represented in trunk documentation.

### Scope

This closure should record the actual implementation delivered by Phase 8.4.1 through Phase 8.4.5 and update trunk documentation without changing runtime code.

The closure should confirm:

- the final shell/navigation structure;
- the final list of primary destinations;
- the final treatment of secondary/action/detail routes;
- preserved lock-aware routing;
- preserved onboarding and wallet-entry routing;
- preserved feature-state ownership;
- preserved account, asset, activity, signing, settings, diagnostics, backup, and reset behavior;
- mobile and wide-layout UX validation results.

### State

Implemented as documentation-only closure after validating the real Phase 8.4.1 through Phase 8.4.5 implementation.

No runtime code was modified in this closure. The closure records the implemented shell/navigation structure, destination placement, preserved ownership boundaries, and validation result from the real working tree.

### Existing Files Intervened

- `docs/phase8_scavium_wallet.md` — close Phase 8.4 from the real implemented runtime state.
- `docs/index.md` — move Phase 8.4 from planned to completed when implementation is validated.
- `README.md` — update the project-level Phase 8 status once Phase 8.4 is actually complete.
- `docs/features.md` — record implemented navigation/product-surface behavior only after runtime completion.
- `docs/architecture.md` — record the final shell architecture and ownership boundaries.
- `docs/flows.md` — record the final primary navigation and secondary action flows.
- `docs/ux.md` — record the final mobile, web, and desktop navigation behavior.
- `docs/development.md` — record the Phase 8.4 execution boundary and validation results.

### New Files Created

No new documentation files were created for closure.

### Technical Justification

Phase 8.4 is a cross-cutting product-surface phase. Its closure must distinguish planned navigation text from implemented runtime truth so future phases do not inherit stale route or shell assumptions.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Manual mobile layout validation.
- Manual web/desktop-width layout validation.
- Route reachability validation for primary, secondary, detail, action, onboarding, lock, and wallet-entry routes.
- Confirmation that `.agent/*` files are not part of the closure deliverable unless a later operational prompt explicitly creates them.

### Phase 8.4 Closure Implementation Result

Phase 8.4 is complete as a navigation-shell and product-surface maturity phase. The implemented runtime state is:

- `lib/app/router/app_route_category.dart` defines route categories and shell eligibility without moving redirect ownership out of `GoRouter`;
- `lib/app/router/app_router.dart` keeps public, onboarding, wallet-entry, lock, action, detail, and diagnostics routes explicit while wrapping the primary authenticated destinations in `ShellRoute`;
- `lib/app/shell/app_shell.dart`, `lib/app/shell/app_shell_destination.dart`, and `lib/app/shell/responsive_navigation.dart` provide shell composition, destination metadata, and responsive navigation chrome;
- primary shell destinations are Home, Assets, Activity, and Settings;
- compact layouts use bottom navigation; wide layouts use a navigation rail;
- Home is now a dashboard-style summary surface with balance, account context, network/RPC summaries, explicit quick actions, and recent activity preview;
- full asset management remains in Assets;
- full local outgoing activity filtering and grouping remains in Activity/History;
- account selection has a dedicated Accounts route while active-account ownership remains in the wallet feature;
- Settings is organized into explicit Security & recovery, Signing, Diagnostics, Danger zone, and About sections;
- signing, RPC diagnostics, backup export, reset, send, receive, add-token, token-send, transaction-detail, and asset-detail flows remain explicit secondary/action/detail routes rather than shell-owned business logic.

### Phase 8.4 Closure Validation

The real working tree was inspected for the Phase 8.4 closure. The implementation is coherent with the documented contract because:

- `GoRouter` remains the routing owner;
- lock-aware redirects remain centralized in `app_router.dart`;
- onboarding and wallet-entry routes remain outside the authenticated shell;
- shell widgets own only navigation presentation;
- Riverpod feature controllers remain inside existing feature/application boundaries;
- backup payloads, wallet encryption, transaction submission, release automation, and store tooling were not changed by Phase 8.4;
- account, asset, activity, signing, diagnostics, and settings flows remain reachable through explicit screens;
- destructive wallet reset remains confirmation-gated;
- signing remains explicit and confirmation-oriented;
- focused tests exist for route classification, shell destinations, account surface, settings organization, and previously implemented activity/signing behavior.

Automated validation commands could not be executed in this environment because `fvm`, `flutter`, and `dart` are not installed in the execution container. The expected project-local validation remains:

```bash
fvm flutter analyze
fvm flutter test
```

### Phase 8.4 Closure Boundaries

Phase 8.4 deliberately does not introduce:

- external transaction indexing;
- automatic token discovery;
- dApp connectivity;
- account deletion or account label editing;
- backup payload format changes;
- wallet encryption changes;
- release pipeline changes;
- store publication automation changes;
- shell-owned business state.

---

## 8.5.0 — Security, Reliability & Diagnostics Baseline Inspection and Execution Contract

### Objective

Define the Phase 8.5 security, reliability, and diagnostics maturity contract from the real Phase 8.4-completed codebase before any runtime implementation is attempted.

### Scope

This documentation-only subphase must inspect the current security, signing, backup, diagnostics, lock, routing, and error-handling baseline and lock the execution boundaries for the remaining Phase 8.5 subphases.

The baseline to inspect includes:

- app lifecycle lock behavior;
- screenshot protection behavior;
- lock policy defaults;
- signing request validation and confirmation flow;
- backup export and restore warnings;
- RPC diagnostics and RPC health output;
- app-level exception semantics;
- settings surface organization after Phase 8.4;
- tests already covering signing, routing, shell, settings, transaction activity, token safety, and backup payload behavior.

### State

New documentation-only subphase generated from the existing Phase 8.5 parent section.

No runtime code should be modified in this subphase.

### Existing Files Tentatively Intervened

- `docs/phase8_scavium_wallet.md` — record the Phase 8.5 baseline inspection, execution boundaries, and generated subphase map.
- `docs/index.md` — record Phase 8.5 as the next documented Phase 8 area without marking it implemented.

### New Files Tentatively Created

No new files should be created in this documentation-only baseline subphase.

### Technical Justification

Phase 8.5 touches sensitive wallet behavior. Before changing confirmations, diagnostics, error copy, lock behavior, or backup warnings, the project must distinguish implemented Phase 8.4 runtime truth from planned Phase 8.5 safety hardening so future operational prompts do not mix planning, `.agent` generation, and implementation.

### Expected Validations

- Confirm no `.agent/*` files are generated.
- Confirm no runtime Dart files are modified.
- Confirm Phase 8.5 subphases are documented in the phase document.
- Confirm the documented files are real paths from the current project tree.
- Confirm the plan preserves Phase 8.1 through Phase 8.4 behavior.

### Phase 8.5.0 Implementation Result

Phase 8.5.0 is complete as a documentation-only baseline inspection and execution contract lock. The real working tree was inspected after Phase 8.4 closure, and Phase 8.5 remains correctly scoped as a hardening phase over the existing security, reliability, diagnostics, signing, backup, lock, routing, and invalid-state surfaces.

The inspected baseline confirms that:

- `lib/core/security/app_lifecycle_guard.dart` already centralizes lifecycle-triggered locking and home refresh coordination;
- `lib/core/security/lock_policy.dart` defines the current lock policy defaults without making Phase 8.5 responsible for changing the policy model during baseline lock;
- `lib/core/security/screenshot_guard.dart` provides Android screenshot-protection hooks through the existing platform channel boundary;
- `lib/app/router/app_router.dart` keeps onboarding, wallet-entry, lock, shell, secondary action, detail, signing, and diagnostics routes explicit under `GoRouter`;
- `lib/features/settings/presentation/settings_screen.dart` exposes Security & recovery, Signing, Diagnostics, Danger zone, and About sections introduced by Phase 8.4;
- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart`, `lib/features/blockchain/application/rpc_health_controller.dart`, and `lib/features/blockchain/application/rpc_status_controller.dart` form the current diagnostics baseline;
- `lib/features/signing/application/signing_controller.dart`, `lib/features/signing/domain/signing_request.dart`, `lib/features/signing/presentation/signing_screen.dart`, `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart`, and `lib/features/signing/presentation/widgets/signing_result_card.dart` form the current signing safety baseline;
- `lib/features/settings/presentation/export_backup_screen.dart`, `lib/features/wallet/presentation/restore_backup_screen.dart`, `lib/features/wallet/application/wallet_backup_controller.dart`, and `lib/features/wallet/domain/wallet_backup_payload.dart` form the current backup and recovery warning baseline;
- `lib/core/errors/app_exception.dart` remains the current shared application exception boundary;
- focused tests already exist for shell/settings/signing/token/transaction-history/backup payload behavior and should be preserved as the starting validation surface for later Phase 8.5 implementation subphases.

No runtime Dart files were modified by this subphase. No `.agent/*` files were generated or modified by this subphase.

### Phase 8.5.0 Completion Validation

The baseline is coherent with the documented Phase 8.5 contract because the hardening targets already exist as real project files, the planned subphases map to existing architectural owners, and no new global security, diagnostics, or error architecture is required before beginning implementation.

Phase 8.5.0 validates the following execution boundaries for the remaining subphases:

- diagnostics hardening must stay inside the blockchain diagnostics/application surfaces unless a shared safe-message helper becomes justified by implementation;
- signing hardening must preserve the Phase 8.3 signing service/controller/domain/presentation separation;
- backup and recovery warning hardening must not change backup encryption, backup payload compatibility, or restore compatibility semantics;
- lock and lifecycle hardening must preserve centralized `GoRouter` redirects and existing lock-state ownership;
- invalid-state maturity must reuse existing feature ownership and avoid introducing a premature global error framework;
- settings remains an entry surface for sensitive flows, not the owner of wallet, signing, backup, diagnostics, or lock state.

Automated validation commands were not executed in this environment because the local container does not provide the project Flutter/FVM toolchain. The expected project-local validation remains:

```bash
fvm flutter analyze
fvm flutter test
```

### Phase 8.5.0 Closure Boundaries

Phase 8.5.0 deliberately does not introduce:

- runtime code changes;
- `.agent/*` generation;
- diagnostics telemetry;
- remote logging;
- signing service changes;
- backup payload or encryption changes;
- lock policy behavior changes;
- route ownership changes;
- release pipeline changes.

---


## 8.5.1 — Sensitive Diagnostics Output Hardening

### Objective

Harden diagnostics output so RPC and app health information remains useful for troubleshooting without exposing sensitive wallet material, private operational context, or misleading security state.

### Scope

This subphase should review and improve diagnostics around:

- RPC status display;
- RPC health strings;
- active RPC ping results;
- cooldown visibility;
- diagnostics copy shown to the user;
- error messages surfaced through diagnostics screens/controllers;
- avoidance of wallet addresses, private keys, mnemonic material, backup passwords, raw signed messages, signatures, or backup payload contents in diagnostics output.

This subphase must keep diagnostics non-invasive and must not add telemetry, remote logging, analytics, or background reporting.

### State

New subphase generated from the existing Phase 8.5 parent section.

### Existing Files Tentatively Intervened

- `lib/features/blockchain/presentation/rpc_diagnostics_screen.dart` — refine user-facing diagnostics copy and ensure the screen remains RPC-focused and non-invasive.
- `lib/features/blockchain/application/rpc_health_controller.dart` — normalize health output so failures remain actionable without leaking sensitive context.
- `lib/features/blockchain/application/rpc_status_controller.dart` — review active RPC selection, ping, and cooldown state output for safe user-facing diagnostics boundaries.
- `lib/features/blockchain/domain/scavium_rpc_status.dart` — adjust diagnostic state helpers only if safer formatting or cooldown representation requires it.
- `lib/core/errors/app_exception.dart` — reuse existing exception semantics or extend them only if diagnostics require normalized safe messages.
- `test/widget_test.dart` — update or add smoke coverage only if existing diagnostics behavior is covered there.

### New Files Tentatively Created

- `test/rpc_diagnostics_safety_test.dart` — optional focused test file if diagnostics safety assertions cannot be cleanly added to existing tests.

### Technical Justification

The current project already exposes an RPC diagnostics screen and health controller. Phase 8.5 should mature that surface by ensuring diagnostics help the user understand RPC state without becoming telemetry, leaking wallet-related data, or presenting raw internal exceptions as trusted security facts.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm diagnostics remain reachable from Settings, do not mutate wallet state, do not expose sensitive wallet material, and still report active RPC, ping, and cooldown information clearly.

---

## 8.5.2 — Signing Safety Copy and Confirmation Hardening

### Objective

Strengthen message-signing safety by improving validation, user-facing copy, confirmation clarity, cancellation behavior, and result handling without changing the Phase 8.3 signing architecture.

### Scope

This subphase should harden the existing signing flow around:

- personal message signing warnings;
- challenge signing warnings;
- active account visibility before signing;
- distinction between signing and sending a transaction;
- empty or invalid message handling;
- cancellation paths;
- signature result display and copy behavior;
- error messages when the signed account does not match the requested active account.

This subphase must not add dApp connectivity, WalletConnect, automatic challenge ingestion, transaction submission, or background signing.

### State

New subphase generated from the existing Phase 8.5 parent section.

### Existing Files Tentatively Intervened

- `lib/features/signing/domain/signing_request.dart` — tighten request normalization or validation only if the current input contract allows unsafe or unclear states.
- `lib/features/signing/application/signing_controller.dart` — preserve active-account verification while improving safe error normalization where needed.
- `lib/features/signing/presentation/signing_screen.dart` — improve warnings, state copy, cancellation behavior, and explicit signing/send distinction.
- `lib/features/signing/presentation/widgets/signing_confirm_dialog.dart` — make confirmation copy more explicit for message/challenge signing risk.
- `lib/features/signing/presentation/widgets/signing_result_card.dart` — ensure signature output is clear without implying a transaction was submitted.
- `lib/shared/widgets/feedback/app_snackbar.dart` — reuse existing feedback style if copy behavior or result messages need refinement.
- `test/signing_request_test.dart` — expand validation coverage if request normalization is changed.
- `test/signing_controller_test.dart` — expand mismatch/error/cancellation-safe coverage if controller behavior is changed.
- `test/signing_screen_test.dart` — expand UX coverage for warning, confirmation, cancellation, and result display behavior.

### New Files Tentatively Created

No new files are expected unless existing signing tests become too broad. If needed, create:

- `test/signing_safety_copy_test.dart` — optional widget/unit coverage for safety copy and confirmation behavior.

### Technical Justification

Phase 8.3 implemented explicit signing. Phase 8.5 should mature that sensitive surface without changing ownership: signing remains a dedicated feature, the wallet feature remains the owner of account identity, and signing must remain separate from transactions and activity history.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm signing still requires explicit preview/confirmation, cancellation does not mutate state, signing does not create transaction history entries, and the UI clearly distinguishes signatures from submitted transactions.

---

## 8.5.3 — Backup and Recovery Warning Reliability

### Objective

Improve backup and recovery safety messaging so users receive consistent, explicit warnings before exporting, restoring, or relying on encrypted backup material.

### Scope

This subphase should review and mature:

- export backup warnings;
- restore backup warnings;
- password requirement copy;
- unrecoverable-password messaging;
- backup file naming and extension expectations;
- v1/v2 backup compatibility explanation;
- multi-account backup/restore clarity after Phase 8.1;
- error copy for invalid, partial, or unsupported backup payloads.

This subphase must preserve existing backup encryption semantics and must not change the backup payload format unless a defect is found and explicitly documented.

### State

New subphase generated from the existing Phase 8.5 parent section.

### Existing Files Tentatively Intervened

- `lib/features/settings/presentation/export_backup_screen.dart` — improve export warnings, password guidance, cancellation copy, and success/error messages.
- `lib/features/wallet/presentation/restore_backup_screen.dart` — improve restore warnings and invalid backup/error states.
- `lib/features/wallet/application/wallet_backup_controller.dart` — normalize restore/export errors only if current messages leak implementation detail or confuse user action.
- `lib/features/wallet/domain/wallet_backup_payload.dart` — adjust validation messaging or compatibility helpers only if needed without changing payload semantics.
- `lib/core/services/backup_crypto_service.dart` — review error boundaries only if cryptographic failures are surfaced unsafely.
- `test/wallet_backup_payload_test.dart` — expand coverage for invalid, partial, v1, and v2 payload behavior if touched.

### New Files Tentatively Created

- `test/backup_recovery_warning_test.dart` — optional focused widget/domain coverage if backup warning behavior cannot be cleanly covered in existing tests.

### Technical Justification

Backup and recovery are high-risk wallet flows. The current export screen already warns about file/password responsibility. Phase 8.5 should make these warnings more consistent across export and restore without weakening the Phase 8.1 multi-account backup compatibility model or changing encryption behavior.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm backup export remains password-gated, restore remains explicit, v1/v2 compatibility remains intact, invalid payloads fail safely, and no secret material appears in UI error text or diagnostics.

---

## 8.5.4 — Lock, Lifecycle, and Sensitive Surface Reliability

### Objective

Improve reliability around app lock, lifecycle transitions, screenshot protection, and sensitive-surface behavior without changing the Phase 8.4 navigation shell or creating hidden state ownership.

### Scope

This subphase should review and harden:

- lifecycle lock on inactive/paused/detached states;
- refresh restart behavior on resume;
- lock policy defaults and future-readiness;
- screenshot protection behavior on Android;
- sensitive screens that should not accidentally bypass lock-aware routing;
- route classification for public, onboarding, wallet-entry, action, detail, diagnostics, and shell routes.

This subphase must preserve `GoRouter` as routing owner and must not move lock state into shell widgets.

### State

New subphase generated from the existing Phase 8.5 parent section.

### Existing Files Tentatively Intervened

- `lib/core/security/app_lifecycle_guard.dart` — review lifecycle lock/refresh ordering and make behavior safer if needed.
- `lib/core/security/lock_policy.dart` — clarify policy defaults only if the current contract creates ambiguous behavior.
- `lib/core/security/screenshot_guard.dart` — harden platform checks or failure handling if Android screenshot protection errors can affect runtime stability.
- `lib/app/router/app_route_category.dart` — update route categories only if sensitive route classification requires refinement.
- `lib/app/router/app_router.dart` — preserve centralized lock-aware redirects while improving guard behavior if needed.
- `lib/app/shell/app_shell.dart` — adjust only if shell presentation accidentally affects sensitive route handling.
- `test/app_route_category_test.dart` — expand route-category coverage if classifications change.
- `test/app_shell_test.dart` — confirm shell behavior remains presentation-only if shell-adjacent changes are required.

### New Files Tentatively Created

- `test/app_lifecycle_guard_test.dart` — optional focused test if lifecycle behavior can be isolated safely.
- `test/sensitive_route_guard_test.dart` — optional focused test if route-sensitive guard coverage is not sufficient in existing tests.

### Technical Justification

Phase 8.4 introduced a shell-based product surface. Phase 8.5 should verify that sensitive flows remain protected by centralized routing and lifecycle policies rather than by shell presentation. The shell must remain navigation chrome, not a security state owner.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm lock-aware routing remains centralized, onboarding and wallet-entry flows remain outside the authenticated shell, sensitive routes remain explicit, lifecycle transitions fail safely, and screenshot protection failures do not destabilize non-Android platforms.

---

## 8.5.5 — Error Boundary and Invalid State Maturity

### Objective

Normalize user-facing error handling and invalid-state behavior across account-aware assets, activity, signing, backup, diagnostics, and settings surfaces.

### Scope

This subphase should mature invalid-state handling around:

- missing wallet profile;
- missing or mismatched active account;
- invalid account address;
- invalid token or transaction input;
- unsupported or partial backup payloads;
- RPC failure messages;
- signing mismatch errors;
- settings secondary-action failures;
- state messages for loading, empty, filtered-empty, error, and retry states.

This subphase must avoid broad architectural rewrites and should reuse existing `AppException`, `StateMessage`, `AppSnackbar`, and controller-level error patterns where possible.

### State

New subphase generated from the existing Phase 8.5 parent section.

### Existing Files Tentatively Intervened

- `lib/core/errors/app_exception.dart` — extend error semantics only if the current single-message exception is insufficient for safe user-facing normalization.
- `lib/core/utils/async_value_ui.dart` — reuse or refine async error presentation only if it improves consistency without hiding useful errors.
- `lib/shared/widgets/feedback/state_message.dart` — refine loading/empty/error states only if current copy is inconsistent across Phase 8 surfaces.
- `lib/shared/widgets/feedback/app_snackbar.dart` — reuse or refine feedback copy conventions for safe error messages.
- `lib/features/assets/application/assets_controller.dart` — normalize account-aware asset load failures if unsafe or confusing states are found.
- `lib/features/assets/application/tx_history_controller.dart` — preserve local history while improving receipt/error state copy if required.
- `lib/features/blockchain/application/send_transaction_controller.dart` — review invalid send state messages without changing transaction semantics.
- `lib/features/blockchain/application/send_token_controller.dart` — review token send invalid-state handling without changing token-transfer semantics.
- `lib/features/settings/presentation/settings_screen.dart` — keep secondary actions reachable and explicit while improving failure copy if needed.
- `test/tx_history_controller_test.dart` — expand error-state coverage if transaction history behavior is touched.
- `test/token_registry_safety_test.dart` — expand invalid-token safety coverage if token errors are touched.
- `test/settings_screen_test.dart` — expand secondary-action visibility/error-copy coverage if settings behavior is touched.

### New Files Tentatively Created

- `test/app_error_boundary_test.dart` — optional focused test file if normalized error semantics require dedicated coverage.
- `test/invalid_state_maturity_test.dart` — optional integration-style widget/domain coverage for invalid wallet/account states if existing tests are insufficient.

### Technical Justification

After Phase 8.1 through Phase 8.4, the wallet has more account-aware and route-aware surfaces. Phase 8.5 should make invalid states fail safely and consistently without hiding real failures, duplicating controller logic, or creating a new global error architecture prematurely.

### Expected Validations

```bash
fvm flutter analyze
fvm flutter test
```

Validation should confirm invalid states are reported safely, existing local data is not destroyed by read/refresh errors, sensitive values are not included in error text, and retry or cancellation flows remain predictable.

---

## 8.5.close — Security, Reliability & Diagnostics Maturity Closure

### Objective

Close Phase 8.5 by confirming that security, reliability, diagnostics, warning, lock/lifecycle, and invalid-state hardening are implemented, validated against the real codebase, and coherently represented in trunk documentation.

### Scope

This closure should record the actual implementation delivered by Phase 8.5.1 through Phase 8.5.5 and update trunk documentation without changing runtime code.

The closure should confirm:

- diagnostics remain non-invasive;
- diagnostics do not expose sensitive wallet material;
- signing warnings remain explicit before confirmation;
- backup and restore warnings remain consistent and truthful;
- lifecycle/lock behavior remains centralized and shell-independent;
- screenshot protection remains platform-safe;
- invalid states fail safely;
- user-facing error messages remain actionable without leaking secrets;
- Phase 8.1 through Phase 8.4 behavior remains compatible.

### State

Planned documentation-only closure to be executed only after the Phase 8.5 runtime subphases are implemented and validated.

### Existing Files Tentatively Intervened

- `docs/phase8_scavium_wallet.md` — close Phase 8.5 from the real implemented runtime state.
- `docs/index.md` — move Phase 8.5 from planned to completed when implementation is validated.
- `README.md` — update the project-level Phase 8 status only after Phase 8.5 is actually complete.
- `docs/features.md` — record implemented safety, diagnostics, signing-warning, backup-warning, and invalid-state behavior only after runtime completion.
- `docs/architecture.md` — record any final security/reliability boundaries if implementation changes ownership or error semantics.
- `docs/flows.md` — record final sensitive-flow behavior for diagnostics, signing, backup/restore, lock, and invalid states.
- `docs/ux.md` — record final warning, confirmation, diagnostics, and error-state UX behavior.
- `docs/development.md` — record Phase 8.5 execution boundary and validation results.

### New Files Created

No new documentation files are expected for closure.

### Technical Justification

Phase 8.5 is a cross-cutting hardening phase. Its closure must distinguish planned safety improvements from implemented runtime truth so future release/distribution work does not inherit unvalidated assumptions about diagnostics, lock behavior, backup safety, signing warnings, or error boundaries.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Manual diagnostics validation.
- Manual signing warning/confirmation validation.
- Manual backup export and restore warning validation.
- Manual lifecycle/lock validation on supported platforms where possible.
- Confirmation that `.agent/*` files are not part of the closure deliverable unless a later operational prompt explicitly creates them.

### Phase 8.5 Closure Boundaries

Phase 8.5 must deliberately avoid introducing:

- telemetry;
- analytics;
- remote diagnostics reporting;
- dApp connectivity;
- WalletConnect;
- automatic challenge ingestion;
- background signing;
- backup payload format changes unless explicitly required by a documented defect;
- private key, mnemonic, password, signature, or backup payload exposure in diagnostics;
- shell-owned security state;
- release pipeline changes reserved for Phase 8.6.

### Phase 8.5 Closure Implementation Result

Phase 8.5 is complete. The implemented runtime work was validated from the real post-8.5.1-through-8.5.5 working tree before this closure was recorded.

This closure is intentionally narrative because Phase 8.5 is a cross-cutting maturity phase. Its value is not a single new screen, route, or service. Its value is that the product surface created by Phase 8.1 through Phase 8.4 now behaves more safely when users interact with sensitive actions, partial state, failed RPCs, failed refreshes, backup warnings, signing confirmations, lock transitions, and diagnostics.

Implemented closure confirmations:

- **8.5.1 — Sensitive Diagnostics Output Hardening** hardened RPC diagnostics by replacing raw RPC status and health exception output with safe, actionable diagnostics text while keeping useful non-sensitive chain, block, endpoint, active RPC, and cooldown information.
- **8.5.2 — Signing Safety Copy and Confirmation Hardening** hardened signing request validation, confirmation warnings, cancellation behavior, and signature-result language. Signing remains explicit and local; it is not transaction submission, not a receipt workflow, not dApp connectivity, and not automatic challenge ingestion.
- **8.5.3 — Backup and Recovery Warning Reliability** hardened backup/export and restore warnings and normalized backup failure copy while preserving the existing encrypted backup payload semantics and v1/v2 compatibility boundary.
- **8.5.4 — Lock, Lifecycle, and Sensitive Surface Reliability** hardened lifecycle and screenshot-protection behavior by keeping lock ownership centralized, preventing refresh restart while locked, preserving route classification, and making Android screenshot protection plugin failures non-fatal.
- **8.5.5 — Error Boundary and Invalid State Maturity** introduced safe user-facing error helpers and applied them to invalid state, transaction send, token send, asset refresh, transaction-history refresh, and async error surfaces without creating a new global error architecture.

### Phase 8.5 Validation Summary

The code review confirmed that Phase 8.5 stayed within the existing architecture:

- `GoRouter` remains the routing owner.
- the authenticated shell remains navigation chrome only.
- wallet identity and active account ownership remain in the wallet feature.
- RPC execution remains in the blockchain data/application layer.
- signing remains explicit, previewed, confirmable, cancellable, and separated from transaction history.
- backup/restore remains password-gated and encrypted without a payload-format migration.
- diagnostics remain local and non-invasive.
- invalid-state copy is normalized without hiding the underlying feature ownership.
- no telemetry, analytics, remote diagnostics reporting, WalletConnect, dApp connectivity, background signing, or release-pipeline changes were introduced.

Focused tests were added or expanded for RPC diagnostics safety, signing request limits and signing UX copy, backup/restore warning/error normalization, route category boundaries, safe user-facing errors, and pending transaction-history refresh behavior.

Expected local validation remains:

```bash
fvm flutter analyze
fvm flutter test
```

During this documentation closure environment, `fvm`, `flutter`, and `dart` were not available, so those commands could not be executed here. The closure is therefore based on source/documentation review and the reported successful agent execution of subphases 8.5.1 through 8.5.5.

### Phase 8.5 Documentation Closure

The documentation trunk now records Phase 8.5 as completed across the project-level README, documentation index, phase plan, architecture references, deep architecture notes, feature inventory, flow documentation, UX notes, development boundary, RPC notes, security notes, release validation expectations, and design decisions.

This matters for the next Phase 8 work because later release/distribution maturity must not assume that diagnostics are telemetry, that signing is a dApp flow, that backup warnings imply a new backup format, or that shell navigation owns sensitive state. Phase 8.5 closes those boundaries explicitly.

### Phase 8.5 Final Status

Status: Completed.

Phase 8.5 is closed as a security, reliability, diagnostics, warning, lock/lifecycle, and invalid-state maturity phase over the Phase 8 wallet product surface. Future release/distribution maturation remains reserved for later Phase 8 work.

---

## 8.6.0 — Release & Distribution Baseline Inspection and Execution Contract

### Objective

Define the Phase 8.6 release and distribution maturity contract from the real Phase 8.5-completed codebase before any release tooling implementation is attempted.

### Scope

This documentation-only subphase inspects the current build tool, GitHub Release workflow, versioning model, MSIX configuration, Android artifact generation, checksum generation, and release documentation baseline.

It distinguishes the proven Phase 7 release automation from the Phase 8.6 improvements that may be implemented later.

### State

New documentation-only subphase generated from the existing Phase 8.6 parent section after Phase 8.5 closure.

### Existing Files Tentatively Intervenable

- `tool/build.dart` — inspect the current build automation surface, supported platform arguments, version bump behavior, MSIX synchronization, CI overrides, artifact discovery, and local signing/verification behavior.
- `.github/workflows/release.yml` — inspect the current GitHub Release automation, Android and Windows jobs, artifact upload/download boundaries, draft release publication, and checksum generation.
- `pubspec.yaml` — inspect the current semantic version, build number, dependency baseline, and `msix_config` values used by release automation.
- `docs/release.md` — record the current release baseline and the future 8.6 execution boundary without marking release tooling changes as implemented.
- `docs/phase8_scavium_wallet.md` — record the Phase 8.6 subphase map and release/distribution maturity contract.
- `docs/index.md` — record Phase 8.6 as the next planned Phase 8 area while keeping Phase 8.5 closed.
- `README.md` — optionally update project-level status to indicate that Phase 8.6 is planned, not complete.
- `docs/development.md` — optionally record the development boundary for release-tooling work.

### New Files Tentatively Creatable

None expected for this baseline subphase.

A new release checklist, release report, or artifact manifest file must not be introduced during 8.6.0 unless the real documentation structure proves that a separate document is required.

### Technical Justification

Phase 8.6 is a release/distribution maturity phase over an already expanded wallet surface. The project already contains a custom build tool and a GitHub Release workflow, so implementation must begin by confirming what is real rather than replacing the existing release baseline.

The baseline must preserve the Phase 7 release-hardening model while allowing later 8.6 subphases to improve artifact consistency, reporting, metadata, and validation in a controlled way.

### Expected Validations

- Confirm `tool/build.dart` remains the existing build automation owner.
- Confirm `.github/workflows/release.yml` remains the GitHub Release automation owner.
- Confirm Android APK, Android App Bundle, Web, Windows, and Windows MSIX build paths are represented in the current tool or workflow.
- Confirm MSIX version synchronization exists before planning further changes.
- Confirm checksum generation exists in the workflow before planning checksum/reporting extensions.
- Confirm no `.agent/*` files or runtime code are generated by this documentation subphase.

---

## 8.6.1 — Build Tool Artifact and Version Consistency Maturity

### Objective

Mature the local build automation so release operators can produce version-consistent artifacts with clearer deterministic output while preserving the existing `tool/build.dart` ownership model.

### Scope

This subphase may improve the build tool around artifact naming, artifact discovery, version synchronization, release output summaries, and safer operator feedback.

It must not replace the build tool with a different release system.

### State

New planned implementation subphase generated from the Phase 8.6 release/distribution maturity scope.

### Existing Files Tentatively Intervenable

- `tool/build.dart` — extend the existing build automation with stricter artifact reporting, clearer build summaries, safer version handling, and deterministic artifact path reporting.
- `pubspec.yaml` — may be touched only if the build/version strategy requires a documented and validated configuration adjustment, especially around `version:` or `msix_config.msix_version`.
- `docs/release.md` — document the build-tool behavior after implementation so release operators know which commands are authoritative.
- `docs/development.md` — record any developer-facing command boundary if the build tool gains new flags or validation modes.
- `docs/phase8_scavium_wallet.md` — record implementation result and validation outcome for 8.6.1.

### New Files Tentatively Creatable

- `tool/release_manifest.dart` or equivalent — only if the current `tool/build.dart` becomes too large to keep artifact manifest/reporting logic maintainable.
- Generated release manifest output under a generated build/distribution directory — only as generated output, not as committed source, unless the project later defines committed sample metadata.

### Technical Justification

The current build tool already owns platform selection, version bumping, MSIX synchronization, CI overrides, and artifact discovery. Phase 8.6 should strengthen that owner rather than splitting release behavior across scripts.

A deterministic artifact/version report reduces operator error when producing Android APK, Android App Bundle, Web, Windows, and MSIX outputs from the same semantic version and build number.

### Expected Validations

- `dart run tool/build.dart --check-version --expected-tag vX.Y.Z` still validates tag/pubspec consistency.
- Existing platform options remain compatible: `android-apk`, `android-bundle`, `web`, `windows`, `windows-msix`, and `all`.
- MSIX version remains synchronized with `pubspec.yaml`.
- Artifact reporting does not falsely mark missing artifacts as successful.
- Build automation remains usable locally and in CI.

---

## 8.6.2 — GitHub Release Workflow Artifact Consistency

### Objective

Mature the GitHub Release workflow so CI-produced release artifacts remain consistently named, grouped, checksummed, and published without weakening the existing draft-release safety model.

### Scope

This subphase may refine Android artifact handling, Windows MSIX artifact handling, release asset grouping, checksum generation, and workflow validation gates.

It must keep GitHub Releases draft-first unless a later explicitly documented release policy changes that behavior.

### State

New planned implementation subphase generated from the Phase 8.6 release/distribution maturity scope.

### Existing Files Tentatively Intervenable

- `.github/workflows/release.yml` — refine CI release jobs, artifact naming, artifact collection, checksum generation, and publish boundaries.
- `tool/build.dart` — may be adjusted only where CI workflow improvements require matching local build-tool support.
- `docs/release.md` — document CI release behavior, required secrets, produced artifacts, and checksum expectations.
- `docs/phase8_scavium_wallet.md` — record implementation result and validation outcome for 8.6.2.
- `README.md` — optionally update the high-level release automation summary if the workflow behavior changes visibly.

### New Files Tentatively Creatable

None expected by default.

A separate workflow file should only be created if the existing release workflow becomes structurally unsuitable for a single release pipeline.

### Technical Justification

The current workflow already validates tags, restores Android signing material, builds Android artifacts, restores the MSIX certificate, builds Windows MSIX, generates SHA256 checksums, and publishes a draft GitHub Release.

Phase 8.6 should improve consistency around those existing responsibilities rather than introducing parallel release publication paths or automatic store submission.

### Expected Validations

- Tag-triggered release validation remains compatible with `pubspec.yaml`.
- Manual workflow dispatch remains available.
- Android signing secrets remain required for Android release artifacts.
- MSIX certificate secrets remain required for Windows MSIX generation.
- SHA256 checksum generation remains present and deterministic.
- GitHub Release publication remains draft-first.

---

## 8.6.3 — Release Validation and Operator Reporting

### Objective

Add or mature release validation/reporting so operators can clearly see what was built, what was validated, what was skipped, and which artifacts belong to a release.

### Scope

This subphase may introduce deterministic release reports, validation summaries, missing-artifact checks, generated manifest output, or release-readiness command output.

It must not convert local diagnostics into telemetry, and it must not upload runtime wallet data anywhere.

### State

New planned implementation subphase generated from the Phase 8.6 release/distribution maturity scope.

### Existing Files Tentatively Intervenable

- `tool/build.dart` — add validation/reporting modes or structured release summary output if appropriate.
- `.github/workflows/release.yml` — consume or upload generated release reports if CI should preserve them as artifacts.
- `docs/release.md` — document report contents, validation expectations, and operator interpretation.
- `docs/development.md` — document local command expectations for release validation if new commands or flags are introduced.
- `docs/phase8_scavium_wallet.md` — record implementation result and validation outcome for 8.6.3.

### New Files Tentatively Creatable

- `tool/release_validate.dart` or equivalent — only if validation logic should remain separate from build execution.
- Generated release report files under a build/distribution output directory — only as generated artifacts unless the project explicitly defines committed examples.

### Technical Justification

The release pipeline currently builds and publishes artifacts, but operator confidence improves when outputs are explicitly enumerated and tied back to the version, platform, checksum, and workflow path that produced them.

Release reporting should stay local/CI-only and should not become analytics, telemetry, or runtime monitoring.

### Expected Validations

- Reports identify the release version and build number.
- Reports distinguish Android APK, Android App Bundle, Web, Windows build, Windows MSIX, and checksum outputs where applicable.
- Missing required artifacts fail clearly instead of producing ambiguous success output.
- Generated reports do not include secrets, signing passwords, private keys, mnemonic data, wallet addresses, signatures, or backup payload data.
- CI can preserve reports without changing runtime application behavior.

---

## 8.6.4 — Distribution Metadata and Store-Readiness Documentation

### Objective

Mature the documentation and metadata boundary for distribution without implementing automatic store submission or changing product scope.

### Scope

This subphase may document release metadata expectations, store-readiness boundaries, manual submission steps, required assets, version naming expectations, and platform-specific distribution constraints.

It must not add automatic Play Store upload, Microsoft Store submission, iOS distribution, or in-app update orchestration.

### State

New planned implementation/documentation subphase generated from the Phase 8.6 release/distribution maturity scope.

### Existing Files Tentatively Intervenable

- `docs/release.md` — expand release/distribution documentation with Phase 8.6 metadata and manual distribution expectations.
- `README.md` — optionally update high-level distribution readiness status.
- `docs/index.md` — optionally reflect Phase 8.6 planning or completion state when this subphase is implemented.
- `pubspec.yaml` — may be touched only if metadata configuration must be corrected to match documented release behavior.
- `docs/phase8_scavium_wallet.md` — record implementation result and validation outcome for 8.6.4.

### New Files Tentatively Creatable

- `docs/release_checklist.md` — only if `docs/release.md` becomes too large or if the project needs a separate operator checklist.

### Technical Justification

Phase 8.6 release maturity is not only a CI concern. Operators also need a clear manual distribution boundary so artifact generation, release notes, checksum verification, signing expectations, and store-readiness assets are not confused with automated store deployment.

This subphase keeps documentation honest: the project may become more release-ready without claiming capabilities that are not implemented.

### Expected Validations

- Documentation distinguishes generated artifacts from store submission.
- Manual distribution steps remain explicit.
- Automatic Play Store upload is still out of scope unless later implemented by a dedicated phase.
- Automatic Microsoft Store submission is still out of scope unless later implemented by a dedicated phase.
- Version, artifact, and checksum expectations remain consistent with the build tool and workflow.

---

## 8.6.5 — Cross-Platform Packaging Consistency and Release Closure Readiness

### Objective

Consolidate cross-platform packaging expectations before closing Phase 8.6, ensuring Android, Web, and Windows release paths are coherently represented and validated.

### Scope

This subphase may align packaging documentation, artifact naming expectations, generated reports, checksum behavior, and platform validation commands across local and CI release flows.

It must prepare the project for a clean 8.6 closure without introducing new product surfaces.

### State

New planned implementation/documentation subphase generated from the Phase 8.6 release/distribution maturity scope.

### Existing Files Tentatively Intervenable

- `tool/build.dart` — final consistency adjustments for artifact discovery, naming, or platform build reporting if required.
- `.github/workflows/release.yml` — final CI consistency adjustments if local/CI artifact behavior must be aligned.
- `docs/release.md` — align release documentation with the final 8.6 implementation state.
- `README.md` — optionally update project-level status after cross-platform release maturity is validated.
- `docs/index.md` — optionally update Phase 8.6 status after implementation.
- `docs/development.md` — document final development/release validation commands if changed.
- `docs/phase8_scavium_wallet.md` — record implementation result and validation outcome for 8.6.5.

### New Files Tentatively Creatable

None expected by default.

New committed files should only be introduced if earlier 8.6 subphases define a durable release manifest, release checklist, or validation helper as source-controlled project material.

### Technical Justification

The wallet supports multiple distribution targets, but those targets have different packaging and signing characteristics. Phase 8.6 should close only after those differences are explicitly represented and the operator can tell which artifacts are expected for each supported platform.

This prevents the release maturity phase from closing on Android-only or Windows-only confidence while the documentation claims broader production readiness.

### Expected Validations

- Android APK and Android App Bundle expectations are documented and validated.
- Windows MSIX expectations are documented and validated.
- Web build expectations are documented even if Web is not part of the current GitHub Release asset publication path.
- SHA256 checksum expectations remain consistent.
- Local and CI release flows do not contradict each other.
- No new runtime wallet behavior is introduced by packaging consistency work.

---

## 8.6.close — Release & Distribution Maturity Extension Closure

### Objective

Close Phase 8.6 by confirming that release and distribution maturity improvements are implemented, validated against the real codebase, and coherently represented in trunk documentation.

### Scope

This closure must record the actual implementation delivered by Phase 8.6.1 through Phase 8.6.5 and update trunk documentation without changing runtime wallet behavior.

### State

Planned documentation-only closure to be executed only after the Phase 8.6 implementation subphases are completed and validated.

### Existing Files Tentatively Intervenable

- `docs/phase8_scavium_wallet.md` — close Phase 8.6 from the real implemented release/distribution state.
- `docs/index.md` — move Phase 8.6 from planned to completed when implementation is validated.
- `README.md` — update project-level Phase 8 status only after Phase 8.6 is complete.
- `docs/release.md` — record final release/distribution behavior, commands, artifacts, checksums, and known out-of-scope boundaries.
- `docs/development.md` — record final development/release validation commands if they changed.
- Any other trunk Markdown document that directly references release/distribution scope and is contradicted by the final implementation.

### New Files Tentatively Creatable

None expected by default.

Closure should not create new operational files unless an earlier 8.6 subphase introduced a durable documentation artifact that must be linked from the trunk.

### Technical Justification

Phase 8.6 is a tooling and distribution maturity phase. Its closure must distinguish implemented release automation from manual distribution expectations, generated artifacts from source-controlled files, and validation evidence from aspirational release goals.

This protects the next project phase from inheriting ambiguous assumptions about store submission, artifact completeness, checksum reliability, release reporting, or version synchronization.

### Expected Validations

- Confirm all 8.6 implementation subphases are represented in `docs/phase8_scavium_wallet.md`.
- Confirm `README.md`, `docs/index.md`, `docs/release.md`, and `docs/development.md` match the real implementation state.
- Confirm no `.agent/*` files are included in the closure deliverable.
- Confirm no runtime code is modified by the closure itself.
- Confirm release pipeline changes, if any, are documented as implemented rather than planned.
- Confirm out-of-scope store submission and automatic delivery capabilities remain clearly bounded unless explicitly implemented later.

### Closure Boundaries

Phase 8.6 closure must deliberately avoid introducing:

- automatic Play Store upload;
- automatic Microsoft Store submission;
- iOS distribution;
- runtime update delivery;
- telemetry or analytics;
- release-time access to wallet secrets;
- backup format changes;
- transaction, signing, asset, account, or navigation feature changes.
