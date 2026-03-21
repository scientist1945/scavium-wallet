# SCAVIUM Wallet — Deep Architecture

## 🧠 Overview

This document describes the internal flow of data and control across the system.

---

## 🔄 Data Flow

UI → Controller → Service → RPC → Blockchain  
                                 ↓  
                             Response  
                                 ↓  
                        Controller → UI

---

## 🧩 Controllers

Controllers are the core orchestrators.

Examples:

- send_transaction_controller
- native_send_preview_controller
- assets_controller
- rpc_status_controller

Responsibilities:

- validate inputs
- call services
- manage loading/error states
- update UI

---

## 🔗 Service Layer

Main service:

scavium_rpc_service.dart

Handles:

- RPC execution
- retry logic
- failover
- cooldown
- persistence

---

## 📦 Domain Models

Located in:

features/*/domain/

Examples:

- NetworkInfo
- TokenInfo
- TransactionSendResult
- NativeSendPreview

---

## 🧾 Storage Layer

Uses:

- secure storage (keys)
- local storage (state, rpc, flags)

---

## 🔁 Reactive Updates

Controllers invalidate each other when needed:

Example:

- send → refresh assets + history
- home → refresh network + rpc + balances

---

## 🧠 Key Design Decision

All blockchain interaction is centralized through a **single RPC service**, ensuring:

- consistency
- observability
- control over failures