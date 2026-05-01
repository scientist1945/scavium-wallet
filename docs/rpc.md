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
---

## 🛡️ Phase 8.5 RPC Diagnostics Safety

Phase 8.5 keeps RPC diagnostics observable without making diagnostics invasive.

The RPC diagnostics surface may show useful non-sensitive state such as:

- active endpoint context;
- chain and block information when available;
- cooldown state;
- connectivity or availability status;
- safe, actionable failure copy.

It must not show raw exception dumps or sensitive wallet material. Diagnostics remain local to the application and are not telemetry, analytics, remote reporting, or support upload.

This preserves the original RPC goal: help operators and users understand network/RPC health while keeping wallet custody and sensitive data isolated.
