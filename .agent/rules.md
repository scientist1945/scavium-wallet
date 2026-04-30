
---

# `.agent/rules.md`

```md
# Agent Rules — SCAVIUM Wallet

## Execution Mode

- Code-only execution.
- Do not create, edit, rewrite, summarize, or reformat documentation.
- Do not modify `README.md`, `docs/**`, `privacy.md`, `tyc.md`, or release/distribution documentation.
- Work only from the real VSCode working tree.
- Do not assume files or APIs that are not present in the repository.
- Do not implement outside the active `.agent/current*.md` task.
- Prefer the smallest safe change that satisfies the active task.
- Preserve existing architecture, naming, routing style, Riverpod patterns, and UI conventions.

## Formatting Rules

- Do not run `dart format .`.
- If formatting is needed, run `dart format` only on modified Dart files.
- Do not format unrelated files.
- Do not reformat documentation.

## Validation Rules

- Run `fvm flutter analyze` as the primary validation command.
- Run only the scoped test declared by the active `.agent/current*.md`, when present.
- Do not run the full `fvm flutter test` suite unless explicitly requested or at phase closure.
- If the full suite fails due to an unrelated test, report the failing test and do not change unrelated files.

## Git Rules

- Use one accumulative branch for the whole phase unless instructed otherwise.
- Current phase branch: `phase-8.2-assets-portfolio-expansion`.
- Commit each approved subphase separately.
- Do not merge to `main` until the full phase is accepted.

## Before Editing

Report only:

1. Files read
2. Files proposed for modification
3. Short implementation plan
4. Validation commands to run

Wait for user approval before editing.

## After Editing

Report only:

1. Exact modified files
2. Short diff summary
3. Validation results
4. Any remaining blocker, if applicable

## Context Discipline

- Do not scan the entire repository unless the active task explicitly requires it.
- Read only the files needed for the active task.
- Use the paths listed in the active current file first.
- If extra files are needed, explain why before reading/editing them.