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
fvm flutter test test/app_theme_tokens_test.dart test/widget_test.dart
```

---

## Optional Format

```bash
fvm dart format lib/app/theme lib/shared/widgets test/app_theme_tokens_test.dart
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
flutter test test/app_theme_tokens_test.dart test/widget_test.dart
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.3-theme-token-normalization

git status
git add <modified-files>
git commit -m "Phase 9.3 theme token normalization"

git checkout main
git pull
git merge phase-9.3-theme-token-normalization
git branch -d phase-9.3-theme-token-normalization
```