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
fvm flutter test test/app_theme_tokens_test.dart test/app_shell_test.dart test/settings_screen_test.dart
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
flutter test test/app_theme_tokens_test.dart test/app_shell_test.dart test/settings_screen_test.dart
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.4-light-dark-theme-implementation

git status
git add <modified-files>
git commit -m "phase 9.4: implement light dark themes"

git checkout main
git pull
git merge phase-9.4-light-dark-theme-implementation
git branch -d phase-9.4-light-dark-theme-implementation
```
