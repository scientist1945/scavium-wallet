# SCAVIUM Wallet — UX Principles

## 🎯 Goals

- clarity
- safety
- predictability
- responsiveness

---

## 💸 Transaction UX

- preview before sending
- clear fee display
- confirmation dialog

---

## 🔁 Feedback

- loading indicators
- error messages
- success confirmation

---

## 🔒 Security UX

- automatic lock
- no sensitive data exposure
- clear warnings
- support secure and low-friction unlock methods

---

## 🔐 Unlock UX

The unlock experience must remain:

- reliable
- fast
- predictable
- consistent with device capabilities

Biometric unlock should behave as an optional enhancement over the lock flow, not as a source of instability.

Phase 7.1 specifically focused on restoring Android biometric reliability within the existing unlock experience.

---

## 👛 Wallet Safety UX

The wallet flow must not imply successful persistence when the required secure state is missing or inconsistent.

For that reason, Phase 7.2 hardened:

- backup confirmation gating
- startup wallet validation
- persistence correctness assumptions

The result is a more defensive UX that prefers safe fallback over silent inconsistency.

---

## 🎨 Branding UX

Visible branding should remain consistent between packaged assets and runtime UI.

For that reason, Phase 7.3 corrected the shared in-app logo widget so that splash and related views display the official SCAVIUM asset instead of a placeholder-style letter.

This improves the first impression and overall visual coherence of the wallet experience.

---

## 🛠️ Release Workflow UX

Although release tooling is not end-user UX, it directly affects the consistency of tester-facing builds.

Phase 7.4 improved this layer by standardizing version handling and build execution through a single Dart-native tool.

This reduces release friction and makes RC iteration more predictable for internal distribution.

---

## ♻️ Backup and Recovery UX

Phase 7.5 introduced a practical recovery UX built around explicit user responsibility.

Key UX principles in this area are:

- never imply that uninstall/reinstall alone is recovery
- clearly explain that both file and password are required
- separate export and restore according to user context
- use platform-appropriate file interaction on desktop and mobile
- keep restore available before wallet session entry
- keep export available once the wallet is already active

This results in:

- clearer expectations
- lower recovery confusion
- less accidental overconfidence in device-local persistence
- better alignment with self-custody reality

---

## 📊 RPC Transparency

User can see:

- active node
- failover events
- diagnostics

---

## 🧠 Philosophy

The wallet should:

> make blockchain complexity invisible, without hiding critical information