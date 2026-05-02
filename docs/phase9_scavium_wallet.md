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

Completed implementation subphase. The runtime identity boundary is owned by `lib/core/app_identity`, uses `package_info_plus` for package metadata resolution, and keeps Settings/About independent from direct platform metadata access.

#### Existing Files Intervened

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

Completed implementation subphase. Settings/About now consumes the runtime identity boundary and no longer carries stale hardcoded version copy.

#### Existing Files Intervened

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

Completed implementation subphase. Focused tests validate deterministic version display and provider override behavior without depending on local release artifacts.

#### Existing Files Intervened

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

Closed implementation subphase. 9.2.1 completed the baseline inspection and contract lock, 9.2.2 and 9.2.3 added build-tool hardening and focused validation coverage, 9.2.4 aligned release/development documentation, and 9.2.close records final coherence after the `pubspec.yaml` MSIX layout normalization was confirmed.

The real Phase 9.2 implementation confirms that 9.2 moved beyond the Phase 8.6 release-tooling baseline without becoming a new publication feature. `tool/build.dart` remains the build identity executor and now exposes testable version/MSIX helpers without invoking platform builds. `test/build_tool_version_test.dart` adds focused coverage for strict pubspec parsing, Git tag normalization, version bumping, `--no-version-bump`, and MSIX version derivation. `pubspec.yaml` owns `version: 0.2.2+1`, `msix_config.msix_version: 0.2.2.1`, and the final closure confirms the physical MSIX metadata layout has been normalized so `identity_name` and `msix_version` are separate auditable YAML lines.

The 9.2.1 inspection locked the baseline contract before code hardening. The 9.2.2 and 9.2.3 implementation keeps that ownership model: `pubspec.yaml` remains the canonical source of semantic version and build number; `tool/build.dart` remains the executor for local/CI build orchestration, tag validation, version mutation, and MSIX synchronization; `.github/workflows/release.yml` remains unchanged; generated build reports and release manifests remain evidence outputs rather than committed source of truth.

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

Completed documentation/baseline subphase.

9.2.1 was executed from the real Phase 9.2 step ZIP as a documentation-only baseline lock. No runtime code, build script, dependency file, workflow, generated release artifact, or `.agent/*` file was modified.

#### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md` — record the baseline inspection result and confirm the exact 9.2 execution contract.
- `docs/release.md` — may receive a small baseline note only if the inspection discovers operator-facing ambiguity that must be documented before code work.
- `docs/development.md` — may receive a small baseline note only if developer validation commands need to be clarified before code work.

#### New Files Tentatively Creatable

None expected.

#### Baseline Inspection Result

The current source-controlled metadata is internally aligned:

- `pubspec.yaml` declares `version: 0.2.2+1`;
- `pubspec.yaml` declares `msix_config.msix_version: 0.2.2.1`;
- the MSIX value follows the existing build-tool mapping from `x.y.z+n` to `x.y.z.n`;
- `tool/build.dart` reads `version: x.y.z+n` through `readVersionInfo`;
- `resolveVersion` increments the build number when the semantic version is unchanged;
- `resolveVersion` resets the build number to `1` when `--version x.y.z` changes the semantic version;
- `--no-version-bump` returns the currently recorded version without mutating `pubspec.yaml`;
- `validateExpectedTagAgainstPubspec` accepts tags shaped as `vX.Y.Z` or `refs/tags/vX.Y.Z` and compares them against the semantic version only;
- `buildWindowsMsix` synchronizes `msix_config.msix_version` from the resolved build version before invoking Windows/MSIX packaging;
- CI MSIX overrides remain environment-variable based and do not redefine version ownership.

The inspection also identifies the precise ambiguity left for 9.2.2 and 9.2.3: the behavior exists, but the script does not yet expose a dedicated low-cost validation surface for no-bump/MSIX synchronization semantics, and operator logs can still be improved so intentional non-mutation is visibly different from a failed synchronization.

#### Version Ownership Contract Locked by 9.2.1

