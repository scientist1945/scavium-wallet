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

Completed documentation-only phase-opening subphase.

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
- Confirm Phase 8.6 remains closed and Phase 9 is represented as the active next phase.

### 9.0 Closure Result

Phase 9.0 is complete as a documentation-only phase definition and lock.

This closure confirms that Phase 9 has been opened from the real Phase 8.6-completed project state and that its scope is intentionally limited to application identity, versioning, visual theme maturity, Settings/About alignment, and the SCAVIUM Design Token System foundation.

No Dart code, build tooling, CI workflow, runtime wallet behavior, blockchain behavior, account model, asset model, signing flow, backup/restore behavior, diagnostics behavior, navigation contract, or release publication behavior is modified by Phase 9.0.

The documentation trunk now records Phase 9 as active, with 9.1 as the next implementation subphase.

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

### State

Planned implementation subphase.

The real Phase 9.0 ZIP confirms that 9.1 is not yet implemented in code. `lib/features/settings/presentation/settings_screen.dart` still renders `Version 0.4.0` as static copy, while `pubspec.yaml` owns `version: 0.2.2+1` and `msix_config.msix_version: 0.2.2.1`. The current dependency set does not include a runtime application metadata package, and there is no existing `lib/core/app_identity` or equivalent version boundary.

### Existing Files Tentatively Intervenable

- `pubspec.yaml` — add a Flutter-compatible runtime metadata dependency only if the implementation chooses package-based version resolution instead of generated metadata.
- `lib/features/settings/presentation/settings_screen.dart` — replace the hardcoded About subtitle with dynamic application version/build metadata.
- `test/settings_screen_test.dart` — extend the existing Settings widget coverage so the About section remains present and can be validated with a deterministic version source.
- `docs/phase9_scavium_wallet.md` — record the actual 9.1 implementation result and validation outcome when 9.1 is executed.
- `README.md` — update only if the runtime version surface becomes part of the visible product summary after implementation.
- `docs/index.md` — update only if the active Phase 9 ledger needs to advance from planning to completed 9.1 state.

### New Files Tentatively Creatable

- `lib/core/app_identity/app_version_info.dart` — optional value object for app name, semantic version, build number, and display label if the implementation benefits from a typed boundary.
- `lib/core/app_identity/app_version_provider.dart` — optional Riverpod provider/service owner for resolving runtime package metadata and exposing it to Settings without coupling UI directly to platform APIs.
- `test/app_version_info_test.dart` — optional focused unit test if formatting/version-label behavior is extracted from the Settings widget.

### Technical Justification

The application must not display a version that diverges from the version used to build and distribute the wallet. Runtime identity should derive from metadata, not from manually edited UI copy. A small identity boundary keeps Settings/About simple and prevents future visual or release tooling work from depending on hardcoded UI text.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Settings/About no longer contains a literal stale version string.
- Runtime display resolves the app name/version/build number from a single metadata boundary.
- Tests avoid depending on the developer machine or generated build artifacts.

### 9.1 Subphase Determination

Phase 9 already defines `9.1 — Runtime App Version Surface` as the next executable implementation subphase. Because 9.1 is small but crosses dependency metadata, application boundary, UI, and tests, it should be executed as a compact set of nested subphases rather than as one unstructured edit.

The following nested subphases are derived from the real ZIP and are intentionally limited to the runtime version surface. They do not touch build/MSIX synchronization, theme tokens, light/dark behavior, theme persistence, signing, assets, transactions, routing, backup/restore, diagnostics behavior, or release publication.

---

### 9.1.1 — Runtime Version Metadata Boundary

#### Objective

Introduce the smallest stable runtime identity boundary capable of resolving the application name, semantic version, build number, and display label from project/build metadata.

#### Scope

- Add a runtime metadata dependency only if required by the selected implementation strategy.
- Create a small app identity/version owner under the existing application/core layering.
- Keep version formatting centralized so Settings does not manually compose version strings.
- Avoid introducing release-tooling logic into runtime code.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `pubspec.yaml` — required only if the implementation uses a package such as `package_info_plus` to resolve runtime metadata across Flutter targets.
- `pubspec.lock` — updated automatically only if a dependency is added through `flutter pub get`.
- `docs/phase9_scavium_wallet.md` — record whether the implementation selected package-based metadata or generated metadata.

