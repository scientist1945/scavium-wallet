# Validation Commands — SCAVIUM Wallet

## IMPORTANT

All commands are executed manually by the user.

The agent MUST NOT execute any commands.

---

## Analyze

```bash
fvm flutter analyze
```

---

## Scoped Test

```bash
fvm flutter test test/tx_history_entry_test.dart test/tx_history_controller_test.dart
```

---

## Optional Format

```bash
dart format <modified-dart-files>
```

---

## Full Test (only at phase closure)

```bash
fvm flutter test
```

---

## Fallback

```bash
flutter analyze
flutter test
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b feature/phase-8.3-transaction-activity-maturity

git status
git add <modified-files>
git commit -m "Phase 8.3 - Transaction and activity maturity"

git checkout main
git pull
git merge feature/phase-8.3-transaction-activity-maturity
git branch -d feature/phase-8.3-transaction-activity-maturity
```