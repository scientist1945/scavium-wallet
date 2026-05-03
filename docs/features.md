# SCAVIUM Wallet — Features

## 🧭 Overview

This document lists implemented features up to the completed stabilization phase and records the Phase 8 expansion direction.

Phase 7 did not add new unrelated product scope. It hardened and validated the existing product while adding essential safety and operational capabilities where needed.

Phase 8 begins controlled product expansion from that stabilized baseline. Planned capabilities are documented separately until implemented.

---

## 🔐 Wallet

- Create wallet
- Import wallet (mnemonic / private key)
- Secure storage
- Restore from encrypted backup

---

## 💸 Transactions

- Native transfers
- ERC-20 transfers
- Gas estimation
- Transaction preview
- Confirmation dialog

---

## 🧾 History

- Local transaction history
- Receipt tracking
- Status updates (pending → confirmed)

---

## 🔁 Auto-refresh

- Periodic refresh
- Lifecycle-aware
- Updates balances, network, history

---

## 🔒 Security

- Automatic lock on background
- Session protection
- Secure key handling
- Optional biometric unlock
- Android screenshot protection
- Encrypted backup export

---

## 🔗 RPC

- Multi-endpoint support
- Failover
- Cooldown
- Diagnostics UI

---

## 🎨 UI

- Modular layout
- Consistent feedback
- Loading states
- Navigation structure
- Shared logo widget using official SCAVIUM asset

---

## 📊 Diagnostics

- RPC status visibility
- Failover tracking
- Node information

---

## 🛠️ Release Tooling

- Dart-native build tool
- Automatic build-number increment
- Semantic version override support
- Multiplatform build orchestration
- Windows MSIX packaging support

---

## ♻️ Recovery Features

The wallet now supports three explicit recovery paths:

- mnemonic
- private key
- encrypted backup file

The encrypted backup flow includes:

- password-protected backup generation
- external backup file export
- desktop save dialog support
- mobile share/export flow
- restore from backup during wallet entry

---

## 🧭 Phase 8 Expansion Direction

Phase 8 introduces planned product expansion areas without treating them as implemented until their subphases are completed.

Planned expansion areas include:

- multi-account / multiple wallet support
- account switcher and account metadata
- richer asset and portfolio surfaces
- account-aware asset organization
- transaction and activity maturity
- message signing with explicit preview and confirmation
- multi-surface navigation for desktop, web, and mobile
- additional security, reliability, and diagnostics maturity

The current Phase 8.1.1 state includes internal domain preparation for account-aware expansion. User-visible multi-account behavior remains planned for later Phase 8.1 subphases.

---

## 🛠️ Stabilization Notes

Phase 7.1 did not introduce a new feature.

It restored Android biometric unlock reliability by fixing a platform integration regression in the existing biometric flow.

Phase 7.2 also did not introduce a new feature.

It hardened wallet persistence behavior, startup validation, and backup gating within the existing wallet model.

Phase 7.3 also did not introduce a new feature.

It corrected branding consistency by replacing a placeholder-style shared logo implementation with the official SCAVIUM asset.

Phase 7.4 also did not introduce a new end-user feature.

It hardened build and versioning operations by introducing a project-native release tool.

Phase 7.5 introduced a user-facing safety feature.

It added encrypted backup export and restore, giving users a practical recovery option beyond local storage and manual mnemonic handling.

---

## 🎯 Summary

The wallet supports all core operations required for a functional EVM wallet and has completed a stabilization stage focused on release quality, operational consistency, and safer real-world recovery behavior.

Phase 8 builds on that baseline to expand the product surface in controlled, documented, and incrementally validated subphases.
---

## 👛 Phase 8.1 Planned Account Expansion

Phase 8.1 defines the controlled transition from the current single-account wallet into a future multi-account wallet model.

The current implemented feature remains:

- one active wallet account
- secure wallet creation/import
- encrypted backup and restore compatibility

The planned account expansion introduces, in later implementation subphases:

- multiple wallet accounts
- active account selection
- default account semantics
- account labels or aliases
- account-aware assets and activity
- backup payload evolution with v1 restore compatibility