#### New Files Tentatively Creatable

- `lib/core/app_identity/app_version_info.dart` — typed representation of app identity metadata and display formatting.
- `lib/core/app_identity/app_version_provider.dart` — Riverpod provider/service wrapper that isolates platform/package metadata resolution from UI code.

#### Technical Justification

The real code currently has no application identity owner and no package capable of reading runtime package metadata. Introducing a narrow boundary prevents `SettingsScreen` from depending directly on platform package APIs and gives tests a stable override point.

#### Expected Validations

- Metadata boundary exposes deterministic display data.
- No Settings UI behavior is changed yet except through later subphases.
- Added dependency, if any, is limited to runtime package metadata and does not alter wallet/domain behavior.

---

### 9.1.2 — Settings/About Runtime Version Integration

#### Objective

Replace the hardcoded About version text in Settings with data from the runtime version metadata boundary.

#### Scope

- Convert the About tile from static version copy to provider-backed version display.
- Preserve the existing Settings section structure introduced during Phase 8.4.
- Keep loading/error fallback behavior quiet and product-safe.
- Avoid broad Settings redesign; appearance controls belong to later Phase 9 subphases.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `lib/features/settings/presentation/settings_screen.dart` — replace `Version 0.4.0` with runtime identity display while preserving the existing Settings sections.
- `test/settings_screen_test.dart` — keep existing Settings section assertions valid after the About tile becomes dynamic.
- `docs/phase9_scavium_wallet.md` — record the actual UI integration result.

#### New Files Tentatively Creatable

None expected by default. A small Settings-specific widget may be created only if the About row becomes complex enough to justify reuse.

#### Technical Justification

The exact inconsistency identified by Phase 9.0 lives in `SettingsScreen`: the UI says `Version 0.4.0` while `pubspec.yaml` owns `0.2.2+1`. 9.1.2 closes that visible product inconsistency without touching build tooling or theme work.

#### Expected Validations

- Settings/About still renders `SCAVIUM Wallet`.
- The stale literal `Version 0.4.0` is removed from runtime UI code.
- The displayed version derives from the metadata boundary.
- Settings layout remains responsive and sectioned as before.

---

### 9.1.3 — Runtime Version Surface Test Coverage

#### Objective

Add focused tests that prove the About surface remains stable while the version value is dynamic and overrideable.

#### Scope

- Extend existing Settings widget tests or add a focused identity/version test.
- Prefer provider overrides or metadata mocks over environment-dependent assertions.
- Validate the display label format without relying on local release artifacts.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `test/settings_screen_test.dart` — extend the existing Settings coverage to assert dynamic About behavior under a deterministic test value.
- `pubspec.yaml` — only if test support requires a metadata package already introduced by 9.1.1.
- `docs/phase9_scavium_wallet.md` — record the executed validation strategy.

#### New Files Tentatively Creatable

- `test/app_version_info_test.dart` — optional unit test for display-label formatting if formatting is extracted into `AppVersionInfo`.

#### Technical Justification

Runtime metadata can vary by platform, test runner, and generated build state. Tests must validate the application contract through a controlled boundary, not by assuming a particular machine-local package result.

#### Expected Validations

- `fvm flutter test test/settings_screen_test.dart`
- Optional focused unit test for version label formatting if a value object is introduced.
- Existing Settings section test intent remains intact.

---

### 9.1.close — Runtime App Version Surface Closure

#### Objective

Close 9.1 by confirming that the stale hardcoded version was removed, runtime metadata is surfaced through a controlled boundary, and documentation reflects the implemented state.

#### Scope

- Record actual files intervened by 9.1 implementation.
- Record validation commands and outcomes.
- Confirm 9.2 remains the next Phase 9 implementation subphase after 9.1 closure.
- Update trunk documentation only from the real implemented state.

#### State

Completed documentation closure for 9.1 after implementation of 9.1.1 through 9.1.3.

#### Implementation Validation Result

