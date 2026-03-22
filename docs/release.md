# SCAVIUM Wallet — Release

## 🧭 Overview

This document describes the release process and release hardening path for SCAVIUM Wallet.

---

## 📦 Current State

The wallet has completed packaging and initial store distribution.

Current release state:

- packaged and signed
- distributed through Google Play Internal Testing
- under release candidate stabilization in Phase 7

---

## 🏗️ Release Steps

### Phase 6

1. Configure app metadata
2. Define branding (icons, splash)
3. Configure build targets
4. Setup signing (Android / iOS)
5. Generate production builds
6. Prepare store assets
7. Publish to internal testing

### Phase 7

1. collect tester feedback
2. identify regressions
3. apply minimal corrective patches
4. validate on real devices
5. prepare next release candidate

---

## 🔐 Signing

- Android keystore required
- iOS certificates required

---

## 📱 Targets

- Android
- iOS
- Web (optional)

---

## 🧪 Release Candidate Validation

The current release process now includes:

- internal testing on Play Store
- real-device Android validation
- regression verification
- stabilization before broader rollout

Phase 7.1 specifically validated:

- Android biometric unlock recovery after a production-distributed regression

Phase 7.2 specifically validated:

- hardened wallet persistence behavior
- startup consistency under real persisted-state checks
- safer backup progression behavior

---

## 🧠 Notes

- Ensure RPC endpoints are production-ready
- Disable debug logs
- Validate transaction flows
- Validate lock/unlock flows on real devices
- Prefer minimal patches during release stabilization
- Treat uninstall/reinstall recovery assumptions carefully in self-custody flows

---

## 🎯 Goal

Deliver a stable, secure and production-ready build with controlled regression handling between release candidates.