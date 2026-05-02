# Current Task — 9.6.4

Project: SCAVIUM Wallet
Phase: 9.6 — Settings and About UX Alignment
Subphase: 9.6.4 — About Identity and Responsive Settings Review
Type: Code-only

## Goal

Ensure the About identity surface remains clear, dynamic, and responsive after Settings polish.

## Scope

- Keep About display tied to `appVersionInfoProvider`.
- Improve About placement/copy/responsive behavior only if it strengthens the Settings hierarchy.
- Validate Settings remains usable on mobile, desktop, and web widths.
- Avoid creating a separate About route unless real implementation evidence clearly requires it.

## Allowed Files

- `lib/features/settings/presentation/settings_screen.dart`
- `lib/features/settings/presentation/widgets/settings_section_card.dart`
- `test/settings_screen_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- Before editing, read only the allowed files needed for this subphase plus `.agent/rules.md` and `.agent/commands.md`.
- Consume `appVersionInfoProvider`; do not duplicate package/version resolution.
- Preserve Appearance selector, security/recovery, signing, diagnostics, and danger-zone actions.
- Do not modify app identity provider internals unless a test-proven bug is directly blocking this subphase.
- Do not modify docs, `.agent/*`, routing, release tooling, platform files, generated files, or unrelated tests.
- Add or adjust focused tests for About/version display and Settings responsiveness where feasible.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/settings_screen_test.dart
```

## Acceptance

- About clearly shows SCAVIUM Wallet identity and dynamic version info.
- Settings remains coherent at narrow and wide widths.
- Version display still comes from `appVersionInfoProvider`.
- Existing Settings actions and Appearance selector remain available.
