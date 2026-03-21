# SCAVIUM Wallet — Deep Architecture

## 🧭 Context

This document describes the **internal architectural model after Phase 5 (up to 5.4)**.

It includes design decisions and trade-offs made across:

- Phase 2 — Wallet core
- Phase 3 — Blockchain integration
- Phase 5 — Stability and lifecycle

---

## 🧠 Core Design Principles

- separation of concerns
- predictable state management
- UI decoupled from business logic
- minimal side effects

---

## 🧱 Layer Responsibilities

### Presentation

- Flutter widgets
- no business logic
- reacts to state

---

### Application

- controllers (Riverpod)
- orchestrates logic
- triggers RPC calls

---

### Domain

- pure models
- no external dependencies

---

### Data

- repositories
- RPC services
- storage interaction

---

## 🔗 Blockchain Layer

Centralized in:

scavium_rpc_service.dart

Responsibilities:

- RPC communication
- gas estimation
- transaction execution
- receipt retrieval

---

## 🔄 State Invalidation Strategy

Instead of manual state mutation:

ref.invalidate(provider)

### Benefits

- guarantees fresh data
- avoids stale state
- simplifies logic

---

## 🔒 Lifecycle Model

Managed via:

- AppLifecycleGuard
- appLockStateController

### Behavior

- lock on background
- unlock restores state
- router reacts automatically

---

## ⚖️ Trade-offs

### Pros

- clean separation
- scalable architecture
- easy debugging

### Cons

- more boilerplate
- requires strict discipline
- higher initial complexity

---

## 📊 Result

A robust architecture that supports:

- real-time updates
- secure wallet behavior
- extensibility for future features

---

## 🚀 Conclusion

The system is designed for **long-term evolution and production stability**.