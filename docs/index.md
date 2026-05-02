# SCAVIUM Wallet Documentation

## Available documents

- Phase 1 — Foundation  
  phase1_scavium_wallet.md

- Phase 2 — Wallet Core  
  phase2_scavium_wallet.md

- Phase 3 — Blockchain Integration  
  phase3_scavium_wallet.md

- Phase 4 — Assets & Tokens  
  phase4_scavium_wallet.md

- Phase 5 — Core Wallet  
  phase5_scavium_wallet.md

- Phase 6 — Packaging, Branding, Release, and Store Deployment  
  phase6_scavium_wallet.md

- Phase 7 — Stabilization, Bug Fixing, and Release Candidate Hardening  
  phase7_scavium_wallet.md

- Phase 8 — Product Expansion & Production Maturity  
  phase8_scavium_wallet.md

- Phase 9 — Application Identity, Versioning, and Visual Theme Maturity  
  phase9_scavium_wallet.md

---

## Current Phase 8 status

Phase 8 is closed and completed through:

- Phase 8.1 — Account Model Expansion
- Phase 8.2 — Asset & Portfolio Expansion
- Phase 8.3 — Transaction & Activity Maturity
- Phase 8.4 — Navigation Shell and Product Surface Scaling
- Phase 8.5 — Security, Reliability & Diagnostics Maturity
- Phase 8.6 — Release & Distribution Maturity Extension

Phase 8.6 — Release & Distribution Maturity Extension is now complete.

Phase 8.6 is closed. The completed Phase 8 scope now includes account expansion, asset and portfolio expansion, transaction and activity maturity, navigation-shell and product-surface maturity, security/reliability/diagnostics hardening, and release/distribution maturity. Phase 8.6 did not reopen runtime surfaces; it completed the release tooling, artifact consistency, validation/reporting, metadata, checksum, and distribution documentation boundary.

Completed Phase 8.4 scope:

- 8.4.0 — Navigation Shell Baseline Inspection and Product Surface Contract
- 8.4.1 — Route Inventory and Shell Navigation Contract
- 8.4.2 — Responsive App Shell Foundation
- 8.4.3 — Dashboard and Product Surface Segmentation
- 8.4.4 — Wallet and Account Surface Placement
- 8.4.5 — Settings, Diagnostics, and Secondary Action Organization
- 8.4.close — UX & Product Surface Maturity Closure

---

## Completed Phase 8.1 account model foundation

- 8.1.0 — Account Model Contract Definition  
  Defined the multi-account contract, legacy compatibility expectations, and backup v1/v2 migration strategy.

- 8.1.1 — Domain Model Preparation  
  Introduced the domain-level compatibility bridge for `accounts[]`, `activeAccountId`, and `defaultAccountId` while keeping `profile.account` and current single-account behavior intact.

- 8.1.2 — Storage Migration Foundation  
  Added parallel multi-account storage metadata while preserving legacy single-wallet keys and visible behavior.

- 8.1.3 — Active Account Controller  
  Added the controller/repository path for resolving and persisting the active account without adding a switcher UI.

- 8.1.4 — Account Switcher Basic UI  
  Added a minimal UI surface for displaying and selecting among already-known accounts.

- 8.1.5 — Account Creation & Import Expansion  
  Added minimal derived/imported account creation over the existing multi-account foundation.

- 8.1.6 — Backup / Restore Multi-Account Compatibility  
  Added backup v2 support for multi-account profiles while preserving v1 restore compatibility.

---

## Completed Phase 8.2 asset and portfolio expansion

- 8.2.0 — Asset Model Contract Definition and Baseline Inspection  
  Documented the asset/token/portfolio baseline and kept code untouched before implementation.

- 8.2.1 — Portfolio Summary Model Foundation  
  Added a deterministic `PortfolioSummary` domain model derived from visible `AssetItem` data.

- 8.2.2 — Account-Aware Asset Context  
  Added `AssetAccountContext` and associated native/ERC-20 asset items with the active account context.

- 8.2.3 — Manual Token Safety & Metadata UX  
  Hardened token address normalization, duplicate prevention, and safe token metadata error handling.

- 8.2.4 — Asset Surface Polish  
  Improved asset list presentation, portfolio summary visibility, asset type distinction, and responsive behavior.

- 8.2.close — Asset & Portfolio Expansion Closure  
  Consolidated Phase 8.2 documentation across trunk project documents.

---

## Completed Phase 8.3 transaction and activity maturity

