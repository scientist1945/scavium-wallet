# SCAVIUM Wallet — Architecture

## 🧭 Overview

SCAVIUM Wallet follows a **modular, feature-driven architecture** designed for:

- scalability
- maintainability
- clear separation of concerns
- production-grade reliability
- low-risk release stabilization
- controlled product expansion from a stable baseline

The system is structured around **Flutter + Riverpod + Web3dart**.

---

## 🏗️ Core Stack

- Flutter (UI)
- Dart (logic)
- Riverpod (state management)
- Web3dart (EVM interaction)
- GoRouter (navigation)

---

## 🧱 Architectural Principles

- Feature-based modularization
- Clear separation: UI / Application / Domain / Data
- Stateless UI + reactive state
- Controlled side-effects via controllers
- RPC abstraction layer
- Platform-specific fixes without architecture redesign during stabilization

---

## 📂 Feature Structure

features/
  blockchain/
  wallet/
  assets/
  home/
  lock/
  settings/
  onboarding/

Each feature contains:

- application (controllers)
- domain (models)
- data (repositories/services)
- presentation (UI)

---

## 🔁 State Management

All state is managed using **Riverpod AsyncNotifier**:

- async-safe
- predictable lifecycle
- reactive UI updates

Controllers:

- handle business logic
- orchestrate RPC calls
- update UI state

---

## 🔗 RPC Layer

The RPC system is abstracted via:

scavium_rpc_service.dart

Responsibilities:

- multi-endpoint support
- failover handling
- cooldown logic
- request routing (read vs write)

---

## 🔒 Security Layer

Includes:

- lifecycle-based locking
- secure storage for keys
- biometric integration (optional)
- Android screenshot protection

---

## 🧾 Persistence Model

Sensitive wallet material is stored through secure storage.

Non-sensitive application state continues to be stored separately through local storage.

From Phase 7.2 onward, wallet availability is treated as valid only when secure state and local runtime state remain internally consistent.

This keeps the original persistence architecture intact while making the runtime behavior more defensive.

---

## 🎨 Shared Branding Layer

The application also uses shared presentation widgets for visual brand consistency.

From Phase 7.3 onward, the shared logo widget renders the official SCAVIUM asset instead of a placeholder-style letter-based composition.

This preserves the existing widget structure while aligning runtime UI branding with packaged assets.

---

## 🛠️ Tooling Layer

From Phase 7.4 onward, the project also includes a Dart-native build automation tool located in:

tool/build.dart

This tooling layer does not alter runtime application architecture, but it standardizes version handling and multiplatform build execution around the existing Flutter project structure.

---

## ♻️ Backup and Recovery Layer

From Phase 7.5 onward, the project includes an encrypted backup and restore layer composed of:

- backup payload models
- encrypted backup models
- backup cryptography service
- backup file service
- wallet backup controller
- export and restore UI flows

This layer is intentionally built on top of the existing wallet repository and secure storage system rather than replacing them.

That means:

- runtime secrets still live in secure storage
- backup files are user-managed and external
- restore reuses the same hardened wallet import flows already present in the app

---

## 🧩 Stabilization Model

From Phase 7 onward, the architecture enters a stabilization-oriented operational mode.

This means:

- existing boundaries remain intact
- fixes are applied at the smallest safe layer
- no structural redesign is introduced during bug-fix phases
- platform regressions are corrected locally without expanding scope

Concrete examples include:

- the Android biometric fix of Phase 7.1, solved through a platform-layer correction
- the wallet persistence hardening of Phase 7.2, solved through service, repository, startup, and Android manifest corrections without changing the overall architecture
- the branding correction of Phase 7.3, solved through a shared-widget asset correction without altering UI flows
- the build hardening of Phase 7.4, solved through project-native tooling without changing runtime feature architecture
- the encrypted recovery flow of Phase 7.5, solved by adding a backup layer that reuses existing wallet persistence semantics

---

## 🧭 Phase 8 Product Expansion Model

From Phase 8 onward, the architecture is allowed to expand product capabilities, but only through bounded and incremental subphases.

The following architectural commitments remain unchanged:

- Riverpod remains the state-management layer
- GoRouter remains the navigation layer
- secure storage remains responsible for sensitive wallet material
- backup and restore must remain compatible with wallet persistence semantics
- release tooling remains stable until release-maturity work explicitly modifies it

Phase 8 expansion areas are expected to build on the existing feature structure instead of replacing it.

The intended expansion path is:

1. account model expansion
2. account-aware asset and portfolio structure
3. navigation shell evolution
4. transaction, activity, and signing maturity
5. security, diagnostics, and release maturity extension

