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
fvm flutter test test/theme_mode_preference_test.dart test/theme_mode_controller_test.dart test/settings_screen_test.dart
```

---

## Optional Format

```bash
dart format lib/app/app.dart lib/app/theme/theme_mode_preference.dart lib/app/theme/theme_mode_repository.dart lib/app/theme/theme_mode_repository_impl.dart lib/app/theme/theme_mode_controller.dart lib/core/constants/storage_keys.dart lib/core/providers/service_providers.dart lib/features/settings/presentation/settings_screen.dart lib/features/settings/presentation/widgets/theme_mode_selector.dart test/theme_mode_preference_test.dart test/theme_mode_controller_test.dart test/settings_screen_test.dart test/theme_mode_selector_test.dart
```

---

## Full Test (only at phase closure)

```bash
fvm flutter test
```

---

## Fallback

```bash
fvm flutter test test/theme_mode_preference_test.dart
fvm flutter test test/theme_mode_controller_test.dart
fvm flutter test test/settings_screen_test.dart
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.5-theme-mode-runtime-selection-persistence

git status
git add <modified-files>
git commit -m "Phase 9.5 theme mode runtime selection and persistence"

git checkout main
git pull
git merge phase-9.5-theme-mode-runtime-selection-persistence
git branch -d phase-9.5-theme-mode-runtime-selection-persistence
```