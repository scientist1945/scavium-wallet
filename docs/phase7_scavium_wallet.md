# Phase 7 — Stabilization, Bug Fixing, and Release Candidate Hardening

## Overview

Phase 7 begins after SCAVIUM Wallet has already completed packaging, branding, release preparation, and initial distribution through Google Play Internal Testing.

At this point, the application is no longer in a pure implementation phase. It is in a stabilization phase.

The purpose of Phase 7 is to harden the wallet for real-world usage by addressing regressions, runtime issues, platform-specific failures, and release candidate feedback without redesigning the architecture or introducing new features.

This phase strictly focuses on:

- bug fixing
- regression fixing
- runtime stability
- release candidate hardening
- store-distributed build validation

No architecture redesign is allowed in this phase.

No new functional product scope is introduced in this phase.

---

## Phase 7.1 — Android Biometrics Stabilization

### Objective

Resolve the Android biometric unlock regression reported by internal testers after Play Store Internal Testing distribution.

The goal of this subphase is to restore reliable biometric unlock behavior on Android devices while preserving the existing lock flow, routing strategy, Riverpod controllers, and overall security architecture.

### Initial Context

At the beginning of Phase 7.1, the project state was:

- Phase 6 completed
- app already distributed via Google Play Internal Testing
- version in circulation: `0.2.1+3`
- testers reporting that biometric unlock was not working on Android devices
- no architecture changes allowed
- only minimal, safe, release-oriented fixes permitted

The relevant existing architecture already included:

- Flutter + Dart
- Riverpod `AsyncNotifier`
- GoRouter navigation
- lock-aware routing
- biometric service abstraction
- Android screenshot protection through `MethodChannel`

The issue was therefore treated as a platform integration regression, not as a feature gap.

### Reported Problem

Internal testers reported that biometric unlock could not be completed on Android devices.

Observed user-facing symptom:

- the wallet showed an authentication failure when attempting biometric unlock

Impact:

- degraded lock/unlock experience
- blocked intended secure unlock flow
- risk of RC rejection if left unresolved

Severity:

- medium to high for release candidate quality
- security-adjacent because it affects the intended unlock mechanism

### Investigation Scope

The stabilization work for this issue was intentionally limited to the minimum Android and service-layer surface required for correction.

The following areas were reviewed:

- Android activity integration
- Android manifest prerequisites
- biometric service usage of `local_auth`
- lock/unlock interaction path
- runtime behavior on real Android hardware

The following areas were explicitly not redesigned:

- lock controller structure
- router structure
- app navigation
- state management model
- storage model
- feature boundaries

### Root Cause Analysis

#### Root Cause

The primary root cause was that the Android entry activity was still implemented using:

- `FlutterActivity`

For the configured biometric integration, Android biometric authentication required:

- `FlutterFragmentActivity`

Because of that mismatch, the biometric flow was not correctly supported on Android devices even though the rest of the application logic and permissions were already largely in place.

### Secondary Validation

During review, the Android manifest was also checked.

The project already had the relevant biometric permissions and embedding configuration in place, including:

- `USE_BIOMETRIC`
- `USE_FINGERPRINT`
- Flutter embedding v2 metadata

This confirmed that the main regression was not caused by missing Android manifest setup, but by the activity class mismatch.

### Applied Fix

#### Android Activity Update

The Android entry activity was updated from:

- `FlutterActivity`

to:

- `FlutterFragmentActivity`

This was the central fix of Phase 7.1.

The existing screenshot-protection `MethodChannel` behavior was preserved.

No changes were made to the channel name, method names, or security flag logic.

#### Biometric Service Validation

The biometric service flow was also aligned with a safer authentication path by ensuring the service checks the platform support conditions before attempting authentication.

The authentication call remained minimal and consistent with the existing architecture.

Key behavioral expectations of the service after stabilization:

- fail safely when biometrics are unavailable
- avoid architecture changes
- preserve the lock flow
- remain Android-compatible under the existing UI/controller structure

### Files Affected

#### Android Platform Layer

- `android/app/src/main/kotlin/com/geryon/scavium_wallet/MainActivity.kt`

#### Dart Service Layer

- `lib/core/services/biometric_auth_service.dart`

No other files were required for the core fix.

### Implementation Characteristics

The fix was intentionally designed to be:

- minimal
- platform-specific
- low-risk
- backward-compatible with the current project structure
- safe for release candidate rollout

The fix does not:

