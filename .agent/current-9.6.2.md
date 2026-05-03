# Current Task — 9.6.2

Project: SCAVIUM Wallet
Phase: 9.6 — Settings and About UX Alignment
Subphase: 9.6.2 — Settings/About Information Architecture Polish
Type: Code-only

## Goal

Refine Settings/About section hierarchy so Appearance, security/recovery, signing, diagnostics, danger-zone actions, and About read as one coherent Settings surface.

## Scope

- Improve section order, spacing, copy, and grouping without changing behavior.
- Preserve Appearance selector visibility and current theme-mode ownership.
- Preserve dynamic About version display through the existing app identity provider.
- Preserve backup export, signing route, diagnostics route, and reset action availability.

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
- Keep `ThemeModeSelector` consumed by Settings; do not move persistence or app-root theme selection into Settings.
- Do not modify `theme_mode_controller.dart`, repositories, storage keys, app root, routing, token/theme construction, docs, `.agent/*`, release tooling, platform files, or generated files.
- Prefer layout/copy/card hierarchy changes over new abstractions.
- Add or adjust focused tests for visible section hierarchy and preserved actions.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/settings_screen_test.dart
```

## Acceptance

- Settings shows a coherent ordered surface with Appearance, security/recovery, signing, diagnostics, danger-zone, and About sections.
- Existing user actions remain reachable.
- About still renders dynamic version data from the provider.
- No theme-mode ownership or persistence is reimplemented.
