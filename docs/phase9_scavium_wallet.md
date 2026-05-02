# Phase 9 — Application Identity, Versioning, and Visual Theme Maturity

## Overview

Phase 9 opens after the complete closure of Phase 8.6.

Phase 8 matured the wallet product surface, account model, asset and portfolio model, transaction/activity behavior, signing surfaces, navigation shell, reliability posture, diagnostics safety, and release/distribution automation. Phase 9 intentionally does not reopen those runtime feature domains.

The purpose of Phase 9 is to consolidate the visible identity layer of SCAVIUM Wallet: the version displayed by the application, the consistency of version propagation through release tooling, and the visual theme system that frames every product surface.

This phase is required because the real Phase 8.6-completed codebase still contains three product-identity gaps:

- the Settings/About surface displays a hardcoded application version (`Version 0.4.0`) instead of resolving it from project/build metadata;
- `pubspec.yaml` remains the version and MSIX metadata owner, while release tooling already performs MSIX synchronization, but the behavior needs a dedicated hardening/validation pass so operators can distinguish normal `--no-version-bump` behavior from an actual synchronization defect;
- the application currently runs with a forced dark theme (`ThemeMode.dark`) and a single dark theme surface, while the visual result is not yet normalized into a reusable SCAVIUM token system or paired light/dark theme contract.

Phase 9 therefore moves the project from release/distribution maturity into application identity and visual-system maturity.

---

## Initial Context

The project state used to open this phase is the Phase 8.6-completed ZIP.

Relevant real baseline observations:

- `pubspec.yaml` declares the application version as `version: 0.2.2+1`.
- `pubspec.yaml` declares `msix_config.msix_version: 0.2.2.1`.
- `lib/features/settings/presentation/settings_screen.dart` still displays `Version 0.4.0` as static copy.
- `lib/app/app.dart` forces `themeMode: ThemeMode.dark`.
- `lib/app/theme/app_theme.dart` exposes `AppTheme.darkTheme` only.
- `tool/build.dart` contains version parsing, build-number bumping, and MSIX synchronization logic, including `syncMsixVersion(...)`.

These observations define Phase 9 as a product identity, build-version consistency, and visual theme maturity phase.

---

## Problem Statement

SCAVIUM Wallet has reached a mature feature and release baseline, but several identity-level details remain too static or visually under-normalized for a production-grade product:

1. Runtime application version is not derived from the same version source used by packaging and release tooling.
2. Build/version behavior is not yet documented and validated as an explicit product identity contract after Phase 8.6.
3. The visual system is currently dark-only and too tightly coupled to saturated runtime colors instead of a normalized design token system.
4. The Settings surface does not yet act as the user-facing identity/control surface for version and appearance.

If left unresolved, these gaps create visible inconsistencies between what is built, what is distributed, and what the user sees inside the wallet.

---

## Phase Goals

Phase 9 must:

- remove hardcoded runtime application version display;
- introduce a runtime version surface that resolves from reliable application metadata;
- harden and document build-version/MSIX synchronization expectations;
- define a SCAVIUM design token system before changing broad visual behavior;
- implement coherent light and dark themes based on those tokens;
- support runtime theme-mode selection and persistence;
- align Settings/About so application identity and appearance controls are visible, explicit, and stable.

---

## Non-Goals

Phase 9 must not introduce:

- new blockchain transaction behavior;
- new account, asset, activity, signing, backup, restore, diagnostics, or routing features beyond what is required to expose version/theme controls;
- WalletConnect or dApp connectivity;
- telemetry or analytics;
- automatic Play Store upload;
- automatic Microsoft Store submission;
- runtime update delivery;
- remote theme configuration;
- white-labeling implementation;
- a full visual redesign disconnected from the existing SCAVIUM brand.

---

## Implementation Rules

Phase 9 must preserve the established project execution model:

- the ZIP / working tree is the only source of truth;
- documentation is trunk documentation and must be updated incrementally, not rewritten from scratch;
- code implementation subphases must remain bounded and testable;
- `.agent/*` generation/execution may be used only when explicitly requested for code-only execution;
- documentation closure must not include `.agent/*` artifacts in the deliverable unless the requested task is agent generation itself;
- runtime behavior changes must be covered by focused tests where practical;
- build tooling changes must be validated without relying on generated artifacts as source-controlled evidence.

