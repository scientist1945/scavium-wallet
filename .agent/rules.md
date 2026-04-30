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

## Command Execution Rules

- Do not execute any shell commands.
- Do not run `dart`, `flutter`, or `fvm` commands.
- Only report the commands to be executed manually by the user.
- The user will run validation commands in the VSCode terminal.

## Formatting Rules

- Do not run `dart format .`.
- If formatting is needed, only suggest:
  `dart format <modified-dart-files>`
- Do not format unrelated files.

## Validation Rules

- Always suggest running `fvm flutter analyze`.
- Suggest scoped tests only:
  `fvm flutter test test/<subphase_test_file>.dart`
- Do not suggest running the full test suite unless explicitly requested.
- If a failing test is unrelated to the subphase, report it but do not modify unrelated code.

## Git Rules

- Use a single accumulative branch for the entire phase.
- Current branch:
  `phase-8.2-assets-portfolio-expansion`
- Commit per approved subphase.
- Do not merge to `main` until the full phase is accepted.

## Before Editing

Report only:

1. Files read
2. Files proposed for modification
3. Short implementation plan
4. Commands the user should run manually

Wait for user approval before editing.

## After Editing

Report only:

1. Exact modified files
2. Short diff summary
3. Suggested commands to run manually
4. Any remaining blocker, if applicable

## Context Discipline

- Do not scan the entire repository unless required.
- Read only necessary files.
- Prioritize paths listed in `.agent/current*.md`.
- If additional files are needed, explain why first.