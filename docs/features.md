# SCAVIUM Wallet — Features

## 🧭 Overview

This document lists all implemented features up to the current stabilization phase.

Phase 7 does not add new feature scope. It hardens and validates the existing product.

---

## 🔐 Wallet

- Create wallet
- Import wallet (mnemonic / private key)
- Secure storage

---

## 💸 Transactions

- Native transfers
- ERC-20 transfers
- Gas estimation
- Transaction preview
- Confirmation dialog

---

## 🧾 History

- Local transaction history
- Receipt tracking
- Status updates (pending → confirmed)

---

## 🔁 Auto-refresh

- Periodic refresh
- Lifecycle-aware
- Updates balances, network, history

---

## 🔒 Security

- Automatic lock on background
- Session protection
- Secure key handling
- Optional biometric unlock
- Android screenshot protection

---

## 🔗 RPC

- Multi-endpoint support
- Failover
- Cooldown
- Diagnostics UI

---

## 🎨 UI

- Modular layout
- Consistent feedback
- Loading states
- Navigation structure
- Shared logo widget using official SCAVIUM asset

---

## 📊 Diagnostics

- RPC status visibility
- Failover tracking
- Node information

---

## 🛠️ Stabilization Notes

Phase 7.1 did not introduce a new feature.

It restored Android biometric unlock reliability by fixing a platform integration regression in the existing biometric flow.

Phase 7.2 also did not introduce a new feature.

It hardened wallet persistence behavior, startup validation, and backup gating within the existing wallet model.

Phase 7.3 also did not introduce a new feature.

It corrected branding consistency by replacing a placeholder-style shared logo implementation with the official SCAVIUM asset.

---

## 🎯 Summary

The wallet supports all core operations required for a functional EVM wallet and is now in a stabilization stage focused on release quality rather than scope expansion.