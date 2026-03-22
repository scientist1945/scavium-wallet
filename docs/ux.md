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

## 📊 RPC Transparency

User can see:

- active node
- failover events
- diagnostics

---

## 🧠 Philosophy

The wallet should:

> make blockchain complexity invisible, without hiding critical information