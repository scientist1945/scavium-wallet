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

---

## 🔁 Development Flow

1. Define phase scope
2. Implement feature or corrective fix
3. Integrate with existing architecture
4. Test manually on real targets
5. Consolidate phase
6. document release impact

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

This rule was applied directly in Phase 7.1 for the Android biometric fix.

---

## 🧪 Testing Strategy

Currently:

- manual testing
- real-device validation
- internal tester feedback through Play Store Internal Testing

Future:

- unit tests
- integration tests

---

## 🎯 Goal

Maintain a stable, scalable and predictable codebase while hardening release candidates safely.