- `pubspec.yaml` is the canonical source for the project semantic version and Flutter build number.
- `msix_config.msix_version` must remain derivable from `pubspec.yaml` as `semanticVersion.buildNumber`.
- `tool/build.dart` owns build-time interpretation, optional mutation, tag validation, and MSIX metadata synchronization.
- `--no-version-bump` means the build uses the current `pubspec.yaml` version intentionally; it is not a request to resynchronize or increment metadata.
- `--check-version --expected-tag vX.Y.Z` validates the Git tag against the semantic version only; it does not validate or mutate the build number.
- `.github/workflows/release.yml` remains outside the default 9.2 implementation scope unless a later code inspection proves the workflow contradicts this contract.
- Generated files under `build/release/`, CI release manifests, checksums, and draft-release assets remain evidence outputs and must not be treated as committed source of truth.

#### Technical Justification

The build tool is already mature enough that uncontrolled edits could regress Phase 8.6 behavior. 9.2.1 creates a narrow contract around existing behavior before hardening anything. The locked contract gives 9.2.2 permission to improve clarity and guardrails without changing release publication semantics, and gives 9.2.3 a stable target for deterministic validation coverage.

#### Expected Validations

- Confirm current `pubspec.yaml` version and `msix_config.msix_version` alignment.
- Confirm 9.2 does not require `.github/workflows/release.yml` changes unless code inspection proves a real CI inconsistency.
- Confirm no `.agent/*` artifacts are part of the documentation deliverable for this planning task.

#### 9.2.1 Validation Result

Completed by documentation and source inspection from the real ZIP:

- current version alignment confirmed as `version: 0.2.2+1` and `msix_config.msix_version: 0.2.2.1`;
- no code-level implementation was performed;
- no `.github/workflows/release.yml` intervention is justified for 9.2.1;
- no `.agent/*` artifact is part of the deliverable;
- 9.2.2 remains the next executable implementation subphase.

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

Implemented by agent in the real 9.2.2-to-9.2.3 ZIP and validated statically during 9.2.4. The implementation remained centered on `tool/build.dart`, preserved the Phase 8.6 release boundary, and did not modify `.github/workflows/release.yml` or release publication behavior.

#### Existing Files Intervened

- `tool/build.dart` — implementation target for behavior clarification, strict version parsing, no-bump semantics, tag normalization/validation, and MSIX synchronization helpers.
- `pubspec.yaml` — retains the intended version/MSIX values and, by final closure, stores `identity_name` and `msix_version` as separate auditable YAML lines.
- `docs/phase9_scavium_wallet.md` — records actual implementation decisions and validation outcome.

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

Implemented by agent in the real 9.2.2-to-9.2.3 ZIP and validated statically during 9.2.4. The implementation added focused coverage through `test/build_tool_version_test.dart` rather than introducing a release helper script or invoking platform builds for every identity assertion.

#### Existing Files Intervened

- `tool/build.dart` — exposed and preserved testable version/MSIX behavior without broad release-tool refactoring.
- `docs/phase9_scavium_wallet.md` — records the validation strategy and commands used.

#### New Files Created

- `test/build_tool_version_test.dart` — focused deterministic coverage for build-version parsing, tag normalization, bump/no-bump behavior, and MSIX version derivation without triggering Flutter platform builds.

#### Technical Justification

Full Android, web, and Windows builds are too expensive and environment-dependent for every version-behavior assertion. 9.2.3 should validate the identity logic directly so future release-tool changes do not silently break version/MSIX synchronization.

#### Expected Validations

- `fvm flutter test test/build_tool_version_test.dart` if a Flutter/Dart test is added.
- Or a documented `dart run tool/...` validation command if a script-level helper is added.
- Existing `fvm flutter test` remains green.

---

#### 9.2.2 Implementation Validation Result

Static validation of the real 9.2.2-to-9.2.3 ZIP confirms that the build-tool hardening stayed within the intended boundary:

- `tool/build.dart` still owns version parsing, version mutation, tag validation, MSIX synchronization, CI MSIX overrides, artifact expectation reporting, and release-report generation.
- `VersionInfo.msixVersion` derives the Windows MSIX value as `buildName.buildNumber`, preserving the locked `x.y.z+n` to `x.y.z.n` contract.
- `resolveVersion` preserves automatic build-number increment when no semantic override is provided.
- `resolveVersion` preserves build-number reset to `1` when `--version x.y.z` changes the semantic version.
- `resolveVersion` keeps `--no-version-bump` as intentional non-mutation and returns the current `pubspec.yaml` version instead of mutating metadata.
- `validateExpectedTagAgainstPubspec` continues to normalize `vX.Y.Z` and `refs/tags/vX.Y.Z` tags and compare only the semantic version.
- `syncMsixVersion` remains tied to the resolved build version and reports whether the MSIX value was already synchronized or updated.
- `.github/workflows/release.yml` was not modified by 9.2.2, preserving the Phase 8.6 CI release boundary.

