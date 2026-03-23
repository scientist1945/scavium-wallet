# SCAVIUM Wallet — Features

## 🧭 Overview

This document lists all implemented features up to the current stabilization phase.

Phase 7 does not add new unrelated product scope. It hardens and validates the existing product while adding essential safety and operational capabilities where needed.

---

## 🔐 Wallet

- Create wallet
- Import wallet (mnemonic / private key)
- Secure storage
- Restore from encrypted backup

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
- Encrypted backup export

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

## 🛠️ Release Tooling

- Dart-native build tool
- Automatic build-number increment
- Semantic version override support
- Multiplatform build orchestration
- Windows MSIX packaging support

---

## ♻️ Recovery Features

The wallet now supports three explicit recovery paths:

- mnemonic
- private key
- encrypted backup file

The encrypted backup flow includes:

- password-protected backup generation
- external backup file export
- desktop save dialog support
- mobile share/export flow
- restore from backup during wallet entry

---

## 🛠️ Stabilization Notes

Phase 7.1 did not introduce a new feature.

It restored Android biometric unlock reliability by fixing a platform integration regression in the existing biometric flow.

Phase 7.2 also did not introduce a new feature.

It hardened wallet persistence behavior, startup validation, and backup gating within the existing wallet model.

Phase 7.3 also did not introduce a new feature.

It corrected branding consistency by replacing a placeholder-style shared logo implementation with the official SCAVIUM asset.

Phase 7.4 also did not introduce a new end-user feature.

It hardened build and versioning operations by introducing a project-native release tool.

Phase 7.5 introduced a user-facing safety feature.

It added encrypted backup export and restore, giving users a practical recovery option beyond local storage and manual mnemonic handling.

---

## 🎯 Summary

The wallet supports all core operations required for a functional EVM wallet and is now in a stabilization stage focused on release quality, operational consistency, and safer real-world recovery behavior.