As of Phase 8.1.4, the domain model, storage foundation, active-account controller path, and a basic account switcher UI are prepared for account-aware expansion. The switcher displays and selects among already-known accounts, while account creation, account import, account deletion, label editing, and backup payload evolution remain planned Phase 8 capabilities rather than completed runtime behavior.



---

## 👛 Phase 8.1.4 Account Switcher Basic UI

Phase 8.1.4 adds a minimal account switcher to the wallet home surface.

Implemented behavior:

- display the active account
- display already-known accounts from the wallet profile
- allow switching to another already-known account through the controller path
- preserve single-account fallback behavior

Not implemented in this subphase:

- creating additional accounts
- importing additional accounts into an existing profile
- deleting accounts
- editing labels
- changing backup/restore payloads

## Phase 8.1.5 — Account Creation & Import Expansion

SCAVIUM Wallet now supports adding additional accounts on top of the multi-account foundation:

- derived accounts for mnemonic wallets;
- imported private-key accounts;
- secure storage for imported account private keys;
- duplicate account address protection;
- automatic activation of the newly added account;
- minimal add-account UI from the account switcher.

Backup/restore v1 remains unchanged in this phase. Backup v2 compatibility is intentionally deferred to a later explicit subphase.

## Phase 8.1.6 — Backup / Restore Multi-Account Compatibility

SCAVIUM Wallet now supports account-aware backup payloads. Version 1 backups remain restorable, while version 2 backups preserve the multi-account account list, active/default account selection, and imported-account key material inside the encrypted backup envelope.

---

## 📊 Phase 8.2 Implemented Asset & Portfolio Features

Phase 8.2 converts the asset expansion plan into implemented product capability.

Implemented capabilities:

- portfolio summary card derived from visible assets;
- total asset count;
- native asset count;
- ERC-20 token count;
- non-zero asset count;
- active account context on asset items;
- deterministic manual token address validation;
- normalized ERC-20 token registry entries;
- duplicate-token prevention;
- safe token metadata loading feedback;
- improved asset list presentation;
- responsive asset surface width constraints;
- native/ERC-20 visual distinction;
- preserved asset detail and send-token flows.

The implementation remains explicit and local. It does not introduce automatic token discovery, external indexing, fiat valuation, or multi-chain aggregation.

---

## Phase 8.2 Completion State

Phase 8.2 is complete as an asset and portfolio foundation phase.

The product now has an account-aware asset surface that can support later activity, signing, navigation, and broader portfolio maturity work without requiring a disruptive redesign.

---

## 🧾 Phase 8.3 Implemented Transaction, Activity, and Signing Features

Phase 8.3 converts the transaction/activity maturity plan into implemented product capability while preserving the local outgoing-history boundary.

Implemented transaction and activity capabilities:

- defensive local transaction-history entry deserialization;
- safe fallback behavior for older or malformed stored entries;
- centralized receipt refresh through `TxHistoryController`;
- pending transactions remain pending when no receipt is available;
- transaction detail route for locally tracked outgoing activity;
- receipt-oriented status explanation for pending, confirmed, and failed transactions;
- explicit explorer opening from transaction detail;
- status filtering for all, pending, confirmed, and failed entries;
- kind filtering for native and ERC-20 sends;
- local-day grouping with newest-first entry ordering;
- distinct empty, filtered-empty, and error states.

Implemented signing capabilities:

- dedicated signing domain model and controller boundary;
- personal-message signing;
- challenge-message signing;
- active-account validation before signing;
- explicit signing preview and confirmation;
- cancellation path without wallet-state mutation;
- visible signature result display;
- signature copy feedback.

The implementation does not introduce external activity indexing, incoming transaction discovery, dApp connectivity, automatic wallet-connect behavior, or transaction submission from signing.

---

## Phase 8.3 Completion State

Phase 8.3 is complete as a transaction/activity/signing maturity phase.

The product now has safer local outgoing activity handling and explicit signing behavior that can support later navigation-shell and product-surface expansion without moving ownership away from the existing assets, signing, wallet, and RPC boundaries.
---

## 🧭 Phase 8.4 Implemented Navigation Shell and Product Surface Features

