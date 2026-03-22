# SCAVIUM Wallet

## 🧭 Overview

SCAVIUM Wallet is a self-custody, EVM-compatible wallet designed for the SCAVIUM network.

It provides a secure, resilient and production-ready environment for interacting with blockchain assets, built with a modular architecture and a strong focus on reliability, release safety and user experience.

---

## 🚀 Current Status

The project has completed:

- Phase 1 → Core setup
- Phase 2 → Wallet creation/import
- Phase 3 → Blockchain integration
- Phase 4 → Transaction flows
- Phase 5 → Production readiness (RPC, UX, lifecycle)
- Phase 6 → Packaging, branding, release, and store deployment

The project is now in:

- Phase 7 → Stabilization, bug fixing, and release candidate hardening

Current state:

- Wallet distributed through Google Play Internal Testing
- Android release candidate in active tester validation
- Production-grade RPC layer (multi-endpoint + failover)
- Stable lock-aware navigation and lifecycle protection
- Local transaction persistence
- Screenshot protection on Android via native bridge
- Android biometric unlock regression addressed in Phase 7.1
- Wallet persistence and restore-state hardening completed in Phase 7.2
- In-app splash/logo branding corrected in Phase 7.3

---

## 🧱 Core Features

- Wallet creation and import (mnemonic / private key)
- Native token transfers
- ERC-20 token transfers
- Local transaction history with receipt tracking
- Auto-refresh system
- Lifecycle-based lock security
- RPC failover and diagnostics
- Optional biometric unlock
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
- Minimal-risk stabilization during release phases

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
- Android screenshot protection
- Optional biometric unlock
- Controlled transaction execution flow
- Defensive wallet persistence validation

---

## 🎨 Branding

The project includes packaged branding assets for icons, logos, splash integration, and visual identity consistency.

From Phase 7.3 onward, the in-app shared logo widget also uses the official SCAVIUM asset, aligning splash and shared UI branding with the packaged identity.

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
- phase1_scavium_wallet.md
- phase2_scavium_wallet.md
- phase3_scavium_wallet.md
- phase4_scavium_wallet.md
- phase5_scavium_wallet.md
- phase6_scavium_wallet.md
- phase7_scavium_wallet.md

---

## 🚧 Current Stabilization Focus

Phase 7 focuses on:

- Android regressions
- runtime issues reported by testers
- release candidate hardening
- stability improvements without architecture redesign

Phase 7 currently includes:

- Phase 7.1 → Android biometric unlock stabilization
- Phase 7.2 → wallet persistence hardening and restore-state stabilization
- Phase 7.3 → in-app branding correction for splash and shared logo usage

---

## 🚧 Limitations

- No remote transaction history (indexer not integrated yet)
- No multi-account support yet
- No advanced RPC metrics
- Secure local storage is not a replacement for user-managed recovery backup
- Uninstall/reinstall is not a supported wallet recovery strategy

---

## 🧱 Next Step

After Phase 7.3, stabilization continues with:

- additional runtime fixes reported by testers
- repeated validation across Android devices
- release candidate refinement
- preparation of the next release candidate

---

## 🚀 Conclusion

SCAVIUM Wallet is now a:

> packaged, store-distributed and stabilization-focused wallet with a solid architecture, hardened local persistence behavior, corrected in-app branding consistency, and a controlled path toward broader release readiness