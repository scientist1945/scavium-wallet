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

---

## Current Phase 8 status

Phase 8 is active and currently completed through:

- Phase 8.1 — Account Model Expansion
- Phase 8.2 — Asset & Portfolio Expansion
- Phase 8.3 — Transaction & Activity Maturity
- Phase 8.4 — Navigation Shell and Product Surface Scaling
- Phase 8.5 — Security, Reliability & Diagnostics Maturity

Phase 8.5 is closed. The completed Phase 8 runtime scope now includes account expansion, asset and portfolio expansion, transaction and activity maturity, navigation-shell and product-surface maturity, and security/reliability/diagnostics hardening.

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