The implementation does not add store upload, Microsoft Store submission, runtime update delivery, wallet runtime behavior, Settings/About version display changes, theme token work, signing changes, asset changes, transaction changes, backup/restore changes, diagnostics changes, or routing changes.

---

#### 9.2.3 Validation Coverage Result

Static validation of the real ZIP confirms that 9.2.3 added the expected focused validation surface:

- `test/build_tool_version_test.dart` exists and imports `tool/build.dart` directly for low-cost behavior coverage.
- The test covers strict `version: x.y.z+n` parsing.
- The test covers simple and `refs/tags/` Git tag normalization.
- The test rejects tags without the `v` prefix and tags that are not semantic `x.y.z`.
- The test covers automatic build-number increment without override.
- The test covers build-number increment when the override matches the current semantic version.
- The test covers build-number reset when the semantic version changes.
- The test covers `--no-version-bump` as non-mutating behavior even if an override is provided.
- The test covers MSIX version derivation from a resolved `VersionInfo`.

The validation strategy is coherent with the 9.2 plan because it tests the identity logic directly without invoking Android, web, Windows, MSIX packaging, signing, CI release upload, generated release reports, or generated artifact discovery.

#### 9.2.3 Static Finding for Closure

The code-level intent is coherent and the final closure records the required `pubspec.yaml` layout normalization: the `identity_name` and `msix_version` values remain `com.scavium.wallet` and `0.2.2.1`, and they are stored as separate normal YAML lines. 9.2.4 documented the final operator/developer contract, and 9.2.close now declares the phase closed from that corrected state.

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

Completed documentation alignment subphase from the real 9.2.2-to-9.2.3 implementation ZIP. This step records the implemented build-tool behavior, the focused validation surface, and the operator/developer command contract that 9.2.close now closes after `pubspec.yaml` MSIX layout normalization was confirmed.

#### Existing Files Intervened

- `docs/phase9_scavium_wallet.md` — records the implemented 9.2.2/9.2.3 behavior, the 9.2.4 alignment result, and the remaining closure check.
- `docs/release.md` — records operator-facing command expectations, mutation boundaries, no-bump behavior, tag validation, and MSIX synchronization evidence.
- `docs/development.md` — records developer-facing focused validation expectations and the final normalized `pubspec.yaml` MSIX metadata contract.
- `README.md` — updates project status from active 9.2 to closed 9.2.
- `docs/index.md` — updates the Phase 9 ledger to reflect implemented 9.2.2/9.2.3 and active 9.2.4/9.2.close.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

Version tooling is operationally sensitive. The implementation is incomplete unless the release/development documentation explains the mutation and validation boundaries clearly enough for future operators to reproduce them.

#### Expected Validations

- Documentation states whether `--no-version-bump` intentionally preserves `pubspec.yaml`.
- Documentation states when `msix_config.msix_version` is synchronized.
- Documentation states that `test/build_tool_version_test.dart` is the focused validation surface for 9.2 behavior.
- Documentation records the normalized `pubspec.yaml` physical-layout requirement that 9.2.close confirms.
- Documentation does not claim automatic store upload, Microsoft Store submission, or runtime update delivery.

#### 9.2.4 Documentation Alignment Result

Completed as a documentation-only subphase over the real 9.2.2-to-9.2.3 ZIP. The release and development documents now explain that normal build execution may mutate `pubspec.yaml`, `--no-version-bump` intentionally does not mutate it, expected-tag validation compares the Git tag against the semantic version only, and Windows MSIX synchronization derives `msix_config.msix_version` from the resolved build identity as `x.y.z.n`.

The alignment also records the practical validation boundary introduced by 9.2.3: `test/build_tool_version_test.dart` is the low-cost coverage surface for version parsing, tag normalization, bump/no-bump behavior, and MSIX derivation. Full platform builds remain release validation, not the only way to verify build identity rules.

9.2.4 does not modify code, `.agent/*`, generated release artifacts, CI release workflow, wallet runtime, Settings/About runtime version display, theme work, signing, assets, transactions, backup/restore, diagnostics, or routing.

The only closure blocker identified during 9.2.4 validation was physical YAML layout. That blocker is resolved for 9.2.close: `pubspec.yaml` preserves the intended `identity_name` and `msix_version` values on separate auditable lines, so the phase can close as fully coherent.

