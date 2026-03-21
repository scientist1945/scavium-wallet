# SCAVIUM Wallet

## 🧭 Overview

SCAVIUM Wallet is a self-custody, EVM-compatible wallet designed for the SCAVIUM network.

It provides a secure, resilient and production-ready environment for interacting with blockchain assets, built with a modular architecture and a strong focus on reliability and user experience.

---

## 🚀 Current Status

The project has completed:

- Phase 1 → Core setup
- Phase 2 → Wallet creation/import
- Phase 3 → Blockchain integration
- Phase 4 → Transaction flows
- Phase 5 → Production readiness (RPC, UX, lifecycle)

Current state:

- Fully functional wallet
- Production-grade RPC layer (multi-endpoint + failover)
- Stable auto-refresh and lifecycle handling
- Secure transaction flow (native + ERC-20)
- Clean and modular UI

---

## 🧱 Core Features

- Wallet creation and import (mnemonic / private key)
- Native token transfers
- ERC-20 token transfers
- Local transaction history with receipt tracking
- Auto-refresh system
- Lifecycle-based lock security
- RPC failover and diagnostics
- Modular feature-based architecture

---

## 🏗️ Architecture

The application is built using:

- Flutter + Dart
- Riverpod (AsyncNotifier)
- Web3dart
- GoRouter (reactive navigation)

Architecture principles:

- Feature-based modularization
- Clear separation (UI / Application / Domain / Data)
- Centralized RPC abstraction
- Reactive and predictable state management

---

## 🔗 RPC System

The wallet uses a resilient RPC system with:

- Multiple endpoints
- Automatic failover
- Node cooldown
- Persistent state
- UI observability

This ensures high availability and consistent user experience even under network instability.

---

## 🔒 Security

- Self-custody wallet (no keys leave the device)
- Secure storage for sensitive data
- Lifecycle-based automatic locking
- Controlled transaction execution flow

---

## 📘 Documentation

Full documentation is available in the `docs/` folder:

- architecture.md
- architecture_deep.md
- flows.md
- rpc.md
- ux.md
- decisions.md
- development.md
- features.md
- release.md
- security.md
- phase5_scavium_wallet.md

---

## 🚧 Limitations

- No remote transaction history (indexer not integrated yet)
- No multi-account support yet
- No advanced RPC metrics

---

## 🧱 Next Step

Phase 6 will focus on:

- Packaging
- Branding
- Release signing
- App store deployment

---

## 🚀 Conclusion

SCAVIUM Wallet is now a:

> stable, production-ready wallet with a solid architecture and a clear path toward ecosystem integration