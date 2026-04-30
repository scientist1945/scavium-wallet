# Current Task — Phase 8.2.2

Project: SCAVIUM Wallet
Phase: 8.2 — Asset & Portfolio Expansion
Subphase: 8.2.2 — Account-Aware Asset Context
Type: code

## Goal

Make asset loading explicitly aware of the active wallet account where the current architecture supports it, without changing wallet persistence or backup contracts.

## Scope

Use the existing wallet controller/profile/account model to ensure asset views are tied to the active account context where possible.

## Allowed Files

- `lib/features/assets/**`
- `lib/features/wallet/application/wallet_controller.dart` only if a small read-only provider/helper is required
- `lib/features/wallet/domain/wallet_account.dart` only if strictly necessary and approved
- `test/**` only for focused tests if needed

## Forbidden

- `docs/**`
- `README.md`
- wallet backup format changes
- account persistence format changes
- destructive account changes
- account creation/import behavior changes
- automatic token discovery
- multi-chain support
- navigation redesign

## Implementation Requirements

- Preserve current active account semantics.
- Do not alter how accounts are saved or restored.
- Do not break native balance behavior.
- Do not break manual ERC-20 token behavior.
- If current RPC service is not account-parameterized, report that as a limitation instead of inventing a broad RPC redesign.

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

- Asset code clearly derives or displays the active account context where supported.
- Existing balance/token behavior remains intact.
- No documentation files are modified.
- Validation passes or remaining failures are unrelated and explicitly reported.