---

### 9.2.close — Build Version & MSIX Synchronization Hardening Closure

#### Objective

Close 9.2 by confirming that build-version mutation, no-bump behavior, tag validation, MSIX synchronization, focused validation coverage, and normalized source-controlled MSIX metadata layout are implemented, validated, and documented coherently.

#### Scope

- Record the actual files changed by 9.2 implementation.
- Record the confirmed `pubspec.yaml` physical layout with `identity_name` and `msix_version` on separate normal YAML lines.
- Record the exact validation commands and outcomes.
- Confirm runtime version display from 9.1 remains intact.
- Confirm 9.3 remains the next executable implementation subphase.

#### State

Closed documentation/validation subphase.

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
- Confirm `pubspec.yaml` keeps `version: 0.2.2+1` and `msix_config.msix_version: 0.2.2.1` on normal auditable lines, unless the closure intentionally bumps version metadata.
- Confirm the next executable implementation subphase is `9.3 — Theme Token Normalization`.

#### 9.2.close Final Closure Result

Completed as a documentation-only closure after the Phase 9.2 implementation and the follow-up `pubspec.yaml` MSIX layout normalization were confirmed. Phase 9.2 is now closed from the following coherent state:

- `pubspec.yaml` remains the canonical source for `version: 0.2.2+1`;
- `msix_config.msix_version` remains aligned as `0.2.2.1`;
- `identity_name: com.scavium.wallet` and `msix_version: 0.2.2.1` are stored on separate normal YAML lines;
- `tool/build.dart` owns strict version parsing, optional build-number mutation, explicit `--no-version-bump` behavior, expected-tag validation, and Windows MSIX synchronization;
- `test/build_tool_version_test.dart` is the focused low-cost validation surface for version parsing, tag normalization, bump/no-bump behavior, and MSIX derivation;
- `.github/workflows/release.yml` remains unchanged because 9.2 did not expand release publication semantics;
- runtime Settings/About version display from 9.1 remains intact and is not reopened by 9.2;
- theme tokens, light/dark theme work, theme persistence, wallet custody, accounts, assets, transactions, signing, backup/restore, diagnostics, routing, Play Store upload, Microsoft Store submission, and GitHub Release publication behavior remain out of scope.

9.2 therefore closes the build identity gap between package metadata, build-tool behavior, and Windows MSIX metadata. The next executable implementation subphase remains `9.3 — Theme Token Normalization`.

---

## 9.3 — Theme Token Normalization

### Objective

Introduce a normalized SCAVIUM design token layer as the foundation for coherent light/dark themes and future visual-system maturity.

### Scope

- Define token ownership inside the existing `lib/app/theme` boundary.
- Preserve the current SCAVIUM visual identity while replacing ad-hoc color constants with a clearer token vocabulary.
- Normalize brand, background, surface, border, divider, text, semantic, interaction, shape, spacing, and elevation values before broad theme changes.
- Keep `AppTheme.darkTheme` behavior functionally stable while preparing it to consume tokenized values.
- Avoid implementing light mode, runtime theme selection, persistence, Settings appearance controls, or a broad redesign in 9.3.

### State

Closed implementation subphase.

The real Phase 9.3 implementation is now complete across 9.3.1, 9.3.2, and 9.3.3, with 9.3.4 closing the documentation record from the implemented state. The original Phase 9.2 baseline confirmed that 9.3 was not yet implemented in code. `lib/app/theme/app_colors.dart` still exposes a compact dark-oriented color set (`background`, `surface`, `surfaceSoft`, `card`, `primary`, `primarySoft`, `accent`, text colors, `border`, `danger`, `warning`, and `success`). `lib/app/theme/app_text_styles.dart` couples text styles directly to those colors. `lib/app/theme/app_theme.dart` exposes only `AppTheme.darkTheme`, and `lib/app/app.dart` still forces `themeMode: ThemeMode.dark` while passing only the dark theme.

The final direct token consumers remain intentionally bounded: `AppTheme`, `AppTextStyles`, shared SCAVIUM buttons, section titles, cards, snackbars, confirmation dialogs, and the focused token tests. This keeps 9.3 a bounded theme-layer normalization step rather than a screen-by-screen redesign.

### Existing Files Tentatively Intervenable

