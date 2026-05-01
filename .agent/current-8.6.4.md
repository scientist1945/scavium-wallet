# Current Task — 8.6.4

Project: SCAVIUM Wallet
Phase: 8.6 — Release & Distribution Maturity Extension
Subphase: 8.6.4 — Distribution Metadata and Store-Readiness Documentation
Type: documentation-only handoff

## Goal

Handle distribution metadata and store-readiness documentation through a separate documentation prompt, not this code-only Codex flow.

## Scope

Do not edit documentation from this agent flow. Only flag any real `pubspec.yaml` metadata inconsistency if it blocks release correctness.

## Allowed Files

- `pubspec.yaml`

## Forbidden

- docs/**
- README.md
- .agent/**
- Any unrelated file
- Build/distribution outputs
- Git operations

## Implementation Requirements

- Do not edit docs or README.
- Inspect `pubspec.yaml` only if the user explicitly asks for metadata correction.
- Do not add automatic Play Store upload, Microsoft Store submission, iOS distribution, or in-app update orchestration.
- If documentation needs updates, stop and hand off to a documentation-only prompt.

## Validation (manual)

```bash
No command required unless `pubspec.yaml` is changed.
If changed: fvm flutter analyze
```

## Acceptance

No documentation is modified by the code-only flow; any metadata correction is minimal and justified by real release configuration.