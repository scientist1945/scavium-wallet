# SCAVIUM Wallet — Phase 5 Documentation

## 🧭 Overview

Phase 5 represents the transition from a functional prototype to a **robust, production-ready wallet**.

During this phase, the following were consolidated:

- Native and ERC-20 transaction support
- Stable auto-refresh system
- Full lifecycle + lock integration
- Consistent UI/UX
- Resilient RPC infrastructure (multi-endpoint with failover)

---

## 🏗️ Architecture Overview

The application follows a modular architecture based on:

- Flutter + Dart
- Riverpod (AsyncNotifier)
- Web3dart
- GoRouter (reactive navigation)
- Feature-based structure

### Key structure

features/
  blockchain/
  wallet/
  assets/
  home/
  lock/
  settings/

---

## 🔗 RPC System (core of Phase 5)

### 5.5 — RPC Layer (full evolution)

#### ✔ HTTPS Migration
- nginx reverse proxy
- TLS certificates (Let's Encrypt)
- Removal of plain HTTP

#### ✔ Multi-RPC Support
- Multiple RPC endpoints
- Configured via `AppConfig.rpcUrls`

#### ✔ Automatic Failover
- READ operations rotate across nodes
- WRITE operations stay on active node

#### ✔ Node Cooldown
- Failed nodes enter cooldown (e.g., 60s)
- Persisted in local storage

#### ✔ Persistence
- Active node stored
- Cooldown state persisted

#### ✔ Observability
- RPC state exposed via controller
- UI visibility (Home + Diagnostics)

---

## 🔁 Auto-refresh System

### Implementation

home_auto_refresh_controller.dart

### Behavior

- Periodic timer
- Invalidates:
  - network info
  - assets
  - transaction history
  - rpc status

### Conditions

- Disabled when app is locked
- Properly resumes after unlock

---

## 🔒 Lifecycle & Lock

### Integration

- AppLifecycleGuard
- appLockStateController

### Behavior

- Automatic lock when:
  - app goes to background
  - app becomes inactive

- Router reacts automatically

---

## 💸 Transaction Flow

### Full flow

1. Input validation  
2. Preview generation  
3. User confirmation  
4. Transaction execution  
5. History persistence  
6. State refresh  

---

### Preview

native_send_preview_controller.dart

Includes:

- estimated gas
- fee
- total cost

---

### Confirmation

native_send_confirm_dialog.dart

---

### Execution

send_transaction_controller.dart

Responsibilities:

- BigInt amount parsing
- RPC execution
- error handling
- history persistence
- post-send refresh

---

## 🧾 Transaction History

### Current state (Phase 5)

- Local-only history
- Based on:
  - sent transactions
  - receipt polling

### Refresh logic

tx_history_controller.dart

- updates pending → confirmed/failed
- avoids unnecessary RPC calls

---

## 🎨 UI / UX (Phase 5.4)

### Improvements

- consistent visual feedback
- clear loading states
- secure confirmations
- smooth navigation
- modular layout

---

## 📊 RPC Observability (5.5.6)

Displayed in Home:

- active RPC node
- active RPC URL
- failover status
- previously failed node

Access to:

rpc_diagnostics_screen.dart

---

## ⚙️ Final Functional State

The wallet supports:

- wallet creation/import
- native transfers
- ERC-20 transfers
- stable auto-refresh
- secure locking
- local transaction history
- resilient RPC infrastructure

---

## ❗ Current Limitations

- no remote transaction history
- no indexer integration yet
- no advanced RPC metrics
- no multi-account support (future phase)

---

## 🧱 Foundation for Future Phases

Phase 5 establishes the base for:

- Phase 6 (packaging / release)
- DEX integration
- transaction indexing
- scalability improvements

---

## 🚀 Conclusion

Phase 5 transforms SCAVIUM Wallet into:

> a stable, production-ready wallet with a solid and extensible architecture