- `lib/app/theme/app_colors.dart` — primary existing owner of visual color constants; must either become the token owner or delegate to a new token file without leaving ambiguous duplicate color vocabularies.
- `lib/app/theme/app_text_styles.dart` — currently binds text styles directly to dark-oriented color constants; may need to consume text tokens or a token context while preserving existing typography intent.
- `lib/app/theme/app_theme.dart` — must continue to build the current dark theme from the normalized token vocabulary and prepare the handoff to 9.4 without introducing light-mode behavior prematurely.
- `lib/shared/widgets/scavium_primary_button.dart` — currently consumes `AppColors.primary` and must remain visually coherent if brand/action tokens are renamed or separated.
- `lib/shared/widgets/scavium_secondary_button.dart` — currently consumes `AppColors.border` and must remain coherent if border tokens are normalized.
- `lib/shared/widgets/section_title.dart` — currently consumes `AppTextStyles` and is indirectly affected by text-token normalization.
- `lib/shared/widgets/scavium_card.dart` — should be inspected as a shared surface component even if no code change is ultimately required.
- `lib/shared/widgets/scavium_text_field.dart` — should be inspected as a shared input component even if the primary input normalization remains inside `AppTheme`.
- `test/widget_test.dart` — may need adjustment only if theme construction expectations are exposed by the smoke test.
- Existing widget tests touching Settings, shell, buttons, or shared screens — may be extended only if token refactoring requires deterministic widget coverage.
- `docs/phase9_scavium_wallet.md` — record the actual 9.3 token architecture, implementation result, and validation outcome when executed.
- `docs/architecture.md` — update only if 9.3 establishes a concrete token-owner boundary that should be preserved by later phases.
- `docs/architecture_deep.md` — update only if the implementation adds a deeper design-system structure that affects architectural guidance.
- `docs/ux.md` — update only if token normalization creates a concrete visual-system UX rule beyond the existing Phase 9 direction.
- `docs/features.md` — update only if the token system becomes an explicit implemented UI capability rather than a purely internal refactor.
- `docs/development.md` — update only if new developer rules or focused validation commands are introduced for theme-token work.
- `docs/decisions.md` — update only if the implementation locks a lasting decision about token ownership, naming, or compatibility.

### New Files Tentatively Creatable

- `lib/app/theme/app_theme_tokens.dart` — optional dedicated token model/owner if keeping all token families inside `AppColors` would make brand/background/surface/semantic/interaction/shape/spacing/elevation ownership unclear.
- `test/app_theme_tokens_test.dart` — optional focused unit test if token invariants, mapping, or non-null light/dark preparation rules are encoded in pure Dart structures.

No new screen, feature module, repository, service, route, `.agent/*` file, generated asset, release artifact, or platform-specific build file is expected for 9.3.

### Technical Justification

Theme changes should not be implemented as scattered color edits. The current codebase has a small and centralized theme surface, but the names are still mostly dark-palette constants rather than reusable design tokens. Normalizing this layer first gives 9.4 a stable vocabulary for first-class light/dark themes and prevents later Settings/theme-mode work from depending on one-off screen color decisions.

### 9.3 Subphase Determination

Phase 9 defines `9.3 — Theme Token Normalization` as the executable visual-foundation sequence after 9.2 closure. Because 9.3 affects the visual foundation used by all later theme work, it was executed as a compact nested sequence rather than as a single broad edit.

The following nested subphases were derived from the real Phase 9.2 ZIP and remained intentionally limited to token normalization. They do not implement `AppTheme.lightTheme`, do not change `themeMode`, do not add persisted theme selection, do not restructure Settings/About controls, and do not reopen runtime version, build/MSIX, wallet custody, accounts, assets, transactions, signing, backup, restore, diagnostics, routing, release publication, or CI behavior.

---

### 9.3.1 — Theme Token Baseline Inventory and Naming Contract

#### Objective

Inventory the existing theme constants and lock the token naming contract before changing broad visual behavior.

#### Scope

- Inspect current theme ownership in `lib/app/theme/app_colors.dart`, `lib/app/theme/app_text_styles.dart`, and `lib/app/theme/app_theme.dart`.
- Inspect direct consumers under `lib/shared/widgets` and any screen-level color usage that could conflict with token normalization.
- Map current dark-oriented constants to the Phase 9 token families: brand, background, surface, border/divider, text, semantic, interaction, shape, spacing, and elevation.
- Establish the concrete token namespace required by 9.3.2, 9.3.3, and the later light/dark work.
- Preserve existing screen behavior and avoid broad per-screen refactors during the baseline step.