- add new unlock methods
- alter the PIN flow
- alter lock routing
- change state ownership
- modify wallet persistence
- change feature navigation

### Validation Performed

#### Local Validation

After correctly applying the Android activity change and rebuilding the application, biometric unlock was successfully validated locally on Android using fingerprint authentication.

This confirmed that the main issue had been effectively resolved.

#### Internal Testing Follow-Up

After local validation, the updated build was made available again to the internal testing group through the existing Play Store Internal Testing workflow for cross-device confirmation.

The purpose of this follow-up validation is to verify behavior across:

- different Android versions
- different device manufacturers
- different biometric hardware combinations

### Current Status of Phase 7.1

Phase 7.1 is considered:

- implemented
- locally validated
- pending broader tester confirmation for cross-device stability

This means the subphase is technically complete from an implementation perspective, while still remaining under observational validation until feedback from the tester group is consolidated.

### Release Impact

This fix is important for release candidate quality because it restores the intended Android biometric unlock path without requiring broader rework.

Release impact:

- improves Android unlock reliability
- removes a reported tester regression
- reduces friction in secure access flow
- supports progression toward RC2 / RC3 stabilization

### Risks and Remaining Considerations

#### Low Remaining Risk

The applied fix is low risk because it changes only the Android activity base class and keeps the rest of the system intact.

#### Remaining Validation Need

The only remaining uncertainty is device-specific variance across the Android ecosystem.

That is normal for a biometric stabilization fix and is already covered by the tester validation round.

### What Phase 7.1 Does Not Solve

This subphase does not address:

- wallet persistence verification after creation/import
- uninstall/reinstall recovery expectations
- backup enforcement strategy
- transaction runtime issues unrelated to lock/auth
- future biometric UX refinements

Those concerns remain outside the scope of Phase 7.1 and belong to subsequent stabilization work inside Phase 7.

### Conclusion

Phase 7.1 successfully identifies and resolves the Android biometric unlock regression through a minimal, release-safe platform fix.

The implemented correction restores biometric compatibility on Android without altering the established architecture or introducing any new functional scope.

This subphase establishes the first stabilization milestone of Phase 7 and provides a stronger base for the next release candidate validation cycle.

---

## Phase 7.2 — Wallet Persistence Hardening and Restore-State Stabilization

### Objective

Resolve the wallet persistence and restore-state risk identified during stabilization, with particular focus on avoiding silent persistence failures, inconsistent startup state, and unsafe backup confirmation behavior.

The goal of this subphase is not to introduce a new backup system.

The goal is to harden the existing persistence model so that the application behaves safely and predictably under the current architecture and storage strategy.

This subphase preserves:

- the self-custody model
- the current secure storage approach
- the existing onboarding and wallet flows
- the existing route and controller structure

### Initial Context

After Phase 7.1, another critical stabilization concern was reviewed.

The issue reported was effectively twofold:

- users could lose access to wallet data if the device state was reset or the app was reinstalled without a saved recovery phrase
- the application flow did not sufficiently verify that wallet secrets had actually been persisted before treating the wallet as available

Additionally, on Android there was a platform-specific risk of partial restore behavior where non-sensitive local state could be restored while secure wallet secrets were not.

This created the possibility of an inconsistent application state.

### Risk Profile

This issue was treated as highly sensitive because it affects wallet availability and recovery expectations.

Potential impact included:

- false perception that wallet creation/import had completed safely
- startup into an inconsistent app state
- misleading backup progression when mnemonic data was unavailable
- severe user impact if interpreted as a valid wallet recovery path

Although this was not a cryptographic defect, it was a serious product stability and safety concern.

### Investigation Scope

The investigation focused on the smallest set of layers necessary to harden persistence behavior:

- secure storage write path
- wallet repository persistence flow
- splash/startup wallet availability detection
- Android backup/restore interaction
- backup mnemonic screen safety gating

The following were not redesigned:

- wallet domain model
- onboarding structure
- controller ownership
- feature boundaries
- recovery UX architecture
- account model
- routing architecture

### Root Cause Analysis

#### Root Cause A — No Post-Write Verification

The wallet persistence flow wrote critical wallet data to secure storage and then continued the onboarding/import process without verifying that the write had actually been persisted correctly.

This created the possibility of silent persistence failure.

Under that condition, the app could proceed as if wallet creation or import had succeeded even if critical wallet material was not reliably available afterward.

