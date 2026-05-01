# SCAVIUM Wallet — Core Flows

## 💸 Send Transaction Flow

1. User enters address and amount
2. Input validation
3. Preview generation (gas + fee)
4. Confirmation dialog
5. Transaction execution
6. Save to local history
7. Refresh assets and history

---

## 🔁 Auto-refresh Flow

1. Timer triggers refresh
2. Check if app is locked
3. Invalidate:
   - network
   - assets
   - history
   - rpc status
4. UI updates automatically

---

## 🔒 Lock Flow

1. App goes to background
2. Lifecycle guard triggers lock
3. Router redirects to lock screen
4. Unlock restores state

---

## 🔐 Biometric Unlock Flow

1. User reaches lock screen
2. User selects biometric unlock
3. Lock flow delegates to biometric service
4. Platform biometric prompt is requested
5. Authentication succeeds or fails
6. On success, protected navigation is restored
7. On failure, user remains on the lock screen

Phase 7.1 stabilized the Android-specific part of this flow by correcting the native activity integration required by the biometric plugin.

---

## 👛 Wallet Creation / Import Flow

1. User creates or imports wallet
2. Wallet repository derives or validates secret material
3. Critical secret values are written to secure storage
4. Persisted values are verified immediately
5. Wallet metadata is written and checked
6. Wallet availability is marked only after secure state is valid
7. User continues through the existing onboarding/wallet flow

Phase 7.2 hardened this flow to avoid silent success under invalid persistence conditions.

---

## 🧾 Backup Mnemonic Flow

1. User reaches backup screen after mnemonic wallet creation/import path
2. App loads mnemonic from secure storage
3. Mnemonic is displayed only if available
4. Backup confirmation can proceed only when mnemonic exists
5. Confirmation flow continues under the existing route structure

Phase 7.2 hardened this flow to prevent backup confirmation when mnemonic state is invalid.

---

## 🚀 Startup Wallet Availability Flow

1. App starts on splash screen
2. Startup flow loads onboarding state
3. Startup flow loads wallet profile from persisted secure state
4. App validates whether the wallet is actually available
5. If wallet is valid, app continues to protected flow
6. If wallet is invalid or inconsistent, app returns to wallet entry

Phase 7.2 hardened this startup behavior to avoid trusting only local flags.

---

## 🎨 Shared Branding Flow

1. App enters an in-app branded screen
2. Screen requests the shared `ScaviumLogo` widget
3. Widget loads the official square SCAVIUM asset
4. Logo is rendered consistently in splash and other shared contexts

Phase 7.3 hardened visual consistency by replacing the previous placeholder-style shared logo output.

---

## 🛠️ Build and Versioning Flow

1. Developer invokes `tool/build.dart`
2. Tool parses target and version arguments
3. Tool reads version from `pubspec.yaml`
4. Tool resolves whether to increment or reset build number
5. Tool updates `pubspec.yaml` when applicable
6. Tool runs clean and dependency resolution unless skipped
7. Tool executes the requested build target(s)
8. Tool optionally invokes Windows MSIX packaging
9. Tool reports artifact locations

Phase 7.4 hardened this operational flow to reduce release mistakes and standardize RC build iteration.

---

## ♻️ Encrypted Backup Export Flow

1. User opens Settings
2. User selects export encrypted backup
3. App explains backup risks and user responsibility
4. User enters backup password
5. User confirms backup password
6. App loads wallet profile and secrets
7. App builds a backup payload
8. App encrypts the payload
9. App serializes the encrypted backup
10. App exports the file

Platform-specific behavior:

- desktop platforms → native save dialog
- mobile platforms → share/export flow

Phase 7.5 introduced this flow to provide a user-managed recovery artifact outside internal app storage.

---

## ♻️ Encrypted Backup Restore Flow

1. User reaches wallet entry screen
2. User selects restore from encrypted backup
3. User picks backup file
4. User enters backup password
5. App decodes and validates the encrypted backup structure
6. App decrypts the payload
7. App validates the wallet payload
8. App restores through the existing wallet import path
9. Wallet is persisted into secure storage
10. User returns to the normal post-entry flow

Phase 7.5 introduced this flow to provide an explicit recovery path after storage loss, reinstall, or device migration.

---

## 🔗 RPC Failover Flow

1. RPC request fails
2. Check if error is retryable
3. Mark node as failed (cooldown)
4. Switch to next available node
5. Retry request
6. Update active node
---

## 👛 Phase 8.1 Account Model Migration Flow

Phase 8.1.0 defines the account migration contract before runtime implementation.

The intended future migration flow is:

1. App starts with an existing Phase 7-compatible wallet.
2. Wallet repository loads the legacy single-account profile.
3. Repository maps the legacy account into `accounts[0]`.
4. `activeAccountId` is assigned to the migrated account.
5. `defaultAccountId` is assigned to the migrated account.
6. Existing lock, PIN, biometric, backup, and restore behavior remain valid.
7. UI continues to display the same effective wallet until account switching is implemented.

This flow is contractual only in 8.1.0.

It is documented to protect compatibility during the later implementation subphases.


---

## Phase 8.1.2 Legacy Wallet to Multi-Account Metadata Flow

When a wallet is created or imported, SCAVIUM Wallet still writes the legacy single-wallet keys and additionally writes the multi-account metadata foundation.

```text
create/import wallet
-> write legacy wallet keys
-> build WalletAccount(accountIndex: 0)
-> persist wallet_accounts_json
-> persist wallet_active_account_id
-> persist wallet_default_account_id
-> persist wallet_storage_version = 2
-> return WalletProfile compatible with profile.account
```

When loading an existing wallet, the repository first validates the legacy wallet material required by the current app. It then loads account metadata if available or creates it from the legacy wallet when missing.