---

## SCAVIUM Design Token System Proposal

The SCAVIUM Design Token System is the visual foundation for Phase 9. It must be defined before broad theme changes so that light and dark themes share the same language instead of diverging into separate ad-hoc palettes.

### Token Families

Phase 9 should introduce or normalize the following token families:

#### Brand Tokens

Brand tokens represent SCAVIUM identity and should remain recognizable across light and dark modes.

- `brandPrimary` — primary SCAVIUM color used for main actions and high-signal highlights.
- `brandSecondary` — secondary identity color used for supportive emphasis.
- `brandAccent` — accent color used sparingly for confirmations, selected states, or controlled glow-like emphasis.

#### Background Tokens

Background tokens define visual depth without relying on excessive saturation.

- `backgroundBase` — application canvas.
- `backgroundLayer` — first elevated visual layer.
- `backgroundLayerSoft` — softer layer for grouped controls and quiet cards.
- `backgroundOverlay` — modal/dialog/sheet layer.

#### Surface Tokens

Surface tokens define component hierarchy.

- `surfacePrimary` — default cards and panels.
- `surfaceSecondary` — nested surfaces.
- `surfaceMuted` — low-emphasis informational blocks.
- `surfaceInteractive` — tappable/hoverable surface state.

#### Border and Divider Tokens

Borders should be visible enough to separate surfaces without creating visual noise.

- `borderSubtle` — default card/section border.
- `borderFocus` — focused input or selected control border.
- `dividerSubtle` — separators inside dense surfaces.

#### Text Tokens

Text tokens must keep contrast and hierarchy stable in both themes.

- `textPrimary` — main readable text.
- `textSecondary` — supporting text.
- `textMuted` — metadata and lower-emphasis labels.
- `textOnBrand` — text over primary brand surfaces.
- `textDanger` — destructive or critical warning text.

#### Semantic Tokens

Semantic tokens must be distinct from brand tokens.

- `success` — completed/safe states.
- `warning` — caution states.
- `danger` — destructive/error states.
- `info` — neutral informative states.

#### Interaction Tokens

Interaction tokens must define visible feedback without over-saturating the base UI.

- `hover` — desktop/web hover affordance.
- `pressed` — pressed/tap feedback.
- `selected` — selected navigation/control state.
- `disabled` — disabled foreground/background pairing.
- `focusRing` — keyboard/accessibility focus indication.

#### Shape and Spacing Tokens

Shape and spacing should keep the current rounded SCAVIUM look but make it consistent.

- `radiusSmall`
- `radiusMedium`
- `radiusLarge`
- `radiusXL`
- `spacingXS`
- `spacingS`
- `spacingM`
- `spacingL`
- `spacingXL`

#### Elevation / Shadow Tokens

Elevation should remain subtle, especially in dark mode.

- `elevationNone`
- `elevationSoft`
- `elevationModal`

### Theme Strategy

Phase 9 should produce two first-class themes:

- `AppTheme.lightTheme`
- `AppTheme.darkTheme`

Both themes must be derived from the same token model. Light mode should not be a simple inversion of dark mode; it should preserve SCAVIUM identity while reducing visual weight. Dark mode should keep the existing brand direction but reduce saturation and improve surface separation.

### Visual Normalization Principles

The token system should enforce:

- fewer direct color references inside screens;
- lower saturation on background and large surfaces;
- stronger contrast only where interaction or hierarchy requires it;
- consistent card, input, navigation, dialog, and list-tile behavior;
- explicit semantic colors for danger/warning/success/info instead of reusing brand colors for meaning;
- parity between mobile and desktop/web surfaces.

### Future-Proofing

This proposal intentionally prepares the codebase for future branding or white-label capability without implementing those features in Phase 9.

The immediate goal is not customization. The immediate goal is a stable, internal SCAVIUM visual contract.

---

## Phase Structure

## 9.0 — Phase Definition & Documentation Lock

### Objective

Open Phase 9 from the real Phase 8.6-completed codebase and lock the application identity, versioning, and visual theme maturity scope.

### Scope

