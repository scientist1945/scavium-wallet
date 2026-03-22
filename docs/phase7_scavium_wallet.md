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

---

## Initial Context

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

---

## Reported Problem

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

---

## Investigation Scope

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

---

## Root Cause Analysis

### Root Cause

The primary root cause was that the Android entry activity was still implemented using:

- `FlutterActivity`

For the configured biometric integration, Android biometric authentication required:

- `FlutterFragmentActivity`

Because of that mismatch, the biometric flow was not correctly supported on Android devices even though the rest of the application logic and permissions were already largely in place.

---

## Secondary Validation

During review, the Android manifest was also checked.

The project already had the relevant biometric permissions and embedding configuration in place, including:

- `USE_BIOMETRIC`
- `USE_FINGERPRINT`
- Flutter embedding v2 metadata

This confirmed that the main regression was not caused by missing Android manifest setup, but by the activity class mismatch.

---

## Applied Fix

### Android Activity Update

The Android entry activity was updated from:

- `FlutterActivity`

to:

- `FlutterFragmentActivity`

This was the central fix of Phase 7.1.

The existing screenshot-protection `MethodChannel` behavior was preserved.

No changes were made to the channel name, method names, or security flag logic.

### Biometric Service Validation

The biometric service flow was also aligned with a safer authentication path by ensuring the service checks the platform support conditions before attempting authentication.

The authentication call remained minimal and consistent with the existing architecture.

Key behavioral expectations of the service after stabilization:

- fail safely when biometrics are unavailable
- avoid architecture changes
- preserve the lock flow
- remain Android-compatible under the existing UI/controller structure

---

## Files Affected

### Android Platform Layer

- `android/app/src/main/kotlin/com/geryon/scavium_wallet/MainActivity.kt`

### Dart Service Layer

- `lib/core/services/biometric_auth_service.dart`

No other files were required for the core fix.

---

## Implementation Characteristics

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

---

## Validation Performed

### Local Validation

After correctly applying the Android activity change and rebuilding the application, biometric unlock was successfully validated locally on Android using fingerprint authentication.

This confirmed that the main issue had been effectively resolved.

### Internal Testing Follow-Up

After local validation, the updated build was made available again to the internal testing group through the existing Play Store Internal Testing workflow for cross-device confirmation.

The purpose of this follow-up validation is to verify behavior across:

- different Android versions
- different device manufacturers
- different biometric hardware combinations

---

## Current Status of Phase 7.1

Phase 7.1 is considered:

- implemented
- locally validated
- pending broader tester confirmation for cross-device stability

This means the subphase is technically complete from an implementation perspective, while still remaining under observational validation until feedback from the tester group is consolidated.

---

## Release Impact

This fix is important for release candidate quality because it restores the intended Android biometric unlock path without requiring broader rework.

Release impact:

- improves Android unlock reliability
- removes a reported tester regression
- reduces friction in secure access flow
- supports progression toward RC2 / RC3 stabilization

---

## Risks and Remaining Considerations

### Low Remaining Risk

The applied fix is low risk because it changes only the Android activity base class and keeps the rest of the system intact.

### Remaining Validation Need

The only remaining uncertainty is device-specific variance across the Android ecosystem.

That is normal for a biometric stabilization fix and is already covered by the tester validation round.

---

## What Phase 7.1 Does Not Solve

This subphase does not address:

- wallet persistence verification after creation/import
- uninstall/reinstall recovery expectations
- backup enforcement strategy
- transaction runtime issues unrelated to lock/auth
- future biometric UX refinements

Those concerns remain outside the scope of Phase 7.1 and belong to subsequent stabilization work inside Phase 7.

---

## Conclusion

Phase 7.1 successfully identifies and resolves the Android biometric unlock regression through a minimal, release-safe platform fix.

The implemented correction restores biometric compatibility on Android without altering the established architecture or introducing any new functional scope.

This subphase establishes the first stabilization milestone of Phase 7 and provides a stronger base for the next release candidate validation cycle.