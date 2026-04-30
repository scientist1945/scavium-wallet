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

## Current Phase 8 account model foundation

- 8.1.0 — Account Model Contract Definition  
  Defined inside phase8_scavium_wallet.md

- 8.1.1 — Domain Model Preparation  
  Introduces the domain-level compatibility bridge for accounts[], activeAccountId, and defaultAccountId while keeping profile.account and current single-account behavior intact.

- 8.1.2 — Storage Migration Foundation  
  Adds parallel multi-account storage metadata while preserving legacy single-wallet keys and visible behavior.

- 8.1.3 — Active Account Controller  
  Adds the controller/repository path for resolving and persisting the active account without adding a switcher UI.

- 8.1.4 — Account Switcher Basic UI  
  Adds a minimal UI surface for displaying and selecting among already-known accounts without introducing account creation, deletion, backup changes, route changes, or release changes.

- Phase 8.1.5 — Account Creation & Import Expansion: adds minimal derived/imported account creation over the existing multi-account foundation without changing backup v1 or release automation.
