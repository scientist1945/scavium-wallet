# Current Task — 9.6

Project: SCAVIUM Wallet
Phase: 9.6 — Settings and About UX Alignment
Type: Phase summary — low context

## Detected Subphases

- 9.6.1 — Settings/About Baseline Reconciliation — closed documentation-only; do not execute in agent.
- 9.6.2 — Settings/About Information Architecture Polish — first executable code-only task.
- 9.6.3 — Appearance Selector UX and Accessibility Polish — code-only after 9.6.2.
- 9.6.4 — About Identity and Responsive Settings Review — code-only after 9.6.3.
- 9.6.5 — Settings/About UX Validation and Documentation Closure — documentation-only closure after code execution; do not execute in agent.

## Phase Boundary

- Preserve the completed 9.5 runtime theme bridge: `ThemeModeController`, repository persistence, `ThemeModeSelector`, and app-root `themeMode` wiring already exist.
- Improve Settings/About hierarchy, grouping, responsive readability, and accessibility only.
- Do not recreate theme-mode state, storage, providers, or app-root wiring.
- Do not modify documentation through the agent.
- Use `phase-9.6-settings-about-ux-alignment` as the accumulative phase branch.

## Start Here

Use `.agent/current.md`, which points to 9.6.2.
