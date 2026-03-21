# SCAVIUM Wallet — RPC System

## 🧭 Overview

The RPC system is designed to be **resilient, observable and production-ready**.

---

## 🔗 Multi-RPC

Configured in:

AppConfig.rpcUrls

Supports multiple endpoints.

---

## 🔁 Failover

- READ operations:
  - rotate across nodes
- WRITE operations:
  - use active node only

---

## ⏱️ Cooldown

- Failed nodes enter cooldown (e.g., 60 seconds)
- Stored in local storage
- Prevents repeated failures

---

## 💾 Persistence

- active RPC index
- cooldown state

---

## 📊 Observability

Exposed via:

rpc_status_controller

Displayed in:

- Home screen
- RPC diagnostics screen

---

## 🧠 Error Handling

Retryable errors:

- network issues
- timeouts
- TLS errors
- malformed responses

Non-retryable:

- invalid arguments
- contract errors

---

## 🎯 Result

The RPC system ensures:

- high availability
- graceful degradation
- user transparency