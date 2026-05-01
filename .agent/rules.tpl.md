# Agent Rules — {{PROJECT_NAME}}

## Execution Mode

- Code-only execution.
- Do not create, edit, rewrite, summarize, or reformat documentation.
- Do not modify `README.md`, `docs/**`, or any Markdown unless explicitly allowed.
- Work only from the real VSCode working tree.
- Do not assume files, APIs, or structures that are not present.
- Do not implement outside the active `.agent/current*.md` task.
- Prefer the smallest safe change.
- Preserve architecture, naming, routing, state management, and UI patterns.

## Command Execution Rules

- Do not execute any shell commands.
- Do not run `dart`, `flutter`, `fvm`, or any CLI tools.
- Only report commands for the user to run manually.
- The user will run validation commands in the VSCode terminal.

## Formatting Rules

- Do not run `dart format .`.
- If needed, suggest:
  `dart format <modified-dart-files>`
- Do not format unrelated files.

## Validation Rules

- Suggest primary validation commands defined in `.agent/commands.md`.
- Suggest scoped tests only if defined in the current task.
- Do not suggest full test suite unless explicitly requested.
- If a failure is unrelated, report it without modifying unrelated code.

## Git Rules

- Use a single accumulative branch per phase.
- Current branch: `{{PHASE_BRANCH}}`
- Commit per subphase.
- Merge only after full phase completion.

## Before Editing

Report:

1. Files read
2. Files to modify
3. Short plan
4. Commands to run manually

Wait for approval.

## After Editing

Report:

1. Modified files
2. Diff summary
3. Suggested commands
4. Blockers if any

## Context Discipline

- Do not scan entire repo unless needed.
- Read only necessary files.
- Prioritize paths in `.agent/current*.md`.