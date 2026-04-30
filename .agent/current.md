# Current Task — Phase 8.2.1

Project: SCAVIUM Wallet
Phase: 8.2 — Asset & Portfolio Expansion
Subphase: 8.2.1 — Portfolio Summary Model Foundation
Type: code

## Goal

Introduce a minimal portfolio summary foundation derived from existing `AssetItem` data, without changing persistence, token discovery, wallet storage, backup format, or documentation.

## Scope

Implement a small domain/application foundation that can summarize visible assets for UI use.

## Allowed Files

- `lib/features/assets/domain/**`
- `lib/features/assets/application/**`
- `lib/features/assets/presentation/assets_screen.dart`
- `test/**` only for focused tests if needed

## Forbidden

- `docs/**`
- `README.md`
- `lib/features/wallet/data/**`
- `lib/features/wallet/domain/wallet_profile.dart`
- `lib/features/wallet/domain/wallet_account.dart`
- backup format changes
- storage key changes
- automatic token discovery
- multi-chain support
- large UI shell/navigation redesign

## Implementation Requirements

- Keep native balance behavior intact.
- Keep existing ERC-20 token registry behavior intact.
- Do not remove existing asset list behavior.
- Add a deterministic summary representation only if it can be computed from current assets.
- Keep empty/loading/error states safe.
- Avoid broad refactors.

## Validation

Run:

```bash
fvm flutter analyze
fvm flutter test
```

Fallback:

```bash
flutter analyze
flutter test
```

## Acceptance

- Existing assets screen still loads native and manual ERC-20 items.
- Portfolio summary foundation exists and is used or ready for use without unstable assumptions.
- No documentation files are modified.
- Validation passes or remaining failures are unrelated and explicitly reported.
