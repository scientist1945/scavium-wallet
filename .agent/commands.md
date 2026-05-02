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
fvm flutter test test/settings_screen_test.dart test/app_version_info_test.dart
```

---

## Optional Format

```bash
dart format lib/core/app_identity/app_version_info.dart lib/core/app_identity/app_version_provider.dart lib/features/settings/presentation/settings_screen.dart test/settings_screen_test.dart test/app_version_info_test.dart
```

---

## Full Test (only at phase closure)

```bash
fvm flutter test
```

---

## Fallback

```bash
fvm flutter test test/settings_screen_test.dart
fvm flutter analyze
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.1-runtime-app-version-surface

git status
git add <modified-files>
git commit -m "phase 9.1 runtime app version surface"

git checkout main
git pull
git merge phase-9.1-runtime-app-version-surface
git branch -d phase-9.1-runtime-app-version-surface
```