# SCAVIUM Wallet — Architecture

## 🧭 Context

This document describes the **current architecture after Phase 5 (Core Wallet Implementation, up to 5.4)**.

It reflects the consolidated system resulting from:

- Phase 1 — Foundation
- Phase 2 — Wallet Core
- Phase 3 — Blockchain Integration
- Phase 4 — Assets & Tokens
- Phase 5 — Stability, UX, and lifecycle integration

---

## 🏗️ Overview

The application follows a **feature-based modular architecture**, built with:

- Flutter + Dart
- Riverpod (AsyncNotifier / Notifier)
- Web3dart (EVM interaction)
- GoRouter (reactive navigation)

---

## 📁 Structure

Each feature is isolated and structured into:

- application/ → controllers and logic  
- domain/ → models  
- data/ → repositories and services  
- presentation/ → UI  

### Main features

features/
  wallet/
  blockchain/
  assets/
  home/
  lock/
  onboarding/
  settings/

---

## 🔁 Data Flow

All interactions follow a consistent pattern:

UI → Controller → Repository → RPC → Blockchain → Response → State → UI

---

## ⚙️ State Management

Riverpod is used as the central state layer.

### Patterns

- AsyncNotifier → async operations (RPC, balances, history)
- Notifier → synchronous state (lock state, UI triggers)

---

## 🔀 Navigation

Navigation is handled using GoRouter.

### Key behaviors

- route-based navigation
- reactive redirects
- lock-aware routing
- onboarding flow control

---

## 🔄 Auto-refresh Model

Implemented in:

home_auto_refresh_controller.dart

### Behavior

- periodic timer (15 seconds)
- invalidates core providers:
  - network info
  - assets
  - transaction history

### Conditions

- disabled when locked
- restarted after unlock

---

## 🔒 Security Integration

- private keys stored securely
- lifecycle-based locking
- no key exposure outside device

---

## 📊 Result

The architecture provides:

- scalability
- modularity
- predictable state flow
- production-ready structure

---

## 🚀 Conclusion

Phase 5 establishes a **stable and extensible architecture** ready for production evolution.