Phase 8.4 converts the navigation-shell and product-surface plan into implemented product capability.

Implemented capabilities:

- route classification for primary, public, lock, action, detail, and secondary routes;
- responsive authenticated shell around the primary product destinations;
- compact bottom navigation for mobile-sized layouts;
- wide-layout navigation rail for web/desktop-sized layouts;
- primary destinations for Home, Assets, Activity, and Settings;
- Home dashboard segmentation through dedicated balance and recent-activity widgets;
- dedicated Accounts surface for active-account placement clarity;
- organized Settings sections for security/recovery, signing, diagnostics, danger-zone actions, and about information;
- explicit preservation of action/detail routes for send, receive, signing, add token, token send, asset detail, transaction detail, RPC diagnostics, backup export, and reset.

The implementation remains explicit and local. The shell does not own wallet state, asset state, transaction-history state, signing state, backup behavior, or RPC execution.

---

## Phase 8.4 Completion State

Phase 8.4 is complete as a navigation-shell and product-surface maturity phase.

The product now has a scalable authenticated navigation structure that can support later UX, diagnostics, security, and product-surface phases without overloading Home or moving ownership away from existing feature boundaries.


---

## 🛡️ Phase 8.5 Implemented Security, Reliability, and Diagnostics Features

Phase 8.5 converts the security/reliability/diagnostics maturity plan into implemented hardening over existing wallet surfaces. It is not a product-surface expansion like Phase 8.4 and it is not a release-pipeline phase like the later Phase 8.6 scope. It is a runtime maturity layer applied to sensitive flows that were already present: diagnostics, signing, backup/export, restore, lifecycle lock, screenshot protection, send, token send, asset refresh, transaction-history refresh, and generic async state presentation.

Implemented diagnostics hardening:

- RPC health errors are normalized into safe user-facing copy.
- RPC status UI no longer displays raw exception contents.
- diagnostics remain local, non-invasive, and RPC-focused.
- useful operational context such as chain, block, endpoint, active RPC, and cooldown state remains visible when available.

Implemented signing safety hardening:

- signing requests reject empty messages and messages over the configured safety limit.
- signing copy explicitly distinguishes signatures from transactions, fund movement, and transaction receipts.
- personal-message and challenge-message warnings are shown before confirmation.
- confirmation and cancellation remain explicit and non-mutating.
- signature results are presented as signatures only, not as submitted transactions.

Implemented backup and recovery hardening:

- export and restore screens use stronger password/file responsibility warnings.
- backup errors are normalized so raw payload, mnemonic, password, ciphertext, private-key, address, or signature details are not exposed.
- encrypted backup payload semantics and compatibility remain unchanged.
- v1/v2 restore compatibility remains part of the self-custody safety baseline.

Implemented reliability and error-boundary hardening:

- lifecycle refresh does not restart while the app is locked.
- Android screenshot-protection plugin failures are non-fatal.
- invalid asset, transaction, token-send, native-send, and async error states use safer user-facing messages.
- pending transaction-history refresh preserves local entries when receipts are unavailable or RPC refresh fails.

## Phase 8.5 Completion State

Phase 8.5 is complete as a security, reliability, diagnostics, warning, lock/lifecycle, and invalid-state maturity phase.

The product now has safer diagnostics, clearer signing and backup warning surfaces, more reliable lifecycle behavior, and normalized error handling without adding telemetry, analytics, remote diagnostics reporting, dApp connectivity, WalletConnect, automatic challenge ingestion, backup format changes, shell-owned security state, or release-pipeline changes.


---

## 🎨 Phase 9 Application Identity and Theme Features

Phase 9 is open to add identity and appearance maturity rather than new wallet transaction capabilities. Phase 9.0 completed the documentation lock, Phase 9.1 completed the runtime app version surface, Phase 9.2 closed build/MSIX version hardening, Phase 9.3 closed token normalization, Phase 9.4 closed paired light/dark theme construction, Phase 9.5 closed runtime theme-mode selection and persistence, and Phase 9.6 closed Settings/About UX alignment plus final visual-system polish.

Implemented Phase 9.1 user-visible capability:

- dynamic application version display in Settings/About, resolved from runtime package metadata through the app identity boundary;

