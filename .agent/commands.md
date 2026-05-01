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
fvm flutter test test/signing_request_test.dart test/signing_controller_test.dart test/signing_screen_test.dart test/wallet_backup_payload_test.dart
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
git checkout -b feature/phase-8.5-security-reliability-diagnostics-maturity

git status
git add <modified-files>
git commit -m "Phase 8.5 - Security reliability and diagnostics maturity"

git checkout main
git pull
git merge feature/phase-8.5-security-reliability-diagnostics-maturity
git branch -d feature/phase-8.5-security-reliability-diagnostics-maturity
```