Phase 9.1 is complete and coherent with the Phase 9.0 contract. The implementation closes the visible mismatch recorded at phase opening: `SettingsScreen` no longer renders the stale hardcoded `Version 0.4.0` copy while `pubspec.yaml` owns `version: 0.2.2+1`.

The implemented runtime version surface is intentionally small and bounded:

- `package_info_plus` was added as the runtime package metadata dependency in `pubspec.yaml`, with the resolved lock entry recorded in `pubspec.lock`.
- `lib/core/app_identity/app_version_info.dart` now owns the typed application identity value used by the UI.
- `lib/core/app_identity/app_version_provider.dart` now owns the metadata reader boundary and Riverpod providers, keeping package/platform metadata resolution outside the Settings widget.
- `lib/features/settings/presentation/settings_screen.dart` now watches `appVersionInfoProvider` and displays the resolved `AppVersionInfo.displayLabel` inside the About section.
- `test/app_version_info_test.dart` validates display-label formatting, build-number handling, trimming, and separation between semantic version and build number.
- `test/settings_screen_test.dart` validates the Settings/About surface through deterministic provider overrides, confirms the stale literal is absent, and verifies the loading fallback remains product-safe.

This result preserves the Phase 8.4 Settings organization and does not introduce new navigation, theme, release tooling, wallet state, signing, asset, activity, backup, restore, diagnostics, or blockchain behavior.

#### 9.1.1 Closure Result — Runtime Version Metadata Boundary

9.1.1 introduced the runtime metadata boundary under `lib/core/app_identity/`. The boundary is deliberately narrow: `PackageInfoAppVersionReader` reads platform package metadata through `PackageInfo.fromPlatform()`, converts it into `AppVersionInfo`, and exposes it through Riverpod providers.

The value object keeps formatting centralized through `displayLabel`, preventing Settings/About from manually composing application version strings. The display format keeps the semantic version and build number visibly distinct as `SCAVIUM Wallet 0.2.2 (1)` rather than embedding the build number into a raw `+` suffixed pubspec string.

#### 9.1.2 Closure Result — Settings/About Runtime Version Integration

9.1.2 replaced the static About subtitle with provider-backed runtime identity. The Settings screen remains a `ConsumerWidget`, now reading `appVersionInfoProvider` near the top of `build()` and resolving a quiet fallback of `Version unavailable` while metadata is loading or unavailable.

The About card remains in the same Settings surface and continues to identify `SCAVIUM Wallet`, but the subtitle now comes from the metadata boundary. This directly resolves the Phase 9.0 product-identity gap without widening the scope into Settings redesign or theme-mode controls, which remain later Phase 9 work.

#### 9.1.3 Closure Result — Runtime Version Surface Test Coverage

9.1.3 added focused test coverage for both the identity value object and the Settings/About surface. The tests avoid machine-local package metadata assumptions by overriding `appVersionInfoProvider` with deterministic values. This keeps the test contract stable across developer machines, CI, and platform-specific package metadata behavior.

The coverage confirms:

- labels include build numbers when present;
- build suffixes are omitted when the build number is empty;
- whitespace is normalized before display;
- semantic version and build number remain separate fields;
- Settings/About renders the overridden dynamic label;
- the stale `Version 0.4.0` literal is absent;
- the loading fallback is deterministic and safe.

#### Actual Files Intervened by 9.1 Implementation

Code and dependency files already changed by the executed implementation subphases:

- `pubspec.yaml`
- `pubspec.lock`
- `lib/core/app_identity/app_version_info.dart`
- `lib/core/app_identity/app_version_provider.dart`
- `lib/features/settings/presentation/settings_screen.dart`
- `test/app_version_info_test.dart`
- `test/settings_screen_test.dart`

Documentation files updated by this closure:

- `docs/phase9_scavium_wallet.md`
- `docs/index.md`
- `README.md`
- `docs/development.md`
- `docs/features.md`
- `docs/release.md`
- `docs/ux.md`

#### Validation Notes

The closure validation is based on inspection of the real ZIP after execution of 9.1.1 through 9.1.3. The implementation contains the expected dependency, boundary files, Settings integration, and focused tests. The documentation closure does not modify runtime code and does not include `.agent/*` artifacts in the deliverable.