- 8.3.0 — Transaction & Activity Contract Definition and Baseline Inspection  
  Completed as a documentation-only baseline inspection and execution contract lock from the real Phase 8.2-completed codebase.

- 8.3.1 — Transaction History State Model Maturity  
  Implemented safer transaction-history deserialization and receipt refresh behavior while preserving local history compatibility.

- 8.3.2 — Transaction Detail and Receipt-Oriented Activity View  
  Implemented a first-party transaction detail route with receipt-oriented status explanation and explicit explorer opening.

- 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity  
  Implemented local status/type filtering, local-day grouping, and distinct empty/error states over outgoing history.

- 8.3.4 — Message Signing Domain and Service Boundary  
  Implemented explicit personal-message and challenge-message signing boundaries separated from transaction submission.

- 8.3.5 — Message Signing UX, Confirmation, and Result Display  
  Implemented signing preview, confirmation, cancellation, visible result display, and signature copy feedback.

- 8.3.close — Transaction & Activity Maturity Closure  
  Completed final trunk documentation closure from the real implemented Phase 8.3 working tree.

---

## Completed Phase 8.4 UX and product surface maturity

- 8.4.0 — Navigation Shell Baseline Inspection and Product Surface Contract  
  Completed the documentation-only baseline inspection and locked the navigation-shell/product-surface execution contract from the real Phase 8.3-completed codebase.

- 8.4.1 — Route Inventory and Shell Navigation Contract  
  Introduced `AppRouteClassifier` and formal route categories so shell eligibility is explicit while `GoRouter` keeps redirect and route ownership.

- 8.4.2 — Responsive App Shell Foundation  
  Added the authenticated `ShellRoute`, reusable `AppShell`, destination metadata, and responsive navigation chrome for primary authenticated destinations.

- 8.4.3 — Dashboard and Product Surface Segmentation  
  Segmented Home into a dashboard-style summary surface while preserving full Assets, Activity/History, signing, send, receive, settings, and diagnostics ownership in dedicated routes.

- 8.4.4 — Wallet and Account Surface Placement  
  Added a dedicated Accounts route for account-oriented controls while preserving active-account state ownership and backup/restore compatibility.

- 8.4.5 — Settings, Diagnostics, and Secondary Action Organization  
  Organized Settings into explicit Security & recovery, Signing, Diagnostics, Danger zone, and About sections while keeping sensitive flows explicit and confirmation-oriented.

- 8.4.close — UX & Product Surface Maturity Closure  
  Completed final trunk documentation closure from the real implemented Phase 8.4 working tree and confirmed the navigation shell, product surfaces, and secondary flows are coherently represented across documentation.

---

## Completed Phase 8.5 security, reliability, and diagnostics maturity

Phase 8.5 is complete after the Phase 8.4 navigation-shell and product-surface maturity work.

This closure is intentionally broader than a checklist update. Phase 8.5 validates that the wallet surface expanded during Phase 8.1 through Phase 8.4 can now behave more safely under sensitive, partial, failed, or ambiguous runtime conditions.

Phase 8.5 did not introduce a new top-level ownership model. Instead, it hardened the existing surfaces that already existed after Phase 8.4:

- RPC diagnostics remains a local diagnostics surface, but raw exception output is replaced with safe user-facing copy.
- Signing remains explicit and local, but request limits, warning copy, confirmation copy, cancellation behavior, and signature-result language are clearer.
- Backup export and restore remain encrypted, password-gated, and user-managed, but their warning and failure surfaces better reflect self-custody consequences.
- Lifecycle and lock behavior remain centralized, with refresh behavior kept compatible with the locked state.
- Screenshot protection remains platform-specific and non-fatal when Android plugin integration fails.
- Invalid-state and async errors are normalized so users receive safer, actionable messages without leaking sensitive material.

Phase 8.5 completed scope:

- 8.5.0 — Security, Reliability & Diagnostics Baseline Inspection and Execution Contract
- 8.5.1 — Sensitive Diagnostics Output Hardening
- 8.5.2 — Signing Safety Copy and Confirmation Hardening
- 8.5.3 — Backup and Recovery Warning Reliability
- 8.5.4 — Lock, Lifecycle, and Sensitive Surface Reliability
- 8.5.5 — Error Boundary and Invalid State Maturity
- 8.5.close — Security, Reliability & Diagnostics Maturity Closure