#### Root Cause B — Inconsistent Restore State Risk on Android

The app also depended on local non-sensitive flags such as wallet-created state to drive routing decisions.

On Android, partial restore scenarios can lead to non-sensitive local state being restored while secure wallet secrets are not.

That creates an inconsistent condition such as:

- wallet-created flag indicates true
- secure mnemonic/private key data is absent

Without defensive validation, the app could misinterpret this as a valid wallet state.

#### Root Cause C — Backup Confirmation Could Advance Without Valid Mnemonic

The backup screen behavior also needed hardening so that backup confirmation could not meaningfully continue in a state where a mnemonic was unavailable.

This was not treated as a feature redesign, but as a correctness and safety fix.

### Applied Fixes

#### Secure Storage Verification

A write-and-verify path was added to the secure storage service for critical wallet persistence operations.

This change ensures that wallet creation/import does not rely only on the write call itself, but also verifies that the value can be read back immediately after persistence.

This hardens:

- mnemonic persistence
- private key persistence
- wallet metadata persistence
- PIN persistence

#### Wallet Repository Hardening

The wallet repository was updated so that wallet availability is only considered valid if the expected secure storage data actually exists and is internally consistent.

The persistence flow now:

- writes critical values through verification
- validates required wallet fields after write
- only marks wallet state as created after secure persistence succeeds
- clears availability flags if persistence validation fails

This prevents success being reported for an invalid or partially persisted wallet state.

#### Splash Startup Validation

The splash/startup path was hardened so that application routing no longer trusts only local boolean state indicating that a wallet exists.

Instead, the wallet profile is loaded from actual persisted secure state before the startup flow decides whether the app should enter the wallet or return to wallet entry.

This prevents startup into Home when the wallet state is inconsistent.

#### Android Backup Interaction Hardening

Android application backup was explicitly disabled to reduce the chance of a partial restore scenario in which local flags are restored independently from secure wallet secrets.

This change does not introduce cross-device recovery.

It simply reduces the likelihood of an invalid partially restored runtime state.

#### Backup Mnemonic Screen Gating

The backup mnemonic screen was also hardened so that users cannot continue the backup confirmation path when a mnemonic is not actually available for the current wallet.

This prevents the UI from implying that backup was successfully completed in a state where the required phrase is missing.

### Files Affected

#### Android Platform Layer

- `android/app/src/main/AndroidManifest.xml`

#### Core Services

- `lib/core/services/secure_storage_service.dart`

#### Wallet Data Layer

- `lib/features/wallet/data/wallet_repository_impl.dart`

#### Startup Flow

- `lib/features/splash/presentation/splash_screen.dart`

#### Wallet Presentation Layer

- `lib/features/wallet/presentation/backup_mnemonic_screen.dart`

### Implementation Characteristics

The Phase 7.2 fix was intentionally designed to be:

- minimal
- defensive
- release-safe
- architecture-preserving
- focused on correctness rather than feature expansion

It does not introduce:

- cloud backup
- remote recovery
- seed export redesign
- new onboarding steps
- account migration systems
- new wallet features

### Validation Performed

#### Local Validation

After applying the persistence hardening changes, wallet creation and wallet availability behavior were validated locally on Android.

The local result indicated that the wallet flow continued to work correctly under the expected path.

#### Internal Testing Follow-Up

The updated build was then made available to the tester group for broader validation on additional devices.

The purpose of the testing round is to confirm:

- wallet creation remains stable
- wallet import remains stable
- startup behavior remains consistent
- no regressions were introduced in normal wallet access flow

### Current Status of Phase 7.2

Phase 7.2 is considered:

- implemented
- locally validated
- pending broader tester confirmation for cross-device and repeated-flow stability

This means the hardening work is complete from an implementation perspective, with tester validation still in progress.

### Release Impact

This fix has high release impact because it reduces the chance of invalid wallet state assumptions in a store-distributed build.

Release impact includes:

- stronger wallet persistence safety
- reduced risk of silent persistence failure
- safer startup state validation
- lower risk of inconsistent restore behavior
- more reliable backup confirmation gating

### Risks and Remaining Considerations

#### Low-to-Moderate Remaining Risk

The code changes are intentionally small, but this area is inherently sensitive because it affects wallet availability semantics.

For that reason, broader tester validation remains important.

#### Important Limitation

Phase 7.2 does not create a new backup system.

It does not make uninstall/reinstall a supported recovery method.