Expected command validation for the implemented code remains:

- `fvm flutter analyze`
- `fvm flutter test`
- `fvm flutter test test/app_version_info_test.dart`
- `fvm flutter test test/settings_screen_test.dart`

#### Technical Justification

9.1 closes a visible application identity gap but does not harden build/MSIX synchronization. The closure therefore avoids claiming 9.2 outcomes while clearly advancing Phase 9 from runtime version display into build-version hardening.

The user-visible runtime app version now follows an application identity boundary instead of static UI copy. That boundary is reusable by later Settings/About polish without coupling future theme or release work to package APIs.

#### Expected Validations

- Confirm no `.agent/*` artifacts are part of documentation delivery.
- Confirm no theme, build-tool, release workflow, wallet runtime, signing, asset, backup, restore, diagnostics, or routing behavior is documented as changed by 9.1.
- Confirm the next implementation subphase remains `9.2 — Build Version & MSIX Synchronization Hardening`.

---

## 9.2 — Build Version & MSIX Synchronization Hardening

### Objective

Clarify and harden the relationship between `pubspec.yaml`, build-number mutation, and `msix_config.msix_version`.

### Scope

- Validate the current `tool/build.dart` version/MSIX synchronization behavior.
- Ensure `--no-version-bump` behavior is explicit and not confused with a sync failure.
- Add focused tests or script-level validation if the project structure supports it.
- Update release/development documentation with exact command expectations.

### State

Planned implementation subphase.

The real Phase 9.1 ZIP confirms that 9.2 is not yet implemented in code. `tool/build.dart` already owns version parsing, build-number mutation, tag validation, Windows MSIX version synchronization, CI MSIX overrides, artifact expectation reporting, and release-report generation. `pubspec.yaml` currently owns `version: 0.2.2+1` and `msix_config.msix_version: 0.2.2.1`. No build-tool unit test or validation helper currently exists under `test/`, and 9.1 did not modify build tooling, CI release workflow, MSIX metadata, artifact naming, or release publication behavior.

### Existing Files Tentatively Intervenable

- `tool/build.dart` — validate or harden version bump, `--version`, `--no-version-bump`, expected-tag validation, and MSIX synchronization behavior without changing release publication semantics.
- `pubspec.yaml` — may be touched only as part of real build-tool behavior during implementation or command validation; source-controlled metadata must remain coherent after the subphase.
- `docs/release.md` — document operator-facing command expectations, mutation boundaries, no-bump semantics, and MSIX synchronization evidence.
- `docs/development.md` — document developer-facing validation expectations for build/version hardening.
- `docs/phase9_scavium_wallet.md` — record the executed 9.2 implementation result and validation outcome when 9.2 is executed.

### New Files Tentatively Creatable

- `test/build_tool_version_test.dart` — optional focused Dart test for pure version parsing, version bump/no-bump semantics, tag normalization, and MSIX version-line synchronization if `tool/build.dart` can be safely structured for testability without broad tooling churn.
- `tool/build_version_validation.dart` — optional helper only if script-level validation cannot be cleanly covered through tests and the helper remains strictly local to build/version consistency.

### Technical Justification

Phase 8.6 matured release tooling, and 9.1 aligned the user-visible runtime version with package metadata. Phase 9.2 must now harden the adjacent build identity chain so operators can distinguish intended version mutation, intended no-mutation behavior, tag/pubspec validation, and Windows MSIX metadata synchronization. This closes the identity gap between the runtime surface, project metadata, and release packaging without introducing a new release publication feature.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- `dart run tool/build.dart --check-version --expected-tag v0.2.2`
- Script-level validation for `--no-version-bump` and Windows MSIX synchronization if implementation adds a safe non-publishing validation path.
- Confirm no Play Store upload, Microsoft Store submission, release publication, wallet runtime, signing, asset, backup, restore, diagnostics, routing, or theme behavior is changed by 9.2.

### 9.2 Subphase Determination