The closure confirms that Phase 8.5 remains bounded: it does not add telemetry, analytics, remote diagnostics reporting, dApp connectivity, WalletConnect, automatic challenge ingestion, background signing, shell-owned security state, backup payload format changes, or release pipeline changes.

The documentation trunk now reflects Phase 8.5 in `README.md`, this index, the Phase 8 plan, architecture, deep architecture notes, feature inventory, flows, UX, development notes, RPC notes, security notes, release validation expectations, and design decisions.

---

## Completed Phase 8.6 release and distribution maturity extension

Phase 8.6 is complete after Phase 8.5 closure and is documented as a release/distribution maturity phase, not a product-surface expansion phase.

This closure confirms that the project matured the existing release owners rather than replacing them:

- `tool/build.dart` owns local build automation, version bumping, platform selection, MSIX version synchronization, CI overrides, local signing/verification behavior, artifact discovery, artifact expectation checks, build summaries, and generated release reports.
- `.github/workflows/release.yml` owns GitHub Release automation, tag/manual validation, Android artifact generation, Windows MSIX generation, versioned release asset collection, CI-generated `release-manifest.json`, checksum generation, artifact upload/download, and draft release publication.
- `pubspec.yaml` owns the semantic version/build number and `msix_config` metadata used by packaging.
- `docs/release.md` remains the trunk release/distribution reference for operator-facing release behavior.

Phase 8.6 completed scope:

- 8.6.0 — Release & Distribution Baseline Inspection and Execution Contract
- 8.6.1 — Build Tool Artifact and Version Consistency Maturity
- 8.6.2 — GitHub Release Workflow Artifact Consistency
- 8.6.3 — Release Validation and Operator Reporting
- 8.6.4 — Distribution Metadata and Store-Readiness Documentation
- 8.6.5 — Cross-Platform Packaging Consistency and Release Closure Readiness
- 8.6.close — Release & Distribution Maturity Extension Closure

The final release-published artifact set is Android APK, Android App Bundle, and Windows MSIX. Web and unpackaged Windows runner builds remain local-support-only outputs. Build reports and the CI release manifest are generated release evidence, not committed source files. Checksums remain CI-owned through `SHA256SUMS.txt`.

Phase 8.6 remains bounded after closure. It did not introduce automatic Play Store upload, automatic Microsoft Store submission, iOS distribution, runtime update delivery, telemetry, analytics, backup format changes, WalletConnect, dApp connectivity, or wallet runtime feature changes.

---

## Active Phase 9 application identity and visual theme maturity

Phase 9 is open after Phase 8.6 closure. Phase 9.0 completed the documentation definition and lock. It does not reopen Phase 8 runtime feature domains; instead, it addresses the identity and visual-system gaps identified in the real Phase 8.6-completed codebase.

The Phase 9 baseline includes:

- replacing hardcoded Settings/About version copy with runtime version metadata;
- validating and hardening build-version and MSIX synchronization behavior;
- defining a SCAVIUM Design Token System before broad visual changes;
- implementing first-class light and dark themes from shared tokens;
- allowing runtime theme-mode selection and persistence;
- aligning Settings/About as the application identity and appearance control surface.

Phase 9 is documented in `docs/phase9_scavium_wallet.md`. Phase 9.1 is complete, Phase 9.2 — Build Version & MSIX Synchronization Hardening is closed, Phase 9.3 — Theme Token Normalization is closed as the compact token-foundation sequence, and Phase 9.4 — Light/Dark Theme Implementation is closed as the paired-theme implementation bridge. The SCAVIUM token namespace is implemented under `lib/app/theme/tokens/`, `ScavoThemeColors` owns the mode-specific light/dark color boundary, compatibility facades remain stable, shared visual widgets consume theme-owned values, and Phase 9.5 is now documented as the planned runtime selection and persistence sequence.

Phase 9.1 closed the runtime version surface through the compact implementation sequence derived from the real Phase 9.0 ZIP:

- 9.1.1 — Runtime Version Metadata Boundary
- 9.1.2 — Settings/About Runtime Version Integration
- 9.1.3 — Runtime Version Surface Test Coverage
- 9.1.close — Runtime App Version Surface Closure

The implemented result introduces `lib/core/app_identity` as the runtime application version boundary, uses `package_info_plus` to resolve package metadata, replaces the stale `Version 0.4.0` About copy in Settings, and validates the behavior with deterministic provider-overridden tests. This closes the first visible Phase 9 identity gap without changing theme behavior, build/MSIX synchronization, release publication, wallet custody, account, asset, transaction, signing, backup, restore, diagnostics, or routing behavior.

