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
## Phase 8.1.5 — Add Account UX

The account switcher now provides a minimal account-addition entry point. The UX remains intentionally small and reversible:

- users can add a derived account when the wallet has a mnemonic;
- users can import an additional private-key account;
- unsupported derived-account creation is disabled for private-key-only wallets;
- successful account addition activates the new account immediately;
- no deletion, rename, or advanced account management UX is introduced yet.

---

## 📊 Phase 8.2 Asset Surface UX

Phase 8.2 improves the existing asset surface without introducing the later Phase 8.4 navigation shell.

Implemented UX improvements:

- portfolio summary card above the asset list;
- active account context display when available;
- clearer native versus ERC-20 asset distinction;
- improved spacing and constrained width for larger screens;
- safe loading, empty, and error states;
- explicit token-add flow with visible validation and metadata feedback;
- local token removal warning that clarifies funds are not affected.

The UX remains intentionally bounded.

The asset screen is more mature, but it does not yet become a full portfolio dashboard with valuation, sorting, grouping, token discovery, or multi-chain views.

Those capabilities remain future product work beyond Phase 8.2.

---

## 🧾 Phase 8.3 Activity and Signing UX

Phase 8.3 improves transaction/activity readability and introduces explicit signing UX without adding the later Phase 8.4 navigation shell.

Implemented activity UX improvements:

- history copy clarifies that the view shows locally tracked outgoing transactions;
- refresh remains explicit and user-controlled;
- transaction rows open a first-party detail view;
- transaction detail explains pending, confirmed, and failed receipt states;
- explorer opening is explicit rather than implicit;
- status and transaction-kind filters are visible in the history surface;
- filtered-empty state is distinct from no-history state;
- error copy clarifies that existing local entries are not modified by a load/receipt failure.

Implemented signing UX improvements:

- signing is presented as separate from sending;
- the active account is visible before signing;
- users choose between personal-message and challenge signing modes;
- message/challenge input is validated before confirmation;
- the confirmation dialog previews mode, account, and message;
- cancellation produces no wallet-state mutation;
- successful signing displays signature metadata and copy feedback.

The UX remains intentionally bounded.

The activity surface is not a full explorer, and signing is not a transaction workflow. Those distinctions must remain visible in later navigation or product-surface phases.
---

## 🧭 Phase 8.4 Navigation Shell and Product Surface UX

Phase 8.4 improves the wallet from a mostly one-page product surface into a shell-based product surface while preserving explicit workflows.

Implemented navigation UX:

- compact layouts use bottom navigation for primary destinations;
- wide layouts use a navigation rail for primary destinations;
- primary destinations are Home, Assets, Activity, and Settings;
- action/detail flows remain explicit routes rather than hidden shell behavior.

Implemented product-surface UX:

- Home acts as a dashboard summary instead of the only product map;
- Assets remains the detailed asset-management surface;
- Activity remains the full local outgoing-history surface;
- Accounts provides dedicated placement for active-account controls;
- Settings groups security/recovery, signing, diagnostics, danger-zone actions, and about information.

Safety UX preserved by this phase:

- signing remains explicit and confirmation-oriented;
- reset remains confirmation-gated;
- backup export remains a deliberate settings action;
- RPC diagnostics remains an explicit diagnostic route;
- shell navigation does not imply background wallet mutation.

The UX remains intentionally bounded. Phase 8.4 does not add dApp connectivity, automatic token discovery, external activity indexing, account deletion, account label editing, or new backup semantics.


---

## 🛡️ Phase 8.5 Security, Reliability, and Diagnostics UX

Phase 8.5 improves safety-oriented UX on sensitive surfaces while keeping user actions explicit. The UX goal is not to hide risk. The goal is to remove misleading or overly technical failure text, reinforce self-custody responsibility, and make sensitive actions easier to understand before the user confirms them.

Implemented UX improvements:

- diagnostics errors are actionable and safe rather than raw exception dumps;
- diagnostics still preserve useful non-sensitive context when it helps the user understand RPC/network state;
- signing explains that signatures are not transactions, do not move funds, and are not receipts;
- signing mode warnings distinguish personal messages from challenge messages;
- confirmation copy reminds users to approve only recognized messages/challenges;
- cancellation remains visible and non-destructive;
- backup export and restore screens explain password responsibility, file privacy, and safe failure behavior;
- restore/export failures avoid exposing raw backup, mnemonic, password, ciphertext, private-key, address, or signature material;
- invalid states fail safely with retry-oriented copy where appropriate;
- transaction-history refresh failures do not imply that existing local history was deleted or overwritten.

The UX deliberately stays conservative. Phase 8.5 does not create automated signing prompts, dApp prompts, WalletConnect prompts, hidden challenge ingestion, or telemetry consent surfaces. Sensitive actions remain user-initiated, visible, confirmable, and cancellable.

The Phase 8.5 UX remains intentionally bounded. It does not introduce telemetry, dApp prompts, WalletConnect, background signing, automatic challenge ingestion, or hidden shell-owned security behavior.


---

## 🎨 Phase 9 Application Identity and Visual Theme UX

Phase 9 is open to make the wallet feel more coherent, less saturated, and more product-like without redesigning the stabilized Phase 8 surfaces. Phase 9.0 locks this UX direction before token/theme implementation begins, and Phase 9.1 completes the first Settings/About identity improvement by replacing stale version copy with runtime metadata.

The UX direction is based on the SCAVIUM Design Token System:

- brand colors remain recognizable but should be used with restraint;
- large backgrounds and surfaces should be calmer than high-signal actions;
- semantic colors must be distinct from brand colors;
- cards, navigation, inputs, dialogs, snackbars, and list tiles should share a consistent hierarchy;
- light and dark modes should feel like the same product, not two unrelated skins;
- Settings/About should clearly expose application version and appearance controls.

The desired user outcome is a smoother visual experience: less noise, clearer hierarchy, better contrast, and more predictable appearance across web, desktop, Android, and future supported platforms. Phase 9.1 proves the first identity slice through concrete Settings/About implementation, while later subphases must prove the broader token, theme, and appearance-selection behavior.

---

## 🎨 Phase 9 Visual Token UX

Phase 9 moves visual maturity from a dark-only palette toward a controlled SCAVIUM token system. Phase 9.3 is the foundation step: it normalizes the vocabulary for brand, background, surface, border, text, semantic, interaction, shape, spacing, elevation, and typography before user-facing light/dark selection is introduced.

Phase 9.3 closes the baseline UX contract by making the token vocabulary semantic rather than raw-value or component-specific. This means later visual polish should describe intent such as background, surface, text hierarchy, semantic state, action, radius, spacing, and elevation instead of scattering isolated color or padding fixes across screens.

The UX intent is not to redesign the wallet in one pass. The intent is to make the existing SCAVIUM visual language calmer, more consistent, and easier to apply across mobile, desktop, and web surfaces without scattering direct color decisions through screens. The implemented shared-widget adoption proves this through cards, buttons, section titles, snackbars, and confirmation dialogs while leaving feature flows unchanged.

After 9.3, the application remains dark-only at runtime. Light/dark parity, persisted theme selection, and Settings appearance controls belong to later Phase 9 subphases.
