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
fvm flutter test test/settings_screen_test.dart test/theme_mode_selector_test.dart test/theme_mode_preference_test.dart
```

---

## Optional Format

```bash
dart format lib/features/settings/presentation/settings_screen.dart lib/features/settings/presentation/widgets/settings_section_card.dart lib/features/settings/presentation/widgets/theme_mode_selector.dart lib/app/theme/theme_mode_preference.dart test/settings_screen_test.dart test/theme_mode_selector_test.dart test/theme_mode_preference_test.dart
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
fvm flutter test test/theme_mode_selector_test.dart
fvm flutter test test/theme_mode_preference_test.dart
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.6-settings-about-ux-alignment

git status
git add <modified-files>
git commit -m "Phase 9.6 settings and about UX alignment"

git checkout main
git pull
git merge phase-9.6-settings-about-ux-alignment
git branch -d phase-9.6-settings-about-ux-alignment
```
