# SCAVIUM Wallet — Development

## 🧭 Overview

Development follows a structured, phase-based approach to ensure stability and incremental progress.

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
2. Implement feature
3. Integrate with existing architecture
4. Test manually
5. Consolidate phase

---

## 🧠 Principles

- Do not break existing functionality
- Maintain naming consistency
- Prefer extension over refactoring
- Keep controllers focused

---

## 🔗 RPC Development

- Always use ScaviumRpcService
- Never call RPC directly from UI
- Respect read/write separation

---

## 🧪 Testing Strategy

Currently:

- manual testing
- real-node validation

Future:

- unit tests
- integration tests

---

## 🎯 Goal

Maintain a stable, scalable and predictable codebase.