The wallet remains a self-custody wallet in which recovery depends on user-managed mnemonic or private key backup.

This limitation is intentional and consistent with scope control for this stabilization phase.

### What Phase 7.2 Does Not Solve

This subphase does not address:

- cloud or remote backup
- multi-device wallet synchronization
- account export redesign
- backup education UX redesign
- hardware wallet support
- any new recovery product scope

These remain outside the scope of the stabilization-only rules of Phase 7.

### Conclusion

Phase 7.2 hardens wallet persistence and startup consistency without altering the existing architecture or introducing new features.

The resulting behavior is safer, more defensive, and better aligned with release candidate requirements for a self-custody wallet.

This subphase establishes the second stabilization milestone of Phase 7 and significantly reduces the risk of false wallet availability assumptions in RC2 / RC3 validation.

---

## Phase 7.3 — In-App Branding Correction for Splash and Shared Logo Usage

### Objective

Correct the in-app branding regression where the Flutter-rendered application splash was displaying a generic letter-based placeholder instead of the official SCAVIUM brand logo.

The goal of this subphase is to align the visible in-app logo usage with the real project branding while preserving the existing UI structure, widget naming, asset organization, and route flow.

This is a branding-correctness and visual consistency fix, not a redesign effort.

### Initial Context

After stabilizing Android biometrics and wallet persistence behavior, another tester-visible issue was identified in the visual layer.

The problem did not affect the native Android launch screen configuration itself.

Instead, it affected the Flutter-rendered splash and any other screens that reused the shared logo widget inside the app.

The reported symptom was that the application was showing a stylized letter:

- `S`

instead of the actual SCAVIUM logo.

This created a visible mismatch between the packaged brand assets and the runtime UI.

### Reported Problem

The issue reported was specifically:

- the splash shown by the app itself was not using the official SCAVIUM logo
- the logo widget used in the Flutter UI was rendering a placeholder-style branded letter rather than the actual project asset

Because the widget was shared, the inconsistency affected not only the in-app splash but also any other screen using the same reusable component.

### Impact

Although this issue was not functional, it still had meaningful release impact.

Visible effects included:

- inconsistent product branding
- lower perceived release quality
- mismatch between app icon / packaged assets and in-app UI
- avoidable tester-facing polish issue during release candidate validation

Severity:

- low from a runtime perspective
- medium from a release-quality and branding-coherence perspective

### Investigation Scope

The investigation was intentionally restricted to the smallest safe surface:

- shared logo widget implementation
- current asset usage inside the widget
- screens reusing the shared logo widget

The following were explicitly not redesigned:

- splash screen layout
- onboarding layout
- asset folder structure
- widget naming
- route flow
- theme structure
- branding package structure

### Root Cause Analysis

#### Root Cause

The reusable shared logo widget did not render the official SCAVIUM asset.

Instead, it rendered a custom visual placeholder composed in code, centered around a text-based letter mark:

- `S`

This meant the UI was not actually using the branded image assets already available in the project.

Because the widget was shared, every screen depending on that widget inherited the same incorrect branding output.

### Existing Project State

The project already contained the appropriate branding assets and had them declared in `pubspec.yaml`.

That meant the issue was not caused by missing resources, but by the shared widget implementation not using them.

This significantly reduced the risk and scope of the fix.

### Applied Fix

#### Shared Logo Widget Correction

The shared `ScaviumLogo` widget was updated so that it now renders the official square SCAVIUM branding asset instead of the placeholder letter-based composition.

The selected asset path was:

- `assets/branding/icon/scavium-icon.png`

This asset was chosen because it is square and therefore naturally compatible with the existing widget sizing model.

No changes were made to:

- widget name
- widget public API
- call sites
- route flow
- screen structure

#### Asset Strategy

A horizontal logo asset was already available in the project, but it was not selected for this correction because the shared widget is used in square visual contexts.

Using the square icon asset allowed the fix to remain minimal, visually appropriate, and safe without causing layout drift in the splash or onboarding views.

### Files Affected

#### Shared Presentation Layer

- `lib/shared/widgets/scavium_logo.dart`

No other source files were required for the implementation of the fix.

### Implementation Characteristics

The Phase 7.3 correction was intentionally designed to be:

- minimal
- branding-correct
- UI-safe
- backward-compatible
- release-friendly

It does not introduce:

- new assets
- widget renames
- splash layout redesign
- onboarding redesign
- theme changes
- animation changes
- brand-system restructuring

