# SCAVIUM Wallet — Phase 3 Documentation

## 🧭 Overview

Phase 3 integrates the wallet with the **blockchain layer**, enabling:

- RPC communication
- balance retrieval
- network info
- native transactions

---

## 🔗 Blockchain Integration

### Service

scavium_rpc_service.dart

Handles:

- JSON-RPC calls
- gas price retrieval
- transaction sending

---

## 📊 Network Info

### network_info_controller.dart

Provides:

- chainId
- latest block
- gas price

---

## 💰 Balance

### native_balance_controller.dart

Retrieves:

- account balance
- formatted values

---

## 💸 Native Transactions

### send_transaction_controller.dart

Responsibilities:

- validation
- transaction creation
- RPC execution

---

## ⚠️ Initial Limitations

- no preview step
- no fee estimation
- basic error handling

---

## 📊 Result

Phase 3 delivers:

- live blockchain connection
- real balance display
- native transaction capability

---

## 🚀 Conclusion

Phase 3 connects the wallet to the **SCAVIUM network**.