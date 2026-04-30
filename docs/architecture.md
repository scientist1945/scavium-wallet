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

