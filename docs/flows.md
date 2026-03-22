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

## 🔗 RPC Failover Flow

1. RPC request fails
2. Check if error is retryable
3. Mark node as failed (cooldown)
4. Switch to next available node
5. Retry request
6. Update active node