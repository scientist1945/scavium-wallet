# SCAVIUM Wallet — Security

## 🧭 Overview

Security is a core aspect of SCAVIUM Wallet.

The wallet follows a self-custody model and uses layered protections to reduce accidental exposure and unauthorized access.

---

## 🔐 Key Principles

- Self-custody
- No private data leaves the device
- Minimal exposure of sensitive information
- Platform protections should complement application protections

---

## 🔑 Key Management

- Stored in secure storage
- Never logged
- Never transmitted externally

Phase 7.2 strengthened key-management safety by adding verification behavior to critical persistence paths.

This does not change the custody model.

It reduces the chance of assuming a secret was stored correctly when it was not.

---

## 🔒 Lock System

- Triggered by lifecycle events
- Prevents unauthorized access
- Integrated with navigation
- Supports biometric unlock as an optional access path

---

## 🔐 Biometric Security

Biometrics are used as a convenience and protection layer for local unlock flows.

This mechanism depends on correct native platform integration.

In Phase 7.1, Android biometric support was stabilized by correcting the required Android activity integration for the existing biometric flow.

This was a platform hardening fix, not a security model redesign.

---

## 🛡️ Screen Protection

On Android, screenshot protection is enforced through native window security flags exposed through a Flutter `MethodChannel`.

This reduces the risk of casual screen capture of sensitive wallet content.

---

## 👛 Wallet Availability Safety

From Phase 7.2 onward, wallet availability is validated against real secure persisted state rather than being inferred only from local non-sensitive flags.

This reduces the chance of entering the wallet in an inconsistent runtime state.

It is a correctness and safety improvement, not a new recovery mechanism.

---

## 🎨 Visual Identity Integrity

While branding is not a cryptographic control, consistent identity presentation still matters for trust and product integrity.

Phase 7.3 improved this aspect by ensuring the shared in-app logo widget uses the official SCAVIUM asset rather than a placeholder-style letter composition.

This does not change the security model, but it improves identity consistency in user-facing flows.

---

## 💸 Transaction Safety

- Preview before execution
- Explicit confirmation
- Controlled RPC execution

---

## 🔗 RPC Security

- HTTPS only
- Controlled failover
- Error normalization

---

## ⚠️ Current Limitations

- No hardware wallet support
- No multi-device sync
- No advanced threat detection
- Secure storage is not a substitute for a user-managed recovery backup
- Uninstall/reinstall is not a supported recovery strategy

---

## 🎯 Goal

Provide a secure environment for managing digital assets while maintaining usability and release-stage stability.