- Document the Phase 9 problem statement, goals, non-goals, and implementation rules.
- Record the baseline version/theme observations from the real ZIP.
- Introduce the SCAVIUM Design Token System proposal as the visual foundation for later subphases.
- Update trunk documentation only.

### State

Planned documentation-only phase-opening subphase.

### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md`
- `README.md`
- `docs/index.md`
- `docs/architecture.md`
- `docs/architecture_deep.md`
- `docs/features.md`
- `docs/ux.md`
- `docs/development.md`
- `docs/decisions.md`
- `docs/release.md`

### New Files Tentatively Creatable

- `docs/phase9_scavium_wallet.md`

### Expected Validations

- Confirm Phase 9 is represented in documentation without modifying runtime code.
- Confirm no non-existent project documents are referenced as required flow documents.
- Confirm Phase 8.6 remains closed and Phase 9 is represented as the next planned phase.

---

## 9.1 — Runtime App Version Surface

### Objective

Remove hardcoded version display from the application and surface the real application version at runtime.

### Scope

- Replace static Settings/About version copy.
- Add an application identity/version provider or equivalent service boundary.
- Resolve version/build metadata using a Flutter-compatible package or generated build metadata approach.
- Display version consistently in the Settings/About surface.
- Add focused tests where practical.

### Existing Files Tentatively Intervenable

- `pubspec.yaml` — add a dependency only if runtime metadata resolution requires it.
- `lib/features/settings/presentation/settings_screen.dart` — replace hardcoded version copy with dynamic data.
- `lib/app/*` or `lib/core/*` — introduce the smallest stable identity/version boundary required by the implementation.
- `test/settings_screen_test.dart` — validate Settings/About behavior if feasible.

### New Files Tentatively Creatable

- A small application identity/version provider file if the existing structure has no suitable owner.

### Technical Justification

The application must not display a version that diverges from the version used to build and distribute the wallet. Runtime identity should derive from metadata, not from manually edited UI copy.

---

## 9.2 — Build Version & MSIX Synchronization Hardening

### Objective

Clarify and harden the relationship between `pubspec.yaml`, build-number mutation, and `msix_config.msix_version`.

### Scope

- Validate the current `tool/build.dart` version/MSIX synchronization behavior.
- Ensure `--no-version-bump` behavior is explicit and not confused with a sync failure.
- Add focused tests or script-level validation if the project structure supports it.
- Update release/development documentation with exact command expectations.

### Existing Files Tentatively Intervenable

