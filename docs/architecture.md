# SCAVIUM Wallet — Architecture

## 🧭 Overview

SCAVIUM Wallet follows a **modular, feature-driven architecture** designed for:

- scalability
- maintainability
- clear separation of concerns
- production-grade reliability

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

---

## 🎯 Result

The architecture enables:

- safe transaction execution
- resilient network communication
- extensibility for future features (DEX, multi-account, etc)