```text
load wallet profile
-> validate legacy wallet keys
-> read account metadata
-> if missing, create accounts[0] from legacy wallet
-> normalize active/default account flags
-> return WalletProfile
```

When clearing a wallet, both legacy and multi-account keys are removed so the app does not retain stale account metadata.

---

## Phase 8.1.3 Active Account Controller Flow

The active-account flow is internal only in this subphase.

```text
WalletController.setActiveAccount(accountId)
  -> WalletRepository.setActiveAccount(accountId)
  -> load WalletProfile
  -> resolve account from accounts[]
  -> normalize active/default flags
  -> persist wallet_active_account_id
  -> return WalletProfile with profile.account aligned to activeAccount
```

No visible account switcher is introduced yet. Existing screens continue to behave as a single-account wallet because `WalletProfile.account` remains compatible with the selected active account.

## Phase 8.1.6 — Multi-Account Backup / Restore Flow

Export backup now emits a version 2 wallet payload containing the active account, default account, and account list. Restore remains backward-compatible: version 1 payloads rebuild a single-account profile, while version 2 payloads restore multi-account metadata and imported-account private keys required for later signing/send flows.

---

## 📊 Phase 8.2 Asset and Portfolio Flow

Phase 8.2 formalizes the current asset-loading flow around visible assets, active account context, and manual token registry behavior.

### Asset Loading Flow

```text
AssetsScreen
  -> AssetsController
    -> WalletController active account context
    -> ScaviumRpcService native balance
    -> TokenRegistryRepository manual tokens
    -> ScaviumRpcService ERC-20 balances
    -> AssetItem[]
    -> PortfolioSummary.fromAssets(...)
```

### Manual Token Addition Flow

```text
AddTokenScreen
  -> validate ERC-20 contract address
  -> normalize contract address
  -> check duplicate registry entry
  -> load token metadata through RPC
  -> persist normalized token
  -> refresh asset list
```

### Asset Detail Flow

```text
AssetsScreen asset item
  -> AssetDetailScreen
    -> native asset: Send screen
    -> ERC-20 token: SendToken screen
    -> ERC-20 token: optional local token removal
```

### Explicit Boundaries

Phase 8.2 does not add:

- automatic token discovery;
- multi-chain aggregation;
- indexer-backed balances;
- backup format changes;
- route redesign;
- navigation shell redesign.

---

## 🧾 Phase 8.3 Transaction Activity and Signing Flows

Phase 8.3 matures the existing local outgoing transaction flow and adds explicit message-signing flows.

### Local Transaction History Refresh Flow

```text
HistoryScreen
  -> TxHistoryController.refreshStatuses()
    -> TxHistoryRepository.getEntries()
    -> for each pending TxHistoryEntry
      -> ScaviumRpcService.getReceipt(txHash)
      -> no receipt: keep pending
      -> receipt success: mark confirmed
      -> receipt failure: mark failed
    -> TxHistoryRepository.saveEntries(updated)
```

### Transaction Detail Flow

```text
HistoryScreen transaction row
  -> GoRouter transactionDetail route
    -> TransactionDetailScreen(TxHistoryEntry)
      -> show amount, symbol, kind, status, destination, hash, timestamp
      -> explain receipt-oriented status
      -> optional explicit external explorer open
```

### Activity Filtering and Grouping Flow

```text
HistoryScreen
  -> selected status filter
  -> selected kind filter
  -> TxHistoryFilter.apply(entries)
  -> TxHistoryFilter.groupByLocalDay(filtered entries)
  -> render local day sections newest-first
```

### Message Signing Flow

```text
SigningScreen
  -> read active account from WalletController
  -> user selects signing mode
  -> user enters message/challenge
  -> SigningRequest.normalized()
  -> SigningConfirmDialog preview
  -> user confirms
  -> SigningController.sign(request)
    -> SigningService
    -> ScaviumRpcService.signPersonalMessage(...) or signChallengeMessage(...)
    -> validate returned account matches requested active account
  -> SigningResultCard displays signature
```

### Explicit Boundaries

Phase 8.3 does not add:

- incoming transaction discovery;
- external transaction indexing;
- automatic activity aggregation;
- transaction submission from signing;
- dApp connectivity;
- backup payload changes;
- navigation shell redesign.
---

## 🧭 Phase 8.4 Navigation Shell and Product Surface Flows

Phase 8.4 introduces a primary authenticated navigation flow while preserving explicit action and detail routes.

### Primary Shell Navigation Flow

```text
Authenticated primary route
  -> GoRouter ShellRoute
    -> AppShell(location, child)
      -> ResponsiveNavigation
        -> compact width: NavigationBar
        -> wide width: NavigationRail
      -> selected destination maps to RouteNames
      -> context.go(destination.route)
```

Primary destinations:

- Home
- Assets
- Activity
- Settings

### Dashboard Flow

```text
HomeScreen
  -> DashboardBalanceCard
  -> AccountSwitcher summary
  -> Network and RPC status summaries
  -> explicit quick actions
  -> DashboardRecentActivityCard
    -> transaction detail route when an entry is selected
```

### Account Surface Flow

```text
Home quick action or route entry
  -> RouteNames.accounts
    -> AccountsScreen
      -> WalletController
      -> AccountSwitcher
```

### Settings Secondary Action Flow

```text
SettingsScreen
  -> Security & recovery: encrypted backup export
  -> Signing: explicit signing route
  -> Diagnostics: RPC diagnostics route
  -> Danger zone: confirmation-gated wallet reset
  -> About: app information
```

### Explicit Boundaries

Phase 8.4 does not add:

- hidden shell-owned signing;
- implicit destructive actions;
- backup payload changes;
- wallet encryption changes;
- transaction submission changes;
- automatic token discovery;
- external activity indexing;
- dApp connectivity.

