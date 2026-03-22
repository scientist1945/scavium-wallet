# SCAVIUM Wallet — Architecture

## 🧭 Overview

SCAVIUM Wallet follows a **modular, feature-driven architecture** designed for:

- scalability
- maintainability
- clear separation of concerns
- production-grade reliability
- low-risk release stabilization

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

---

## 🎯 Result

The architecture enables:

- safe transaction execution
- resilient network communication
- secure lock and unlock flows
- extensibility for future features (DEX, multi-account, etc)
- controlled release candidate hardening without destabilizing the codebase