This allows the wallet to grow beyond the current dashboard-centered model without turning product expansion into a broad architecture rewrite.

---

## 🎯 Result

The architecture enables:

- safe transaction execution
- resilient network communication
- secure lock and unlock flows
- explicit and user-managed wallet recovery
- extensibility for future features (DEX, multi-account, etc)
- controlled release candidate hardening without destabilizing the codebase
- controlled Phase 8 product expansion without replacing the established architecture
---

## 👛 Phase 8.1 Account Model Expansion Contract

Phase 8.1 introduces the account model expansion path, but implementation must remain compatible with the current single-account architecture.

The current stable baseline is a single `WalletProfile` with one `WalletAccount`.

Future multi-account support must be introduced through repository and controller boundaries rather than by letting UI widgets directly mutate persisted wallet state.

The intended architectural direction is:

```text
WalletProfile
├── accounts[]
├── activeAccountId
├── defaultAccountId
└── wallet metadata
```

Architectural constraints for 8.1.x:

- Riverpod remains the application-state owner.
- GoRouter remains the navigation owner.
- Secure storage remains responsible for sensitive wallet material.
- Wallet repositories own persistence compatibility and migration behavior.
- Controllers expose account-aware state to presentation layers.
- UI surfaces consume selected account state but do not own secure persistence.

The legacy single-account wallet must be interpreted as the default and active account when the multi-account model is introduced.

Phase 8.1.1 begins this transition at the domain layer by preserving `profile.account` while adding the internal `accounts[]`, `activeAccountId`, and `defaultAccountId` foundation. This preserves Phase 7 behavior while enabling future Phase 8 account-aware assets, activity, signing, and navigation surfaces.


---

## Phase 8.1.2 Account Storage Architecture

The wallet now has a compatibility storage foundation for future multi-account behavior.

The runtime account model is represented by `WalletProfile.accounts`, `activeAccountId`, and `defaultAccountId`, while `WalletProfile.account` remains the compatibility accessor used by existing single-account surfaces.

Storage is intentionally layered:

- legacy wallet keys remain available for existing installations and backup/restore v1 compatibility
- multi-account metadata is persisted in parallel through account JSON and active/default account identifiers
- loading falls back from multi-account metadata to legacy single-wallet data when required

The storage layer does not yet expose account switching. That responsibility is deferred to the active account controller subphase.

---

## Phase 8.1.3 Active Account Controller Architecture

Phase 8.1.3 introduces the active-account controller boundary on top of the multi-account storage foundation.

The repository remains the persistence owner. The wallet controller remains the application-state owner. UI code continues to consume `WalletProfile.account` as the compatibility account while future account-aware surfaces may consume `WalletProfile.activeAccount` or `WalletController.activeAccount`.

The active account is resolved from `WalletProfile.accounts` and persisted through `wallet_active_account_id`. The default account remains independent and is persisted through `wallet_default_account_id`.

This keeps the architecture prepared for an account switcher without introducing new routes, new surfaces, backup changes, or release pipeline changes in this subphase.

## Phase 8.1.5 — Account Creation Architecture Note

Account creation/import remains owned by the wallet feature boundary:

- presentation opens the add-account sheet from the account switcher;
- `WalletController` exposes account-addition commands;
- `WalletRepository` defines derived/imported account creation contracts;
- `WalletRepositoryImpl` owns derivation, validation, duplicate protection, secure persistence, and active-account refresh.

The architecture deliberately keeps account metadata separate from imported private-key material. Account metadata is persisted in multi-account JSON storage, while imported private keys are stored through secure storage under account-key mapping. Backup v2 is not introduced in this phase.

---

## 📊 Phase 8.2 Asset & Portfolio Layer

Phase 8.2 extends the asset feature while preserving the existing feature-driven architecture.

The asset layer now includes:

- `PortfolioSummary` as a deterministic domain summary derived from visible assets;
- `AssetAccountContext` as the account-aware bridge between the wallet account model and asset presentation;
- normalized `TokenInfo` handling for manual ERC-20 registration;
- token registry repository deduplication by normalized contract address;
- account-context propagation through `AssetItem`.

The separation remains:

```text
wallet/application
  owns active account state

assets/application
  loads visible assets and derives account context

assets/domain
  defines asset, token, portfolio, and account-context models

assets/data
  persists the manual token registry

assets/presentation
  renders portfolio summary, asset list, token addition, and asset detail surfaces
```

Phase 8.2 deliberately does not move RPC ownership into the asset UI and does not introduce automatic token discovery or indexer-backed portfolio aggregation.