#### State

Closed implementation subphase.

The real Phase 9.3.1 implementation introduces the baseline SCAVIUM token namespace under `lib/app/theme/tokens/` and keeps the existing public app-theme facade compatible. The subphase creates semantic token owners for colors, spacing, radius, elevation, and typography, exports them through `scavo_tokens.dart`, rewires `AppColors`, `AppTextStyles`, and `AppTheme.darkTheme` to consume those token names, and adds focused token-contract coverage in `test/app_theme_tokens_test.dart`.

9.3.1 deliberately remains a foundation step. It does not expose light mode, does not change `themeMode`, does not persist appearance preferences, does not alter Settings controls, and does not perform a screen-by-screen visual redesign.

#### Existing Files Intervened

- `lib/app/theme/app_colors.dart` — converted into a backwards-compatible color facade over `ScavoColors` so existing consumers remain stable while new work can use semantic token names.
- `lib/app/theme/app_text_styles.dart` — converted into a backwards-compatible typography facade over `ScavoTypography` so existing text consumers keep their current API.
- `lib/app/theme/app_theme.dart` — rewired the current dark `ThemeData` to consume token names for scaffold, color scheme, text theme, app bar, card, and input decoration values while preserving dark-only runtime behavior.

#### New Files Created

- `lib/app/theme/tokens/scavo_colors.dart` — semantic color token owner for brand, background, surface, text, border/divider, semantic state, interaction, overlay, and transparent values.
- `lib/app/theme/tokens/scavo_spacing.dart` — compact non-component spacing scale used as the layout baseline for later adoption.
- `lib/app/theme/tokens/scavo_radius.dart` — shape radius scale for SCAVIUM surfaces and controls.
- `lib/app/theme/tokens/scavo_elevation.dart` — elevation scale documenting the current mostly-flat SCAVIUM visual posture.
- `lib/app/theme/tokens/scavo_typography.dart` — typography token owner backed by Inter and semantic text-color intent.
- `lib/app/theme/tokens/scavo_tokens.dart` — barrel export for the token namespace.
- `test/app_theme_tokens_test.dart` — focused contract test that validates legacy facade mappings and non-component token scale ordering.

#### Technical Justification

The existing theme surface was small enough to preserve, but token naming needed to be locked before deeper refactoring. The implemented structure avoids renaming constants twice, prevents 9.4 from building light/dark themes on unstable vocabulary, and gives the rest of Phase 9 a concrete owner for visual intent.

The naming contract is intentionally semantic and medium-high in granularity. Tokens describe UI intent rather than raw color names or component-specific values: brand colors remain distinct from semantic state colors, surfaces are separated from backgrounds, text colors are named by hierarchy, and spacing/radius/elevation scales stay compact enough to avoid a new token for every component.

#### Validations Performed

- Confirmed token naming is semantic rather than raw color-name driven.
- Confirmed 9.3.1 did not perform screen-level visual refactor work.
- Confirmed 9.3.1 remains independent from theme-mode persistence and Settings controls.
- Confirmed the token owner is compatible with `AppTheme.darkTheme` and later light/dark theme work.
- Confirmed the implementation preserves existing `AppColors` and `AppTextStyles` facade names for incremental adoption.
- Added focused token contract coverage in `test/app_theme_tokens_test.dart`.
- `dart`, `flutter`, and `fvm` were not available in the closure environment, so `fvm flutter analyze` and `fvm flutter test` must be executed in the project development environment before merging if they were not already executed by the implementation agent.

#### 9.3.1 Closure Result

Phase 9.3.1 is closed as the token baseline and naming-contract implementation.

The closed state establishes `lib/app/theme/tokens/` as the concrete SCAVIUM token namespace for the rest of Phase 9. `AppColors` and `AppTextStyles` now act as compatibility facades over the token model, while `AppTheme.darkTheme` consumes tokens directly. This allows 9.3.2 and 9.3.3 to continue hardening token usage without breaking existing screens or forcing a broad visual rewrite.

No light theme, runtime theme selector, persisted preference, Settings appearance control, release behavior, version behavior, wallet custody flow, signing flow, backup/restore behavior, diagnostics behavior, routing behavior, CI workflow, generated artifact, or `.agent/*` artifact is introduced by 9.3.1.close.