### Validation Performed

#### Local Validation

After updating the shared logo widget and rebuilding the app, the in-app splash and shared logo usage were validated locally.

The application correctly displayed the official SCAVIUM visual identity instead of the previous placeholder-style letter.

This confirmed that the branding regression had been resolved.

#### Internal Testing Follow-Up

The corrected build was also made available to testers for continued release candidate validation as part of the broader stabilization cycle.

The purpose of this follow-up is mainly to confirm visual consistency across:

- different device densities
- different Android versions
- different splash/onboarding render contexts

### Current Status of Phase 7.3

Phase 7.3 is considered:

- implemented
- locally validated
- pending wider tester observation as part of ongoing release candidate testing

This means the implementation work is complete and the regression is considered resolved pending final observational confirmation from the testing group.

### Release Impact

This fix has moderate release impact from a product-quality perspective.

Release impact includes:

- improved in-app branding consistency
- better alignment between packaged identity and runtime UI
- cleaner first impression during splash experience
- improved perceived polish in internal testing builds

### Risks and Remaining Considerations

#### Very Low Remaining Risk

The change affects only a shared presentation widget and does not alter logic, state, navigation, or storage behavior.

That makes the risk profile very low.

#### Remaining Observation Need

As with any shared visual component, tester confirmation remains useful to ensure the branding asset behaves as expected on different screen densities and device sizes.

### What Phase 7.3 Does Not Solve

This subphase does not address:

- native Android splash redesign
- brand-system expansion
- animation polish
- additional marketing screens
- asset pipeline restructuring
- broader UI rework

Those remain outside the scope of this targeted stabilization correction.

### Conclusion

Phase 7.3 resolves an in-app branding regression by replacing a placeholder-style shared logo implementation with the official SCAVIUM asset already present in the project.

The fix preserves the existing UI structure, avoids unnecessary scope expansion, and improves release candidate polish without introducing architectural or functional risk.

This subphase establishes the third stabilization milestone of Phase 7 and reinforces visual consistency across the wallet experience.

---

## Phase 7.4 — Build and Versioning Automation Hardening

### Objective

Standardize the release build process and reduce manual release errors by introducing a project-native build automation tool that manages version increments and multiplatform build execution from a single entry point.

The goal of this subphase is not to redesign deployment infrastructure.

The goal is to harden the existing release workflow so that release candidate iteration becomes more consistent, repeatable, and safer under the current project structure.

This subphase preserves:

- the existing Flutter project layout
- `pubspec.yaml` as the version source of truth
- the current platform targets
- the existing signing/distribution strategy
- the existing release-candidate workflow

### Initial Context

By the time Phase 7.4 began, the application had already entered an active release-candidate cycle.

That created a recurring operational need:

- compile different targets repeatedly
- increment build numbers correctly
- avoid manual release mistakes
- keep versioning aligned with Flutter expectations
- prepare Windows artifacts beyond raw desktop build output

A scripting approach based on PowerShell was considered, but the stabilization criteria of the project favored a solution that remains portable, easier to maintain, and better aligned with the Flutter ecosystem itself.

### Problem Statement

The build and release process still depended on repeated manual execution of commands such as:

- `flutter clean`
- `flutter pub get`
- `flutter build appbundle`
- `flutter build web`
- `flutter build windows`

This created avoidable risks such as:

- forgetting to increment the build number
- inconsistent version tracking between builds
- running different command sets manually per platform
- reduced repeatability during RC iterations
- more friction when producing full multiplatform outputs

### Investigation Scope

The investigation and implementation scope for this subphase was intentionally limited to the build/release tooling layer.

The following areas were included:

- version parsing and update logic
- build orchestration
- multiplatform target selection
- Windows MSIX packaging invocation
- command-line argument handling
- null-safety and fail-fast correctness in the tooling

The following were not redesigned:

- CI/CD infrastructure
- Play Store submission automation
- Microsoft Store publication automation
- signing model
- runtime application architecture
- wallet feature set

### Key Technical Decision

#### Build Tool Implemented in Dart

Instead of using an OS-specific shell or PowerShell script as the primary release tool, build automation was implemented in:

- `tool/build.dart`

This decision was made because a Dart-based tool is:

- more portable
- better aligned with Flutter development workflows
- easier to maintain inside the project itself
- less dependent on host operating system specifics
- better positioned for future CI/CD reuse

### Version Source of Truth

#### pubspec.yaml Remains Authoritative