### Account-Aware Boundary

Assets can carry the active account context, but account ownership remains with the wallet feature.

This prevents the asset feature from becoming the owner of wallet identity while still allowing asset UI to clearly display which account the current asset view belongs to.

### Portfolio Summary Boundary

The portfolio summary is derived from currently loaded asset entries only.

It does not represent fiat valuation, undiscovered assets, external indexer results, or multi-chain holdings.

---

## 🧾 Phase 8.3 Transaction, Activity, and Signing Layer

Phase 8.3 extends the assets and signing features while preserving the existing feature-driven architecture.

The transaction/activity layer now includes:

- `TxHistoryEntry` as the persisted local outgoing transaction record;
- `TxHistoryFilter` as the local filtering and grouping helper;
- `TxHistoryController` as the Riverpod owner for history loading, insertion, and receipt refresh;
- `TransactionDetailScreen` as the first-party transaction detail surface;
- `ScaviumRpcService.getReceipt(...)` as the receipt lookup boundary.

The signing layer now includes:

- `SigningMode`, `SigningRequest`, and `SigningResult` as signing domain models;
- `SigningService` as the signing boundary;
- `RpcSigningService` as the adapter to the RPC/wallet credential layer;
- `SigningController` as the Riverpod owner of signing execution state;
- `SigningScreen`, `SigningConfirmDialog`, and `SigningResultCard` as the presentation layer.

The separation remains:

```text
assets/application
  owns local outgoing history state and receipt refresh

assets/domain
  defines transaction-history records, status, kind, and local filters

assets/data
  persists local outgoing history and keeps transaction-feed indexing as a future seam

assets/presentation
  renders history, filters, grouping, and transaction detail

signing/domain
  defines signing modes, requests, and results

signing/application
  validates active-account signing and delegates to the signing service

signing/presentation
  renders preview, confirmation, cancellation, and result display

blockchain/data
  owns RPC receipt reads and credential-backed signing operations
```

Phase 8.3 deliberately does not move wallet identity ownership into the assets or signing features. Active account state remains owned by the wallet feature, while RPC execution remains owned by `ScaviumRpcService`.

### Local Activity Boundary

Local outgoing history is the current first-party activity source.

The wallet does not claim incoming transaction discovery, external transaction indexing, automatic token activity, or full explorer replacement. `TransactionFeedRepositoryImpl` remains an empty future extension seam until a later phase explicitly introduces an explorer/indexer-backed activity boundary.

### Signing Boundary

Signing is not transaction submission.

Signing uses active wallet credentials to produce a signature for an explicit message/challenge after preview and confirmation. It does not submit transactions, refresh balances, write transaction-history entries, or alter backup payloads.
---

## 🧭 Phase 8.4 Navigation Shell Architecture

Phase 8.4 adds a navigation shell layer without changing the ownership model of the wallet features.

The navigation-shell layer is structured as:

```text
app/router
  owns route names, route classification, route registration, and redirects

app/shell
  owns authenticated shell composition, primary destination metadata, and responsive navigation chrome

features/*/presentation
  continue to own feature-specific screens and user workflows

features/*/application
  continue to own Riverpod feature state and business coordination
```

Implemented shell files:

- `lib/app/router/app_route_category.dart`
- `lib/app/shell/app_shell.dart`
- `lib/app/shell/app_shell_destination.dart`
- `lib/app/shell/responsive_navigation.dart`

`GoRouter` remains the only routing owner. `ShellRoute` is used only to compose primary authenticated destinations.

Primary shell destinations are:

- Home
- Assets
- Activity
- Settings

Secondary/action/detail routes remain explicit and outside shell business ownership, including Accounts, Send, Receive, Signing, Add Token, Send Token, Asset Detail, Transaction Detail, RPC Diagnostics, backup export, onboarding, wallet entry, and lock.

The shell does not own wallet identity, account selection, assets, transaction history, signing, backup/restore, RPC diagnostics, or destructive actions. Those remain inside their existing feature boundaries.


---

## 🛡️ Phase 8.5 Security, Reliability, and Diagnostics Architecture

Phase 8.5 hardens sensitive wallet behavior without replacing the established feature-driven architecture.

The architectural point of the phase is that safety is improved at existing ownership boundaries rather than by creating a new cross-cutting owner that would obscure responsibility.

Architectural ownership remains unchanged:

