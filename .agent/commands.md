# Validation Commands — SCAVIUM Wallet

## IMPORTANT

All commands must be executed manually by the user in the VSCode terminal.

The agent MUST NOT execute any shell commands.

---

## Analyze

```bash
fvm flutter analyze
```

---

## Scoped Test (Recommended)

```bash
fvm flutter test test/<subphase_test_file>.dart
```

---

## Optional Format (Only if needed)

```bash
dart format <modified-dart-files>
```

---

## Full Test (ONLY at phase closure or if explicitly requested)

```bash
fvm flutter test
```

---

## Fallback if FVM is unavailable

```bash
flutter analyze
flutter test test/<subphase_test_file>.dart
```

---

## Git Commands — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-8.2-assets-portfolio-expansion

# For each approved subphase (8.2.1, 8.2.2, etc.)
git status
git add <modified-files>
git commit -m "Phase 8.2.x - <subphase title>"

# Only after full Phase 8.2 completion
git checkout main
git pull
git merge phase-8.2-assets-portfolio-expansion
git branch -d phase-8.2-assets-portfolio-expansion
```