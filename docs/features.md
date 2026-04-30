# SCAVIUM Wallet — Features

## 🧭 Overview

This document lists implemented features up to the completed stabilization phase and records the Phase 8 expansion direction.

Phase 7 did not add new unrelated product scope. It hardened and validated the existing product while adding essential safety and operational capabilities where needed.

Phase 8 begins controlled product expansion from that stabilized baseline. Planned capabilities are documented separately until implemented.

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

## 🧭 Phase 8 Expansion Direction

Phase 8 introduces planned product expansion areas without treating them as implemented until their subphases are completed.

Planned expansion areas include:

- multi-account / multiple wallet support
- account switcher and account metadata
- richer asset and portfolio surfaces
- account-aware asset organization
- transaction and activity maturity
- message signing with explicit preview and confirmation
- multi-surface navigation for desktop, web, and mobile
- additional security, reliability, and diagnostics maturity

The current Phase 8.0 state is documentation-only. Runtime feature implementation begins in later Phase 8 subphases.

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

The wallet supports all core operations required for a functional EVM wallet and has completed a stabilization stage focused on release quality, operational consistency, and safer real-world recovery behavior.

Phase 8 builds on that baseline to expand the product surface in controlled, documented, and incrementally validated subphases.
---

## 👛 Phase 8.1 Planned Account Expansion

Phase 8.1 defines the controlled transition from the current single-account wallet into a future multi-account wallet model.

The current implemented feature remains:

- one active wallet account
- secure wallet creation/import
- encrypted backup and restore compatibility

The planned account expansion introduces, in later implementation subphases:

- multiple wallet accounts
- active account selection
- default account semantics
- account labels or aliases
- account-aware assets and activity
- backup payload evolution with v1 restore compatibility

Until implementation is completed, this document treats multi-account behavior as planned Phase 8 capability rather than implemented runtime behavior.

