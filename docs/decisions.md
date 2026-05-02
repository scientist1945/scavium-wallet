# SCAVIUM Wallet — Technical Decisions

## 🧠 Key Decisions

### 1. Riverpod over other state managers
Chosen for:

- predictability
- async support
- scalability

---

### 2. Feature-based architecture
Allows:

- modular development
- clear boundaries
- easier maintenance

---

### 3. Single RPC abstraction
All blockchain calls go through:

scavium_rpc_service

Benefits:

- centralized control
- easier debugging
- failover support

---

### 4. Read vs Write separation

- READ: safe to retry
- WRITE: must be deterministic

---

### 5. Local transaction history

Chosen for:

- independence from external indexers
- faster UI feedback

---

### 6. Lifecycle-driven security

Lock based on app state:

- prevents exposure
- no reliance on timers only

---

### 7. Secure local key custody

Sensitive wallet material remains device-local and is stored through secure storage.

This preserves the self-custody model and avoids external key handling.

---

### 8. Release-stage bug fixing without redesign

From Phase 7 onward, the project adopts a strict stabilization rule:

- do not redesign architecture
- do not rename existing structures
- do not introduce unrelated new scope
- prefer the smallest safe corrective patch

This decision protects release candidate stability and reduces regression risk.

---

### 9. Android biometric fix at platform layer

The Android biometric regression of Phase 7.1 was resolved by correcting the Android activity integration (`FlutterFragmentActivity`) instead of altering lock controllers, navigation, or feature ownership.

Benefits:

- minimal surface change
- lower regression risk
- architecture preserved
- safer release candidate rollout

---

### 10. Defensive wallet availability validation

Phase 7.2 established that wallet availability must not be inferred only from local flags.

The application must validate real secure wallet state before assuming that a wallet exists and can be opened safely.

Benefits:

- avoids false-positive wallet state
- reduces startup inconsistency risk
- keeps storage architecture intact
- improves release candidate safety

---

### 11. Disable Android app backup to reduce partial restore risk

Phase 7.2 also introduced explicit disabling of Android application backup to reduce the risk of partially restored non-sensitive state without matching secure wallet secrets.

Benefits:

- lower restore inconsistency risk
- simpler and safer runtime assumptions
- no architectural redesign required

---

### 12. Shared logo correction through existing asset reuse

Phase 7.3 resolved the in-app branding inconsistency by updating the shared logo widget to use the existing official SCAVIUM icon asset.

Benefits:

- branding consistency across shared UI entry points
- no need for per-screen fixes
- no asset pipeline redesign
- very low implementation risk

---

### 13. Build system implemented in Dart

Phase 7.4 implemented build automation in:

- `tool/build.dart`

instead of relying on a PowerShell-first approach.

Benefits:

- cross-platform compatibility
- alignment with Flutter/Dart tooling
- easier maintenance inside the project
- improved future CI/CD reuse

---

### 14. pubspec.yaml retained as the version source of truth

Phase 7.4 kept `pubspec.yaml` as the authoritative version source for the build workflow.

Benefits:

- avoids duplicated version storage
- keeps Flutter metadata aligned with tooling
- simplifies release semantics
- reduces version drift risk

---

### 15. Fail-fast tooling with Never for termination semantics

Phase 7.4 hardened the tooling implementation by using explicit termination semantics (`Never`) for unrecoverable failures.

Benefits:

- correct Dart flow analysis
- stronger null-safety behavior
- simpler control flow reasoning
- safer static analysis outcomes

---

### 16. Encrypted backup chosen over implicit persistence assumptions

Phase 7.5 addressed reinstall/device-loss recovery by introducing an explicit encrypted backup flow instead of relying on implicit platform persistence or uninstall behavior.

Benefits:

- clearer user recovery model
- less reliance on platform-specific storage semantics
- stronger self-custody alignment
- reduced risk of false recovery expectations

---

### 17. Export and restore intentionally placed in different presentation areas

Phase 7.5 finalized the UI placement strategy as:

- export backup in settings/security context
- restore backup in wallet entry / acquisition context

Benefits:

- better semantic clarity
- cleaner user expectations
- no need to overload settings with pre-wallet recovery actions
- no need to place export inside acquisition flow

---

### 18. Restore reuses existing wallet import paths

Phase 7.5 restore does not write wallet secrets through a parallel persistence path.

Instead, it reuses the existing wallet import methods.

Benefits:

- inherits Phase 7.2 persistence hardening
- reduces duplicated logic
- lowers restore inconsistency risk
- keeps recovery integrated with the existing wallet model

---

### 19. Platform-aware export UX

Phase 7.5 adopted different export UX behavior per platform:

- desktop platforms → native save dialog
- mobile platforms → share/export flow

Benefits:

- better Windows usability
- better alignment with platform expectations
- more reliable user-controlled file placement
- no unnecessary desktop/mobile UX compromise
---

### 19. Portfolio summary derived only from visible assets

Phase 8.2 introduced a portfolio summary model that is computed only from currently loaded `AssetItem` entries.

Benefits:

- deterministic behavior;
- no dependency on external indexers;
- no unsupported fiat valuation assumptions;
- no hidden token discovery behavior;
- safer incremental foundation for future portfolio maturity.

---

### 20. Manual token registry remains explicit

Phase 8.2 keeps token registration user-driven and deterministic.

Token addresses are validated and normalized before persistence, and duplicate entries are prevented by normalized contract address.

Benefits:

- lower risk of unstable automatic discovery;
- predictable storage behavior;
- safer metadata error handling;
- clearer user control over locally displayed ERC-20 tokens.

---

### 21. Asset context depends on wallet account state but does not own it

Phase 8.2 adds account context to asset items while keeping wallet identity ownership inside the wallet feature.

Benefits:

- avoids feature ownership inversion;
- keeps account switching centralized;
- allows assets to be presented in the correct account context;
- prepares later activity and transaction maturity work without broad refactoring.

---

### 22. Diagnostics remain local and non-invasive

Phase 8.5 confirms that RPC diagnostics are a local operational aid, not telemetry.

Benefits:

- keeps diagnostics useful for chain/RPC visibility;
- avoids remote reporting assumptions;
- prevents raw exception dumps from becoming user-facing security risk;
- preserves the wallet's self-custody and privacy posture.

---

### 23. Signing safety copy is explicit but signing scope remains bounded

Phase 8.5 improves signing validation, warning copy, confirmation copy, cancellation behavior, and result language.

Benefits:

- users see that signatures are not transactions;
- users are reminded that signatures do not move funds and are not receipts;
- challenge-message and personal-message signing remain distinct;
- signing does not become dApp connectivity, WalletConnect, or automatic challenge ingestion.

---

### 24. Error normalization does not create a new global error architecture

Phase 8.5 introduces safer user-facing error helpers and applies them across selected invalid-state and async surfaces.

Benefits:

- sensitive material is suppressed from user-facing failures;
- users receive clearer retry/correction copy;
- local data such as pending transaction history is preserved when refresh fails;
- existing feature/controller ownership remains intact.


---

### 25. Phase 9 should normalize visual identity through design tokens before broad theme changes

Phase 9 is locked around a token-first visual strategy by Phase 9.0. The project should not solve the current saturated/dark-only appearance by applying isolated color changes across screens.

Instead, the app theme layer should define a SCAVIUM Design Token System covering brand, background, surface, border, text, semantic, interaction, shape, spacing, and elevation values. Light and dark themes should then derive from that shared token language.

This decision keeps SCAVIUM identity stable while enabling smoother visual hierarchy, lower saturation, and future maintainability.

### 26. Runtime version display should not be hardcoded in Settings/About

The Settings/About surface should display application version data resolved from runtime metadata or generated build metadata.

Hardcoded copy such as `Version 0.4.0` can diverge from `pubspec.yaml`, MSIX metadata, CI artifacts, and release tags. Phase 9 should remove that mismatch by introducing a small application identity/version boundary instead of treating version display as static UI text. Phase 9.0 documents this as an explicit product identity decision before implementation begins.

### 27. Phase 9.0 opens Phase 9 without modifying runtime behavior

Phase 9.0 is a documentation lock, not an implementation step. It opens the identity, versioning, and visual theme maturity phase while preserving Phase 8.6 as closed.

No runtime wallet behavior, build tooling, CI workflow, theme code, Settings code, or release publication behavior changes during 9.0. This decision keeps the phase boundary auditable and ensures 9.1 can begin from an explicit contract.

### 28. Phase 9.3 must normalize tokens before implementing light/dark behavior

Phase 9.3 is documented as a token-normalization implementation sequence, not as a broad visual redesign. The current runtime still forces dark mode through `lib/app/app.dart`, while `lib/app/theme/app_colors.dart`, `lib/app/theme/app_text_styles.dart`, and `lib/app/theme/app_theme.dart` own the existing visual layer.

The decision for 9.3 is to stabilize the SCAVIUM token vocabulary first: brand, background, surface, border/divider, text, semantic, interaction, shape, spacing, and elevation values must be owned inside the app theme layer before Phase 9.4 introduces first-class light/dark themes. A dedicated token file is allowed only if it clarifies this ownership.

This prevents light mode, theme persistence, and Settings appearance controls from being built on scattered screen-level color edits.