The build tool uses `pubspec.yaml` as the single source of truth for versioning.

It reads and updates the standard Flutter version format:

- `MAJOR.MINOR.PATCH+BUILD`

This avoids:

- duplicated version sources
- desynchronization between tooling and Flutter metadata
- extra configuration files solely for version control

### Versioning Strategy

The adopted strategy preserves a clear separation between:

- manually controlled semantic version base
- automatically incremented build number

Examples:

- `0.2.1+3`
- `0.2.1+4`
- `0.2.2+1`

Behavior:

- if the base version remains unchanged, the build number increments
- if a new base version is provided, the build number resets to `1`
- an explicit no-bump mode is also supported for cases where version mutation is not desired

### Implemented Build Capabilities

The build tool supports the following targets:

- `android-apk`
- `android-bundle`
- `web`
- `windows`
- `windows-msix`
- `all`

This allows both:

- single-target iterative builds
- full build orchestration from one command

### Windows Packaging Scope

Phase 7.4 also includes support for generating a Windows installer package via MSIX.

This is currently limited to package generation and local release preparation.

It does not yet include Microsoft Store submission automation.

The MSIX step depends on the project already containing a valid:

- `msix` dev dependency
- `msix_config` section in `pubspec.yaml`

### Internal Workflow

The build tool executes a controlled release sequence:

1. parse command-line arguments
2. load and validate `pubspec.yaml`
3. resolve version strategy
4. update `pubspec.yaml` when applicable
5. run `flutter clean` unless skipped
6. run `flutter pub get` unless skipped
7. run the requested build target(s)
8. produce artifact path visibility

This standardizes the release flow and reduces release drift between iterations.

### Null-Safety and Failure Semantics

The final implementation was hardened with strict null-safety and explicit failure semantics.

A key correction in the tool was declaring the error-exit helper using:

- `Never`

instead of `void`

This ensures that:

- Dart flow analysis correctly understands termination paths
- null-safety promotions behave correctly
- the tooling remains robust under static analysis

### Files Affected

#### Tooling Layer

- `tool/build.dart`

#### Package Configuration

- `pubspec.yaml`

### Implementation Characteristics

The Phase 7.4 solution was intentionally designed to be:

- minimal in scope
- native to the project stack
- release-oriented
- portable
- defensive
- easy to extend later

It does not introduce:

- CI/CD workflows
- store upload automation
- automatic changelog generation
- git tagging automation
- release-note automation
- architecture changes in the app itself

### Validation Performed

#### Local Validation

The following real scenarios were executed successfully:

- Android App Bundle build
- full multiplatform build through `all`
- explicit version override
- no-version-bump execution path

This confirmed:

- correct version mutation behavior
- correct argument parsing
- stable execution across supported targets
- proper build orchestration under the expected development environment

### Current Status of Phase 7.4

Phase 7.4 is considered:

- implemented
- locally validated
- operationally ready for continued release-candidate usage

This means the subphase is complete from an implementation standpoint and already useful in the real release workflow.

### Release Impact

This subphase has meaningful release-process impact because it reduces operational mistakes without touching runtime application behavior.

Release impact includes:

- more repeatable build execution
- safer version handling
- lower manual error rate
- faster RC iteration
- improved Windows packaging readiness
- stronger foundation for future CI/CD

### Risks and Remaining Considerations

#### Low Remaining Risk

The tool operates outside the runtime app itself, so the product risk is relatively low.

Its main importance is operational correctness rather than feature correctness.

#### Remaining Future Work

Future work may extend this foundation toward:

- GitHub Actions or similar CI/CD integration
- Google Play upload automation
- Microsoft Store submission readiness
- release metadata automation

Those items remain intentionally outside the scope of Phase 7.4.

### What Phase 7.4 Does Not Solve

This subphase does not address:

- automated store publishing
- remote CI runners
- signing secret management in CI
- automatic release notes
- automatic git version tagging
- cross-repository release orchestration

These remain follow-up concerns for future release engineering phases.

### Conclusion

Phase 7.4 hardens the build and versioning workflow by introducing a Dart-native build tool that centralizes version handling and multiplatform build execution while preserving the current project structure and release model.

The result is a safer, more repeatable, and more scalable release workflow for ongoing RC stabilization.

This subphase establishes the fourth stabilization milestone of Phase 7 and prepares the project for future CI/CD and store-automation work without introducing unnecessary complexity at this stage.