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
fvm flutter test test/widget_test.dart
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
git checkout -b feature/phase-8.4-ux-product-surface-maturity

git status
git add <modified-files>
git commit -m "Phase 8.4 - UX and product surface maturity"

git checkout main
git pull
git merge feature/phase-8.4-ux-product-surface-maturity
git branch -d feature/phase-8.4-ux-product-surface-maturity
```
