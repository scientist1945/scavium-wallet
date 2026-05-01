# Validation Commands — {{PROJECT_NAME}}

## IMPORTANT

All commands are executed manually by the user.

The agent MUST NOT execute any commands.

---

## Analyze

```bash
{{ANALYZE_COMMAND}}
```

---

## Scoped Test

```bash
{{SCOPED_TEST_COMMAND}}
```

---

## Optional Format

```bash
{{FORMAT_COMMAND}}
```

---

## Full Test (only at phase closure)

```bash
{{FULL_TEST_COMMAND}}
```

---

## Fallback

```bash
{{FALLBACK_COMMANDS}}
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b {{PHASE_BRANCH}}

git status
git add <modified-files>
git commit -m "{{COMMIT_MESSAGE}}"

git checkout main
git pull
git merge {{PHASE_BRANCH}}
git branch -d {{PHASE_BRANCH}}
```