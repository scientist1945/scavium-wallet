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
dart run tool/build.dart --check-version --expected-tag v0.2.1
# Optional release-tool checks only when secrets/platform prerequisites exist:
# dart run tool/build.dart --platform android-apk --no-version-bump
# dart run tool/build.dart --platform android-bundle --no-version-bump
# dart run tool/build.dart --platform windows-msix --no-version-bump
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-8.6-release-distribution-maturity-extension

git status
git add <modified-files>
git commit -m "phase 8.6 release distribution maturity"

git checkout main
git pull
git merge phase-8.6-release-distribution-maturity-extension
git branch -d phase-8.6-release-distribution-maturity-extension
```