# Current Task — Phase 8.2.3

Project: SCAVIUM Wallet
Phase: 8.2 — Asset & Portfolio Expansion
Subphase: 8.2.3 — Manual Token Safety & Metadata UX
Type: code

## Goal

Harden manual ERC-20 token registration UX and safety using the existing token registry and RPC metadata loading flow.

## Scope

Improve deterministic input handling, duplicate handling, metadata error presentation, and safe empty/loading/error states around manual token registration.

## Allowed Files

- `lib/features/assets/application/token_registry_controller.dart`
- `lib/features/assets/data/token_registry_repository_impl.dart`
- `lib/features/assets/domain/token_info.dart`
- `lib/features/assets/presentation/add_token_screen.dart`
- `lib/features/assets/presentation/assets_screen.dart`
- `lib/shared/widgets/feedback/**` only if strictly needed
- `test/**` only for focused tests if needed

## Forbidden

- `docs/**`
- `README.md`
- wallet persistence changes
- backup format changes
- automatic token discovery
- multi-chain support
- broad UI redesign
- routing changes unless unavoidable and approved

## Implementation Requirements

- Normalize token contract input consistently.
- Prevent duplicate tokens deterministically.
- Surface invalid contract/metadata errors safely.
- Preserve existing manual token registry storage format unless a compatible normalization is needed.
- Keep existing native asset and token list behavior intact.

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

- Invalid token input is rejected before RPC metadata loading.
- Duplicate token additions do not create duplicate registry entries.
- Metadata/RPC failures are user-visible and non-destructive.
- No documentation files are modified.
- Validation passes or remaining failures are unrelated and explicitly reported.