---

### 9.3.2 — Core SCAVIUM Token Model Implementation

#### Objective

Implement the normalized token vocabulary in the app theme layer while preserving the current dark visual behavior as the active runtime appearance.

#### Scope

- Introduce or normalize token constants for brand, background, surface, border, divider, text, semantic, interaction, shape, spacing, and elevation.
- Keep backwards-compatible aliases only if needed to reduce churn, and document whether those aliases are transitional.
- Preserve the existing SCAVIUM dark identity while reducing ambiguity between brand colors, semantic colors, and large-surface colors.
- Keep implementation centralized under `lib/app/theme`.

#### State

New planned nested subphase.

#### Existing Files Tentatively Intervenable

- `lib/app/theme/app_colors.dart` — likely receives normalized token families or delegates to the new token owner.
- `lib/app/theme/app_text_styles.dart` — may move from raw dark constants to text token names while retaining Inter typography.
- `lib/app/theme/app_theme.dart` — must consume normalized tokens for the existing dark theme.
- `lib/shared/widgets/scavium_primary_button.dart` — may need token rename alignment for primary actions.
- `lib/shared/widgets/scavium_secondary_button.dart` — may need token rename alignment for borders/secondary action surfaces.

#### New Files Tentatively Creatable

- `lib/app/theme/app_theme_tokens.dart` — acceptable if the implementation benefits from separating token families from legacy color aliases and `ThemeData` construction.

#### Technical Justification

The project already has an app-level theme layer; 9.3 should mature that layer rather than bypass it. A token model gives later light/dark implementation a shared foundation and separates product identity colors from semantic state colors.

#### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test` or a focused subset if only pure theme/widget coverage is affected.
- Confirm `lib/app/app.dart` still forces dark mode after 9.3.
- Confirm no light-mode behavior is exposed yet.

---

### 9.3.3 — ThemeData and Shared Widget Token Adoption

#### Objective

Ensure the active `AppTheme.darkTheme` and shared SCAVIUM widgets consume the normalized token vocabulary coherently.

#### Scope

- Rebuild `AppTheme.darkTheme` from the normalized token names without introducing `AppTheme.lightTheme`.
- Align card, input, app bar, text, color scheme, primary/secondary buttons, section titles, and shared surface components with the token model.
- Keep screen-level changes minimal and only where direct raw color coupling blocks token adoption.
- Preserve current navigation, routing, Settings/About version display, signing, asset, activity, backup, and diagnostics behavior.

#### State

New planned nested subphase.

#### Existing Files Tentatively Intervenable

- `lib/app/theme/app_theme.dart` — primary ThemeData adoption target.
- `lib/app/theme/app_text_styles.dart` — text hierarchy adoption target.
- `lib/shared/widgets/scavium_card.dart` — shared surface/card alignment target if it uses hardcoded visual values or can better rely on `CardTheme`.
- `lib/shared/widgets/scavium_text_field.dart` — shared input alignment target if it duplicates theme-owned behavior.
- `lib/shared/widgets/scavium_primary_button.dart` — primary action alignment target.
- `lib/shared/widgets/scavium_secondary_button.dart` — secondary action alignment target.
- `lib/shared/widgets/feedback/app_snackbar.dart` — inspect only if snackbar semantic color usage bypasses theme tokens.
- `lib/shared/widgets/feedback/confirm_dialog.dart` — inspect only if dialog/danger state color usage bypasses theme tokens.

#### New Files Tentatively Creatable

None expected by default beyond the optional token file introduced in 9.3.2.

#### Technical Justification

A token file alone is not enough if the active theme and shared components continue to use old dark-palette names. This subphase proves the token system is actually the app-level visual contract while keeping runtime behavior and feature flows unchanged.

#### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Manual smoke review of shell/navigation, Settings/About, dashboard, shared cards, inputs, buttons, snackbars, and confirmation dialogs in dark mode.

---

### 9.3.4 — Token Documentation and Implementation Closure

#### Objective

Close 9.3 by documenting the actual token owner, token families, implementation boundaries, and validation result from the real executed state.

#### Scope

- Update `docs/phase9_scavium_wallet.md` with the final 9.3 closure result.
- Update architecture/development/UX/feature/decision documentation only where the implemented token system creates a durable trunk rule.
- Confirm 9.4 can begin from a stable token vocabulary.
- Confirm no runtime theme selection, light mode, Settings appearance controls, wallet behavior, release behavior, or `.agent/*` artifacts are included in the closure deliverable unless explicitly requested by a separate agent-generation task.