Phase 9.2 is closed as the build-version hardening sequence derived from the real Phase 9.2.1 ZIP:

- 9.2.1 — Build Version Baseline Inspection and Contract — completed
- 9.2.2 — Build Tool Version and MSIX Behavior Hardening — implemented
- 9.2.3 — Build Version Validation Coverage — implemented
- 9.2.4 — Release and Development Documentation Alignment — documented
- 9.2.close — Build Version & MSIX Synchronization Hardening Closure — closed

This closed sequence remains bounded to `tool/build.dart`, project version metadata, `test/build_tool_version_test.dart`, and release/development documentation. The 9.2 baseline confirms `pubspec.yaml` currently owns `version: 0.2.2+1`, `msix_config.msix_version` mirrors it as `0.2.2.1`, and `tool/build.dart` owns build-time interpretation, mutation, tag validation, and MSIX synchronization. The final closure records that the physical `pubspec.yaml` MSIX layout was normalized and confirmed by project validation, so `identity_name` and `msix_version` are stored as separate auditable YAML lines. The sequence does not reopen runtime Settings/About version display completed in 9.1 and does not touch theme tokens, light/dark themes, wallet custody, account, asset, transaction, signing, backup, restore, diagnostics, routing, or release publication behavior.

Phase 9.3 is closed as the visual-system foundation sequence:

- 9.3.1 — Theme Token Baseline Inventory and Naming Contract — closed
- 9.3.2 — Core SCAVIUM Token Model Implementation — closed
- 9.3.3 — ThemeData and Shared Widget Token Adoption — closed
- 9.3.4 — Token Documentation and Implementation Closure — closed

The closed 9.3 result confirms that token ownership belongs to `lib/app/theme/tokens/`, with `scavo_colors.dart`, `scavo_spacing.dart`, `scavo_radius.dart`, `scavo_elevation.dart`, `scavo_typography.dart`, and `scavo_tokens.dart` as the normalized namespace. `lib/app/theme/app_colors.dart` and `lib/app/theme/app_text_styles.dart` remain compatibility facades, `lib/app/theme/app_theme.dart` consumes token names for the existing dark theme, and shared visual widgets now consume token spacing, surface, action, feedback, and dialog values. 9.3 did not expose light mode, change `themeMode`, add persisted appearance selection, alter Settings controls, generate `.agent/*`, or reopen wallet/release behavior; that boundary was intentionally handed to the now-closed 9.4 light/dark theme implementation.

Phase 9.4 is closed as the light/dark theme implementation bridge after the 9.3 token foundation. Its completed subphase sequence is:

- 9.4.1 — Light/Dark Theme Baseline and Token Boundary — closed/documentation-only
- 9.4.2 — AppTheme Light and Dark ThemeData Construction — closed/code-only
- 9.4.3 — Component and Navigation Theme Coherence — closed/code-only
- 9.4.4 — Light/Dark Theme Validation and Documentation Closure — closed

The closed 9.4 result adds first-class paired light/dark theme definitions from the token namespace while preserving the 9.3 dark visual contract. `AppTheme.darkTheme` and `AppTheme.lightTheme` are produced through the same centralized theme builder, `ScavoThemeColors.dark` maps to the normalized dark token values, `ScavoThemeColors.light` owns the light palette, and focused theme tests validate both definitions. Shared cards, buttons, Settings section cards, snackbars, dialogs, and responsive navigation rely on theme-owned values rather than screen-local light/dark branches. The app root still keeps runtime behavior dark-only, leaving user selection, persistence, system-mode handling, and Settings appearance controls to the now-documented 9.5/9.6 sequence.

Phase 9.5 is planned as the runtime selection and persistence sequence over the 9.4 paired-theme contract:

- 9.5.1 — Theme Mode Baseline and Runtime Boundary — planned
- 9.5.2 — Theme Mode Preference Model and Local Persistence — planned
- 9.5.3 — Reactive App Root Theme Mode Wiring — planned
- 9.5.4 — Settings Appearance Selector and UX Integration — planned
- 9.5.5 — Theme Mode Runtime Selection Validation and Documentation Closure — planned

The 9.5 plan is intentionally bounded: it should model and persist `system`/`light`/`dark`, wire the selected mode into `MaterialApp.router`, expose a compact Settings appearance selector, and validate the flow without changing theme token ownership, wallet behavior, release tooling, or the broader Settings/About polish reserved for 9.6.

