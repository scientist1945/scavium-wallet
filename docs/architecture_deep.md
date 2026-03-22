# SCAVIUM Wallet — Deep Architecture

## 🧠 Overview

This document describes the internal flow of data and control across the system.

It also reflects the stabilization philosophy adopted once the wallet entered release candidate distribution.

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
- lock_controller

Responsibilities:

- validate inputs
- call services
- manage loading/error states
- update UI

Controllers remain intentionally stable during stabilization phases.

Bug fixes should prefer service-layer or platform-layer corrections whenever possible before any controller redesign is considered.

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

Other relevant services include:

- secure storage service
- biometric auth service
- screenshot protection service

These services act as the preferred adaptation surface for release-stage fixes because they isolate runtime and platform details from the UI.

From Phase 7.2 onward, the secure storage service also includes verification behavior for critical persistence paths so that sensitive wallet state is not assumed valid only because a write call was issued.

---

## 📦 Domain Models

Located in:

features/*/domain/

Examples:

- NetworkInfo
- TokenInfo
- TransactionSendResult
- NativeSendPreview

Domain models should remain stable during Phase 7 unless a bug strictly requires correction.

---

## 🧾 Storage Layer

Uses:

- secure storage (keys)
- local storage (state, rpc, flags)

This separation remains unchanged during stabilization.

Sensitive wallet material continues to belong to secure storage.

Non-sensitive runtime and UI state continues to belong to local storage.

Phase 7.2 hardens this layer by ensuring that startup and availability logic validate real secure state rather than relying only on local flags.

---

## 🔒 Lock and Unlock Path

The security flow is structured as:

- lifecycle event or route guard detects lock condition
- lock controller takes ownership of unlock state
- lock screen presents unlock options
- PIN and biometric services resolve authentication outcome
- router restores the expected protected flow

This lock-aware path was preserved during Phase 7.1.

The Android biometric regression was corrected at the Android activity integration layer instead of changing controller ownership or router behavior.

---

## 👛 Wallet Availability Path

The wallet availability path is now more defensive.

The startup logic does not rely only on a wallet-created flag.

Instead, the startup path loads the wallet profile from real persisted state and only considers the wallet valid if all required secret and metadata values are present and consistent.

This avoids false-positive wallet availability under partial restore or failed persistence conditions.

---

## 🎨 Shared Branding Path

The app uses a shared branding widget to render the project identity in visual entry points such as the in-app splash and other reusable UI contexts.

Phase 7.3 corrected this path by replacing a code-drawn placeholder-style letter with the official square SCAVIUM asset already declared in the project.

This was intentionally handled at the shared widget layer so that all dependent views inherit the branding correction without separate per-screen changes.

---

## 🔁 Reactive Updates

Controllers invalidate each other when needed.

Example:

- send → refresh assets + history
- home → refresh network + rpc + balances
- unlock → restore protected views without rebuilding the architecture

---

## 🧠 Key Design Decision

All blockchain interaction is centralized through a **single RPC service**, ensuring:

- consistency
- observability
- control over failures

Additionally, all stabilization work from Phase 7 onward follows this same philosophy:

- preserve architecture
- isolate fixes
- minimize regression risk