#### State

Closed documentation-only nested subphase.

#### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md` — required closure record.
- `README.md` — update only if the Phase 9 status ledger must advance after 9.3 implementation.
- `docs/index.md` — update only if the active Phase 9 ledger must advance after 9.3 implementation.
- `docs/architecture.md` — update only if the concrete token owner becomes an architectural rule.
- `docs/architecture_deep.md` — update only if a deeper token structure or mapping deserves long-form architectural treatment.
- `docs/ux.md` — update only if visual normalization has implemented user-facing UX principles.
- `docs/features.md` — update only if token normalization is recorded as an implemented UI maturity capability.
- `docs/development.md` — update only if future theme development requires new commands or coding rules.
- `docs/decisions.md` — update only if the token-owner/naming decision is finalized by implementation.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

9.3 is a foundation subphase for 9.4 through 9.6. Its closure must preserve the actual token contract so later implementation prompts can consume the documentation without guessing file ownership or repeating baseline analysis.

#### Expected Validations

- Confirm all modified documentation matches the actual files changed by the implementation.
- Confirm the deliverable contains only modified/new documentation if the task is documentation closure.
- Confirm the next implementation phase remains `9.4 — Light/Dark Theme Implementation`.

#### 9.3.4 Closure Result

Phase 9.3.4 closes the Theme Token Normalization sequence as a documentation-only subphase. The executed 9.3 implementation establishes `lib/app/theme/tokens/` as the canonical SCAVIUM visual-token namespace, keeps `AppColors` and `AppTextStyles` as compatibility facades, and confirms `AppTheme.darkTheme` is now built from normalized token values rather than from scattered raw visual constants.

The final implemented token families are:

- `ScavoColors` for brand, background, surface, text, border/divider, semantic state, interaction, overlay, and transparency intent.
- `ScavoSpacing` for the compact non-component layout scale used by shared widgets and future screen adoption.
- `ScavoRadius` for shape scale across controls, cards, overlays, and pill-like surfaces.
- `ScavoElevation` for the mostly-flat SCAVIUM elevation posture, including floating and modal levels.
- `ScavoTypography` for Inter-backed text styles and semantic typography aliases.
- `scavo_tokens.dart` as the theme-layer barrel export.

The final 9.3 adoption remains deliberately bounded. Shared visual components now consume token values where the phase intended to prove the contract: `ScaviumCard`, `ScaviumPrimaryButton`, `ScaviumSecondaryButton`, `SectionTitle`, `AppSnackbar`, and `ConfirmDialog` participate in token usage, while the application root still remains dark-only. No `AppTheme.lightTheme`, runtime theme selector, persisted appearance preference, Settings appearance control, wallet behavior, release behavior, routing behavior, CI workflow, generated artifact, or `.agent/*` artifact is introduced by 9.3.

Focused coverage remains in `test/app_theme_tokens_test.dart`, validating facade mappings, expanded token aliases, compact token scales, typography facade behavior, and dark-theme construction from normalized token values. Manual validation for 9.3 should continue to include dark-mode smoke review of shell/navigation, Settings/About, dashboard, shared cards, inputs, buttons, snackbars, and confirmation dialogs.

Phase 9.3 is therefore closed as the visual-system foundation required by Phase 9.4. The next executable implementation phase is `9.4 — Light/Dark Theme Implementation`, which should extend this token vocabulary into first-class light/dark theme definitions rather than reintroducing screen-local palettes.

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

Phase 9.0 is complete as the phase definition and documentation lock. Phase 9.1 is complete as the runtime application version surface: Settings/About now displays dynamic runtime metadata through `lib/core/app_identity` instead of hardcoded UI copy. Phase 9.2 is closed as the build-version and MSIX synchronization hardening sequence. Phase 9.3 is closed as the token-first visual-system foundation. `lib/app/theme/tokens/` owns the SCAVIUM token namespace, `AppColors` and `AppTextStyles` remain compatibility facades, `AppTheme.darkTheme` consumes normalized token names, shared visual widgets have begun token adoption, and focused token contract coverage exists in `test/app_theme_tokens_test.dart`. The next executable implementation phase is 9.4 — Light/Dark Theme Implementation.
