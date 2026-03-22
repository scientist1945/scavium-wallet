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