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

The active product-expansion area is Phase 8.3 — Transaction & Activity Maturity.

Phase 8.3 now has a formalized documentation plan and subphase map for controlled future execution. Phase 8.3.0 is completed as a documentation-only baseline inspection and execution contract lock. No Phase 8.3 runtime implementation is recorded as completed yet.

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

## Active Phase 8.3 transaction and activity maturity

- 8.3.0 — Transaction & Activity Contract Definition and Baseline Inspection  
  Completed as a documentation-only baseline inspection and execution contract lock from the real Phase 8.2-completed codebase.

- 8.3.1 — Transaction History State Model Maturity  
  Plans safer transaction status semantics, local history compatibility, and receipt refresh behavior.

- 8.3.2 — Transaction Detail and Receipt-Oriented Activity View  
  Plans a clearer first-party transaction detail experience without adding external indexer ownership.

- 8.3.3 — Activity Filtering, Grouping, and Empty/Error State Maturity  
  Plans local activity filtering and grouping while preserving the current outgoing-history scope.

- 8.3.4 — Message Signing Domain and Service Boundary  
  Plans explicit `signPersonalMessage(...)` and `signChallengeMessage(...)` foundations separated from transaction submission.

- 8.3.5 — Message Signing UX, Confirmation, and Result Display  
  Plans explicit signing preview, confirmation, cancellation, result display, and safe error handling.

- 8.3.close — Transaction & Activity Maturity Closure  
  Reserved for final documentation closure after runtime implementation is completed and validated.
