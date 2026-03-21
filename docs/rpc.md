# SCAVIUM Wallet — RPC Layer

## 🧭 Context

This document describes the RPC layer as implemented up to Phase 5.4.

(Phase 5.5 introduces HTTPS and multi-RPC improvements.)

---

## 🔗 Current Implementation

- JSON-RPC over HTTP
- Single endpoint configuration
- Direct communication with Besu node

---

## 🧱 Architecture

Wallet → HTTP → Besu

---

## 📡 Methods Used

- eth_chainId  
- eth_blockNumber  
- eth_gasPrice  
- eth_getBalance  
- eth_sendRawTransaction  
- eth_getTransactionReceipt  

---

## ⚠️ Limitations

- no failover
- no load balancing
- no TLS (pre-5.5)

---

## 🚀 Conclusion

The RPC layer is functional and stable, forming the base for Phase 5.5 improvements.