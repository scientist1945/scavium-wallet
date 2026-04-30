# Validation Commands — SCAVIUM Wallet

## Primary Validation

```bash
fvm flutter analyze
```

## Scoped Test — Use ONLY when the subphase defines a test file

```bash
fvm flutter test test/<subphase_test_file>.dart
```

## Optional Format — Only on modified Dart files (DO NOT use ".")

```bash
dart format <modified-dart-files>
```

## Full Test — ONLY at phase closure or when explicitly requested

```bash
fvm flutter test
```

## Fallback if FVM is unavailable

```bash
flutter analyze
flutter test test/<subphase_test_file>.dart
```

## Git Commands Template — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-8.2-assets-portfolio-expansion

# For EACH approved subphase (8.2.1, 8.2.2, etc.)
git status
git add <modified-files>
git commit -m "Phase 8.2.x - <subphase title>"

# ONLY after full Phase 8.2 completion
git checkout main
git pull
git merge phase-8.2-assets-portfolio-expansion
git branch -d phase-8.2-assets-portfolio-expansion
```