- `tool/build.dart`
- `docs/release.md`
- `docs/development.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

- Build-tool tests or validation helpers only if the current project test structure can support them without adding unnecessary complexity.

### Technical Justification

Phase 8.6 matured release tooling, but Phase 9 must close the identity gap between displayed runtime version, project version source, and Windows MSIX metadata.

---

## 9.3 — Theme Token Normalization

### Objective

Introduce a normalized SCAVIUM design token layer as the foundation for coherent themes.

### Scope

- Define token ownership in the app theme layer.
- Reduce direct screen-level color coupling where necessary.
- Normalize brand, background, surface, text, semantic, border, interaction, radius, and spacing tokens.
- Preserve the existing SCAVIUM identity while reducing visual saturation.

### Existing Files Tentatively Intervenable

- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_text_styles.dart`
- `lib/app/theme/app_theme.dart`
- Screens/components only where direct color usage prevents token adoption.
- `docs/ux.md`
- `docs/architecture.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

- A dedicated token file only if the existing `app/theme` structure becomes clearer with separation.

### Technical Justification

Theme changes should not be implemented as scattered color edits. A token layer provides one controlled visual vocabulary for later light/dark parity and future brand evolution.

---

## 9.4 — Light/Dark Theme Implementation

### Objective

Implement first-class light and dark SCAVIUM themes using the normalized token system.

### Scope

- Add `AppTheme.lightTheme`.
- Refine `AppTheme.darkTheme` from token values.
- Ensure Material 3 `ColorScheme`, card, input, app bar, navigation, dialog, list, snackbar, and button behavior remain coherent.
- Validate core screens visually and through widget tests where practical.

### Existing Files Tentatively Intervenable

- `lib/app/theme/app_theme.dart`
- `lib/app/theme/app_colors.dart`
- Shared components and shell/navigation widgets if they require theme alignment.
- Relevant widget tests.

### New Files Tentatively Creatable

None expected by default unless theme token separation was introduced in 9.3.

### Technical Justification

The application currently exposes only a dark theme and forces it globally. Light/dark support should be implemented as a product-level theme contract, not as a per-screen override.

---

## 9.5 — Theme Mode Runtime Selection and Persistence

### Objective

Allow the user to select theme behavior and persist the selection locally.

### Scope

- Support `system`, `light`, and `dark` theme modes.
- Persist the selected theme mode locally.
- Apply the selected mode reactively through the app root.
- Keep the implementation local-only and privacy-preserving.

### Existing Files Tentatively Intervenable

- `lib/app/app.dart`
- `lib/app/theme/*`
- `lib/features/settings/presentation/settings_screen.dart`
- A controller/provider/repository layer for theme preference if required.
- Relevant tests.

### New Files Tentatively Creatable

- Theme preference controller/provider/repository files if no existing owner is appropriate.

### Technical Justification

Theme mode is a user-facing appearance preference. It should not be hardcoded in `MaterialApp.router`, and it should not require rebuilding or reinstalling the application.

---

## 9.6 — Settings and About UX Alignment

### Objective

Align Settings/About as the stable application identity and appearance control surface.

### Scope

- Display app name and dynamic version clearly.
- Add a theme mode selector with clear labels.
- Keep destructive actions, security/recovery actions, diagnostics, signing, and about information visually separated.
- Ensure Settings remains responsive across mobile and desktop/web.

### Existing Files Tentatively Intervenable

- `lib/features/settings/presentation/settings_screen.dart`
- Settings-specific widgets if present or introduced.
- `docs/ux.md`
- `docs/features.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

None expected by default unless Settings needs a small reusable selector widget.

### Technical Justification

The Settings screen already owns secondary controls and About information after Phase 8.4. Phase 9 should extend that ownership coherently rather than creating a separate identity screen.

---

## 9.close — Application Identity, Versioning, and Visual Theme Maturity Closure

### Objective

Close Phase 9 by validating that runtime identity, build-version consistency, and visual theme maturity are implemented and documented coherently.

### Scope

- Confirm runtime version display is dynamic.
- Confirm build/MSIX version behavior is documented and validated.
- Confirm light/dark themes are token-based and visually coherent.
- Confirm theme preference selection/persistence works as intended.
- Update trunk documentation from the real implemented state.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Build-tool validation commands relevant to version/MSIX behavior.
- Manual visual review of light/dark Settings, shell, dashboard, asset/activity surfaces, dialogs, inputs, snackbars, and danger-zone actions.

---

## Recommended Implementation Order

1. Complete 9.0 documentation lock.
2. Implement 9.1 runtime version surface before changing Settings broadly.
3. Harden 9.2 build/MSIX behavior while version ownership is fresh.
4. Normalize 9.3 design tokens before adding light mode.
5. Implement 9.4 light/dark themes from tokens.
6. Implement 9.5 theme selection and persistence.
7. Polish 9.6 Settings/About UX alignment.
8. Close with 9.close documentation and validation.

---

## Risk Register

### Visual Regression Risk

Theme changes affect the entire application. Phase 9 mitigates this risk by introducing tokens first and changing surfaces incrementally.

### Over-Saturation Risk

The existing visual language can feel heavy when saturated colors are used on large surfaces. Phase 9 mitigates this by reserving strong brand colors for high-signal elements and using calmer background/surface tokens.

### Version Source Confusion Risk

Runtime display, `pubspec.yaml`, MSIX metadata, generated artifacts, and release tags can diverge if not explicitly owned. Phase 9 mitigates this by treating runtime version display and build/MSIX synchronization as adjacent subphases.

### Scope Creep Risk

Theme work can easily become a redesign. Phase 9 explicitly limits itself to identity/version/theme maturity and Settings/About alignment.

---

## Phase 9 Initial Status

Status: Planned.

Phase 9 is opened as the next phase after Phase 8.6 closure. It is not a continuation of release/distribution implementation, but it depends on the Phase 8.6 versioning and release-tooling baseline.
