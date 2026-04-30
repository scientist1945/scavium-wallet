# Validation Commands — SCAVIUM Wallet

## Primary Validation

```bash
fvm flutter analyze
fvm flutter test
```

## Fallback if FVM is unavailable

```bash
flutter analyze
flutter test
```

## Git Commands Template

```bash
git checkout main
git pull
git checkout -b phase-8.2-assets-portfolio-expansion

# after approved implementation and validation
git status
git add <modified-files>
git commit -m "Phase 8.2 - Asset and portfolio expansion"

git checkout main
git merge phase-8.2-assets-portfolio-expansion
git branch -d phase-8.2-assets-portfolio-expansion
```