- `GoRouter` owns route and redirect behavior.
- the authenticated shell owns navigation presentation only.
- wallet identity, active account, lock, and backup ownership remain inside their existing wallet/security feature boundaries.
- RPC execution and diagnostics remain inside the blockchain feature.
- signing remains inside the signing feature, with active-account validation against wallet state.
- lifecycle lock state remains centralized in the lock/security layer rather than shell widgets.
- asset, send, token-send, transaction-history, and async UI surfaces keep their controller-level ownership.

The new error-boundary helpers are intentionally small shared utilities. They normalize user-facing messages and suppress sensitive material, but they do not introduce a new global error architecture or change domain ownership. This is important because Phase 8.5 touches many surfaces; the implementation improves copy and failure behavior without making every feature depend on a new monolithic error subsystem.

Diagnostics are also intentionally local. They expose useful non-sensitive runtime state, but they are not telemetry, not analytics, not remote reporting, and not a support-upload pipeline.

Phase 8.5 deliberately does not add telemetry, analytics, remote diagnostics reporting, dApp connectivity, WalletConnect, background signing, automatic challenge ingestion, backup payload migrations, shell-owned security state, or release-pipeline changes.


---

## 🎨 Phase 9 Application Identity and Theme Architecture

Phase 9 is open as an application identity and visual-system maturity phase over the Phase 8.6-completed codebase. Phase 9.0 locks the architectural boundary before runtime implementation begins.

Architecturally, Phase 9 should keep identity and theme ownership separated from wallet domain logic:

- runtime app version display should be owned by a small application identity/version boundary rather than hardcoded Settings copy;
- build/MSIX version synchronization should remain in the build tooling layer and continue to treat `pubspec.yaml` as the project version source;
- visual design should be normalized through the app theme layer before broad screen-level changes are made;
- light and dark themes should derive from shared SCAVIUM design tokens instead of becoming separate ad-hoc palettes;
- theme-mode selection should be local, persisted, reactive, and applied at the app root.

The SCAVIUM Design Token System locked in Phase 9.0 establishes brand, background, surface, border, text, semantic, interaction, shape, spacing, and elevation tokens. This keeps the existing SCAVIUM identity recognizable while reducing saturation and improving hierarchy across mobile, web, and desktop surfaces. Later Phase 9 implementation must keep wallet domain ownership separate from visual identity concerns.

### Phase 9.3 Theme Token Boundary

Phase 9.3 is closed as the token-foundation step for the visual architecture. Theme ownership remains under `lib/app/theme`, and canonical token ownership is explicit under `lib/app/theme/tokens/`. The normalized namespace contains `ScavoColors`, `ScavoSpacing`, `ScavoRadius`, `ScavoElevation`, `ScavoTypography`, and the `scavo_tokens.dart` barrel export.

The architectural rule after 9.3 is that token ownership belongs to the app theme layer, not to individual screens. `AppColors` and `AppTextStyles` are compatibility facades over the token namespace, and `AppTheme.darkTheme` consumes token names while preserving the existing dark-only runtime surface. Shared visual widgets now adopt token values for cards, primary/secondary buttons, section titles, snackbars, and confirmation dialogs, proving the contract without forcing a screen-by-screen redesign. Wallet domain modules, repositories, controllers, routes, release tooling, and CI workflows remain outside the token-normalization boundary.

Phase 9.3 did not introduce light-mode runtime behavior; that remains a Phase 9.4/9.5 responsibility. Future theme work should extend the token namespace rather than reintroducing scattered screen-level colors, component-specific magic values, or parallel screen-local palettes.



---

## 🎨 Phase 9.5 Theme Mode Runtime Architecture

Phase 9.5 closes the runtime appearance-selection boundary without moving theme ownership out of the app theme layer.

The implemented ownership split is:

- `AppTheme.lightTheme` and `AppTheme.darkTheme` remain the only concrete theme definitions selected at runtime;
- `ThemeModePreference` owns the supported application preference values, storage strings, labels/descriptions, fallback behavior, and Flutter `ThemeMode` mapping;
- `ThemeModeRepository` defines the persistence contract;
- `LocalThemeModeRepository` persists the selected value through `LocalStorageService` and `StorageKeys.themeModePreference`;
- `themeModeRepositoryProvider` exposes persistence through the existing provider boundary;
- `ThemeModeController` owns reactive preference state and persistence updates;
- `ScaviumWalletApp` is the only app-root consumer that applies the selected mode to `MaterialApp.router`;
- Settings owns only the user interaction through `ThemeModeSelector`.

This keeps the architecture layered: Settings does not serialize or read storage directly, the app root does not know storage details, token files do not know user preference state, and wallet/domain modules do not participate in appearance selection. Future theme-mode work should extend this boundary rather than introducing screen-local theme branches or direct storage calls from UI widgets.
