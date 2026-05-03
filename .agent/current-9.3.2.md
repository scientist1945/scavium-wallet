# Current Task — 9.3.2

Project: SCAVIUM Wallet
Phase: 9.3 — Theme Token Normalization
Subphase: 9.3.2 — Core SCAVIUM Token Model Implementation
Type: Code-only implementation

## Goal

Normalize and harden the SCAVIUM token model created in 9.3.1 so brand, background, surface, border/divider, text, semantic, interaction, shape, spacing, elevation, and typography tokens are explicit, centralized, and ready for shared-widget adoption.

## Scope

- Work inside the existing `lib/app/theme` boundary.
- Preserve current dark runtime behavior.
- Keep `AppColors` and `AppTextStyles` as backwards-compatible facades unless a specific alias is proven unused and removal is explicitly approved.
- Do not add light theme, theme mode persistence, Settings appearance controls, release behavior, routing, wallet, asset, transaction, signing, backup, restore, or diagnostics changes.

## Allowed Files

- `lib/app/theme/tokens/scavo_colors.dart`
- `lib/app/theme/tokens/scavo_spacing.dart`
- `lib/app/theme/tokens/scavo_radius.dart`
- `lib/app/theme/tokens/scavo_elevation.dart`
- `lib/app/theme/tokens/scavo_typography.dart`
- `lib/app/theme/tokens/scavo_tokens.dart`
- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_text_styles.dart`
- `lib/app/theme/app_theme.dart`
- `test/app_theme_tokens_test.dart`

## Forbidden

- docs/**
- README.md
- Any unrelated file

## Implementation Requirements

- First read only the allowed theme/token/test files.
- Treat 9.3.1 token files as the baseline, not as throwaway scaffolding.
- Improve token family completeness and naming clarity with the smallest compatible changes.
- Ensure tokens describe UI intent, not raw color names or component-specific names.
- Keep `AppTheme.darkTheme` dark-only and functionally stable.
- Extend `test/app_theme_tokens_test.dart` only for token invariants/mappings that can be validated cheaply.
- Do not change shared widgets unless a token-model compile issue requires it; shared-widget adoption belongs to 9.3.3.

## Validation (manual)

```bash
fvm flutter analyze
fvm flutter test test/app_theme_tokens_test.dart
```

## Acceptance

- Token families are explicit and centralized under `lib/app/theme/tokens/`.
- Legacy facades still work for existing consumers.
- `AppTheme.darkTheme` still builds from tokenized values.
- No light-mode, Settings, persistence, routing, release, or feature-flow behavior is introduced.
- No documentation is modified.