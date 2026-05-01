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

The next planned product-expansion area is Phase 8.4 — Navigation Shell and Product Surface Scaling.

Phase 8.3 is closed. The completed runtime scope includes safer local outgoing transaction history state handling, receipt-oriented transaction detail, local activity filtering/grouping, and explicit message-signing flows with preview, confirmation, cancellation, and result display.

Phase 8.4 has now started as a navigation and product-surface maturity phase. Runtime implementation has not started yet, but the baseline inspection and execution contract are complete.

Completed Phase 8.4 scope:

- 8.4.0 — Navigation Shell Baseline Inspection and Product Surface Contract

Planned remaining Phase 8.4 scope:

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
