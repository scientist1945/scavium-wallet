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

## 🔗 RPC Failover Flow

1. RPC request fails
2. Check if error is retryable
3. Mark node as failed (cooldown)
4. Switch to next available node
5. Retry request
6. Update active node