Implemented Phase 9.5 user-visible capability:

- local Appearance selection in Settings with `system`, `light`, and `dark` options;
- persisted appearance preference applied reactively at the app root;

Implemented Phase 9.6 user-visible capability:

- smoother Settings/About hierarchy for Appearance, security/recovery, signing, diagnostics, danger-zone, and About identity controls;
- SCAVIUM-aligned visual polish with orange primary actions/selected states, dark-first identity, improved light-mode legibility, and lighter Lucide iconography.

Implemented non-user-facing 9.1 capability:

- centralized runtime version formatting and provider-based metadata resolution under `lib/core/app_identity`;

Implemented non-user-facing Phase 9 visual-system capabilities include:

- explicit validation of build/MSIX version synchronization through the 9.2 build-tool hardening sequence;
- reduced direct color coupling inside UI code through the token namespace and theme-specific color boundary;
- token-based theme construction for future maintainability;
- centralized icon-size ownership through `ScavoIconSize` and Lucide-based icon usage across the primary wallet surfaces.

Phase 9 does not add WalletConnect, dApp connectivity, new transaction flows, new signing flows, analytics, telemetry, remote configuration, or white-label runtime customization.

---

## 🎨 Phase 9 Visual-System Maturity

Phase 9 records application identity and visual-system maturity as an active product track. Runtime app version display is implemented through the app identity boundary, build/MSIX version hardening is closed through the build tool and focused tests, and Phase 9.3 is closed as the SCAVIUM theme-token normalization sequence.

The implemented 9.3 capability is internal visual-system maturity: a normalized app-theme token namespace under `lib/app/theme/tokens/` that prepares first-class light/dark themes without exposing light mode or user-selectable appearance behavior yet. Existing public theme consumers remain stable through `AppColors` and `AppTextStyles` compatibility facades, `AppTheme.darkTheme` consumes token names directly, and shared visual widgets now use token values for card, action, spacing, feedback, and dialog consistency.


---

## 🎨 Phase 9.5 Implemented Theme Mode Selection Features

Phase 9.5 converts the paired light/dark theme contract into a user-selectable runtime feature without changing wallet-domain behavior.

Implemented appearance features:

- Settings includes an Appearance section with `System`, `Light`, and `Dark` choices;
- the selected mode is persisted locally on the device;
- missing or invalid stored values fall back safely to the system preference;
- the app root applies the selected Flutter `ThemeMode` reactively;
- light and dark rendering continue to use the centralized `AppTheme.lightTheme` and `AppTheme.darkTheme` definitions delivered by 9.4.

The feature remains intentionally local and bounded. Phase 9.5 does not add remote preferences, account-synced settings, telemetry, analytics, white-label configuration, new wallet operations, new signing behavior, backup changes, diagnostics changes, or release tooling changes.


---

## 🎨 Phase 9.6 Implemented Settings/About and Visual Polish Features

Phase 9.6 completes the user-facing Settings/About alignment that follows the Phase 9.5 runtime appearance selector.

Implemented Settings/About features:

- Appearance remains available in Settings with `System`, `Light`, and `Dark` choices;
- Settings groups Appearance, security/recovery, signing, diagnostics, danger-zone, and About identity surfaces with clearer hierarchy;
- About continues to show dynamic installed version information through the app identity provider;
- Settings tests cover section visibility, dynamic About version display, wide-surface availability, and selector-driven preference updates.

Implemented visual-system features:

- orange SCAVIUM primary action and selected-state treatment;
- dark-first theme identity with functional light-mode support;
- green reserved for semantic success/confirmed states;
- Lucide iconography across navigation, Settings, Home, Assets, Activity/History, Wallet/Accounts, Signing, and transaction detail surfaces;
- centralized icon sizing through `ScavoIconSize`;
- primary-tinted asset avatars and improved unlock/light-mode text contrast.

The feature remains bounded to application identity and visual maturity. Phase 9.6 does not add WalletConnect, dApp connectivity, new transaction flows, new signing semantics, analytics, telemetry, remote preferences, white-labeling, backup payload changes, diagnostics behavior changes, or release tooling behavior.