Phase 9 already defines `9.2 — Build Version & MSIX Synchronization Hardening` as the next executable implementation subphase after 9.1. Because the current build tool already performs several responsibilities, 9.2 should be executed as a compact set of nested subphases that separate inspection, behavior hardening, validation coverage, and documentation closure.

The following nested subphases are derived from the real ZIP and are intentionally limited to build-version and MSIX synchronization maturity. They do not touch runtime Settings/About version display already completed in 9.1, SCAVIUM design tokens, light/dark themes, theme preference persistence, signing, assets, transactions, routing, backup/restore, diagnostics behavior, or release publication.

---

### 9.2.1 — Build Version Baseline Inspection and Contract

#### Objective

Lock the current version ownership contract before modifying build tooling.

#### Scope

- Inspect `tool/build.dart` version parsing, bumping, override, no-bump, tag-validation, MSIX synchronization, and release-report behavior.
- Confirm `pubspec.yaml` remains the source of semantic version/build number and MSIX metadata.
- Identify which behavior is already correct, which behavior is ambiguous, and which behavior needs validation or hardening.
- Avoid changing runtime code during the inspection step.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md` — record the baseline inspection result and confirm the exact 9.2 execution contract.
- `docs/release.md` — may receive a small baseline note only if the inspection discovers operator-facing ambiguity that must be documented before code work.
- `docs/development.md` — may receive a small baseline note only if developer validation commands need to be clarified before code work.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

The build tool is already mature enough that uncontrolled edits could regress Phase 8.6 behavior. 9.2.1 creates a narrow contract around existing behavior before hardening anything.

#### Expected Validations

- Confirm current `pubspec.yaml` version and `msix_config.msix_version` alignment.
- Confirm 9.2 does not require `.github/workflows/release.yml` changes unless code inspection proves a real CI inconsistency.
- Confirm no `.agent/*` artifacts are part of the documentation deliverable for this planning task.

---

### 9.2.2 — Build Tool Version and MSIX Behavior Hardening

#### Objective

Harden `tool/build.dart` so version mutation, no-bump behavior, and MSIX synchronization are explicit and difficult to misinterpret.

#### Scope

- Keep `pubspec.yaml` version parsing strict and predictable.
- Preserve build-number increment behavior when no semantic version override is provided.
- Preserve build-number reset behavior when semantic version changes through `--version`.
- Make `--no-version-bump` semantics explicit in logs and behavior.
- Ensure Windows MSIX synchronization remains tied to the resolved build version when MSIX packaging is requested.
- Avoid changing artifact publication, signing policy, CI release ownership, or platform build commands unless required by the hardening.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `tool/build.dart` — primary implementation target for behavior clarification, guardrails, and log clarity.
- `pubspec.yaml` — only if implementation/validation intentionally exercises version metadata and leaves source-controlled metadata coherent afterward.
- `docs/phase9_scavium_wallet.md` — record actual implementation decisions and whether MSIX synchronization behavior changed or was only clarified.

#### New Files Tentatively Creatable

None expected by default. A small extracted build-version helper file is acceptable only if testing pure version behavior from `tool/build.dart` would otherwise require invoking full Flutter builds.

#### Technical Justification

The real script already performs version and MSIX work, but 9.2 exists because operators need an unambiguous identity chain. Hardening should improve clarity and safety without converting the build script into a new release system.

#### Expected Validations

- `dart run tool/build.dart --check-version --expected-tag v0.2.2`
- A safe command or test proving no-bump behavior does not mutate `pubspec.yaml` unexpectedly.
- A safe command or test proving MSIX version synchronization produces `x.y.z.n` from `version: x.y.z+n`.

---

### 9.2.3 — Build Version Validation Coverage

#### Objective

Add focused validation so version parsing, tag normalization, version bumping, no-bump behavior, and MSIX synchronization can be checked without relying on full release builds.

#### Scope

- Add a focused test or script-level validation path if the current project structure supports it cleanly.
- Prefer pure Dart validation of version/MSIX behavior over invoking platform builds.
- Keep tests deterministic and independent from generated release artifacts.
- Avoid broad refactors of `tool/build.dart` solely for test aesthetics.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `tool/build.dart` — may require small extraction or injectable file handling to make pure behavior testable.
- `pubspec.yaml` — may require dev dependency changes only if the existing Flutter test stack cannot run the selected validation path.
- `docs/phase9_scavium_wallet.md` — record the validation strategy and commands used.

#### New Files Tentatively Creatable

- `test/build_tool_version_test.dart` — preferred optional test file for deterministic coverage if the build-tool behavior can be tested without triggering Flutter platform builds.
- `tool/build_version_validation.dart` — fallback optional validation helper only if a test file would over-couple the build tool to Flutter test infrastructure.

#### Technical Justification

Full Android, web, and Windows builds are too expensive and environment-dependent for every version-behavior assertion. 9.2.3 should validate the identity logic directly so future release-tool changes do not silently break version/MSIX synchronization.

#### Expected Validations

- `fvm flutter test test/build_tool_version_test.dart` if a Flutter/Dart test is added.
- Or a documented `dart run tool/...` validation command if a script-level helper is added.
- Existing `fvm flutter test` remains green.

---

### 9.2.4 — Release and Development Documentation Alignment

#### Objective

Align trunk documentation with the final 9.2 behavior so operators and developers know exactly which commands mutate version metadata, which commands validate tags, and which commands synchronize MSIX metadata.

#### Scope

- Update release documentation with the operator-facing version/MSIX behavior.
- Update development documentation with the developer-facing validation commands and boundaries.
- Confirm 9.2 did not alter runtime identity from 9.1 or theme work planned for 9.3 onward.
- Keep documentation incremental and consistent with Phase 8.6 release narrative.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `docs/release.md` — document final operator commands, no-bump meaning, expected tag validation, and MSIX synchronization evidence.
- `docs/development.md` — document developer validation flow for build-version hardening.
- `docs/phase9_scavium_wallet.md` — record the 9.2 documentation result and next subphase.
- `README.md` — update only if project status should move from planned 9.2 to completed 9.2 after implementation.
- `docs/index.md` — update only if the Phase 9 ledger should move from next 9.2 to completed 9.2 after implementation.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

Version tooling is operationally sensitive. The implementation is incomplete unless the release/development documentation explains the mutation and validation boundaries clearly enough for future operators to reproduce them.

#### Expected Validations

- Documentation states whether `--no-version-bump` intentionally preserves `pubspec.yaml`.
- Documentation states when `msix_config.msix_version` is synchronized.
- Documentation does not claim automatic store upload, Microsoft Store submission, or runtime update delivery.

---

### 9.2.close — Build Version & MSIX Synchronization Hardening Closure

#### Objective

Close 9.2 by confirming that build-version mutation, no-bump behavior, tag validation, and MSIX synchronization are implemented, validated, and documented coherently.

#### Scope

- Record the actual files changed by 9.2 implementation.
- Record the exact validation commands and outcomes.
- Confirm runtime version display from 9.1 remains intact.
- Confirm 9.3 remains the next executable implementation subphase.

#### State

Planned closure subphase.

#### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md` — close 9.2 from the real implemented state.
- `docs/release.md` — final release documentation alignment if not completed in 9.2.4.
- `docs/development.md` — final development documentation alignment if not completed in 9.2.4.
- `README.md` — update project status after closure if applicable.
- `docs/index.md` — update Phase 9 ledger after closure if applicable.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

9.2 must close as a build/version hardening phase, not as a release publication phase. Closure prevents later theme work from carrying unresolved version-tooling ambiguity.

#### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Focused build-version validation command or test introduced by 9.2.
- Confirm the next executable implementation subphase is `9.3 — Theme Token Normalization`.

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

1. Phase 9.0 documentation lock is complete.
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

Status: Active.

Phase 9 is opened as the active next phase after Phase 8.6 closure. It is not a continuation of release/distribution implementation, but it depends on the Phase 8.6 versioning and release-tooling baseline.

Phase 9.0 is complete as the phase definition and documentation lock. Phase 9.1 is complete as the runtime application version surface: Settings/About now displays dynamic runtime metadata through `lib/core/app_identity` instead of hardcoded UI copy. The next executable implementation subphase is 9.2 — Build Version & MSIX Synchronization Hardening.
