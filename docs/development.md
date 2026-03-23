# SCAVIUM Wallet — Development

## 🧭 Overview

Development follows a structured, phase-based approach to ensure stability and incremental progress.

From Phase 7 onward, development also includes a stabilization discipline oriented to release candidate quality.

---

## 🧱 Tech Stack

- Flutter
- Dart
- Riverpod
- Web3dart

---

## 📂 Project Structure

lib/
  app/
  core/
  shared/
  features/
tool/

---

## 🔁 Development Flow

1. Define phase scope
2. Implement feature or corrective fix
3. Integrate with existing architecture
4. Test manually on real targets
5. Consolidate phase
6. Document release impact

---

## 🧠 Principles

- Do not break existing functionality
- Maintain naming consistency
- Prefer extension over refactoring
- Keep controllers focused
- During stabilization, prefer minimal and isolated fixes

---

## 🔗 RPC Development

- Always use ScaviumRpcService
- Never call RPC directly from UI
- Respect read/write separation

---

## 🔒 Stabilization Rules

During Phase 7:

- do not redesign architecture
- do not rename existing structures
- do not introduce new features while fixing regressions
- prefer service-layer or platform-layer patches when possible
- validate fixes on real devices when the issue is platform-specific

These rules were applied directly in:

- Phase 7.1 for the Android biometric fix
- Phase 7.2 for wallet persistence hardening and startup-state validation
- Phase 7.3 for the shared-logo branding correction
- Phase 7.4 for build and versioning automation hardening

---

## 🛠️ Build System

The project includes a custom build tool located at:

tool/build.dart

### Main responsibilities

- parse release/build arguments
- read version from `pubspec.yaml`
- increment build numbers safely
- optionally override semantic version base
- run multiplatform Flutter builds
- invoke MSIX packaging when requested

### Typical usage

Full build:

    dart run tool/build.dart --platform all

Android App Bundle only:

    dart run tool/build.dart --platform android-bundle

Version override:

    dart run tool/build.dart --platform all --version 0.2.2

No version bump:

    dart run tool/build.dart --platform web --no-version-bump

### Supported targets

- android-apk
- android-bundle
- web
- windows
- windows-msix
- all

---

## 🧪 Testing Strategy

Currently:

- manual testing
- real-device validation
- internal tester feedback through Play Store Internal Testing
- local validation of build automation scenarios

Future:

- unit tests
- integration tests
- CI/CD pipeline validation

---

## 🎯 Goal

Maintain a stable, scalable and predictable codebase while hardening release candidates safely and making release operations more repeatable.