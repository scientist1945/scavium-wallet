# Current Task — 8.4.close

Project: SCAVIUM Wallet
Phase: 8.4 — UX & Product Surface Maturity
Subphase: 8.4.close — UX & Product Surface Maturity Closure
Type: documentation-closure / not code-only

## Goal

No code work. Closure must be performed by a documentation prompt after 8.4.1 through 8.4.5 are implemented and validated.

## Scope

Do not execute this with Codex code-only mode. It is a reminder that Phase 8.4 closure updates trunk docs from the real implemented state.

## Allowed Files

- No code files. This task is documentation-only and belongs to a separate closure prompt.

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Do not modify code.
- Do not modify documentation from Codex code-only mode.
- Use a separate documentation prompt with ZIP source of truth for closure.

## Validation (manual)

```bash
# No Codex command. Closure validation is handled outside code-only mode.
```

## Acceptance

Phase closure is not attempted by code-only agent files.
