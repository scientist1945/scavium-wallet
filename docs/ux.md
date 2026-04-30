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

## 🧭 Phase 8 Product Surface UX

Phase 8 expands the wallet from a stabilized product surface toward a scalable multi-surface UX.

The UX direction includes:

- preserving the existing wallet usability baseline
- avoiding one-page overload as features grow
- introducing clearer screen segmentation
- supporting desktop and web sidebar-oriented navigation where appropriate
- supporting mobile drawer or bottom navigation where appropriate
- keeping sensitive actions explicit and reviewable

Planned Phase 8 surfaces include:

- Home / Dashboard
- Wallet / Accounts
- Assets
- Activity
- Settings

Message signing UX must remain safety-oriented and must include message preview, explicit confirmation, cancellation, and clear result handling.

---

## 📊 RPC Transparency

User can see:

- active node
- failover events
- diagnostics

---


---

## 👛 Phase 8.1.4 Account Switcher UX

Phase 8.1.4 introduces the first account-aware UI element without changing the overall navigation model.

UX rules:

- the account switcher must be visible but not disruptive
- single-account wallets must remain understandable and stable
- switching must only apply to already-known accounts
- account creation, deletion, and editing must not be implied by the switcher
- sensitive account expansion flows remain deferred until their dedicated subphases

The home surface now separates balance display from active-account selection, reducing future pressure on the one-page wallet layout while preserving the current Phase 7 usability baseline.

## 🧠 Philosophy

The wallet should:

> make blockchain complexity invisible, without hiding critical information

Phase 8 extends this philosophy by allowing more product capability only when navigation, confirmation, and safety expectations remain clear.