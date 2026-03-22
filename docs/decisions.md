# SCAVIUM Wallet — Technical Decisions

## 🧠 Key Decisions

### 1. Riverpod over other state managers
Chosen for:

- predictability
- async support
- scalability

---

### 2. Feature-based architecture
Allows:

- modular development
- clear boundaries
- easier maintenance

---

### 3. Single RPC abstraction
All blockchain calls go through:

scavium_rpc_service

Benefits:

- centralized control
- easier debugging
- failover support

---

### 4. Read vs Write separation

- READ: safe to retry
- WRITE: must be deterministic

---

### 5. Local transaction history

Chosen for:

- independence from external indexers
- faster UI feedback

---

### 6. Lifecycle-driven security

Lock based on app state:

- prevents exposure
- no reliance on timers only

---

### 7. Secure local key custody

Sensitive wallet material remains device-local and is stored through secure storage.

This preserves the self-custody model and avoids external key handling.

---

### 8. Release-stage bug fixing without redesign

From Phase 7 onward, the project adopts a strict stabilization rule:

- do not redesign architecture
- do not rename existing structures
- do not introduce unrelated new scope
- prefer the smallest safe corrective patch

This decision protects release candidate stability and reduces regression risk.

---

### 9. Android biometric fix at platform layer

The Android biometric regression of Phase 7.1 was resolved by correcting the Android activity integration (`FlutterFragmentActivity`) instead of altering lock controllers, navigation, or feature ownership.

Benefits:

- minimal surface change
- lower regression risk
- architecture preserved
- safer release candidate rollout

---

### 10. Defensive wallet availability validation

Phase 7.2 established that wallet availability must not be inferred only from local flags.

The application must validate real secure wallet state before assuming that a wallet exists and can be opened safely.

Benefits:

- avoids false-positive wallet state
- reduces startup inconsistency risk
- keeps storage architecture intact
- improves release candidate safety

---

### 11. Disable Android app backup to reduce partial restore risk

Phase 7.2 also introduced explicit disabling of Android application backup to reduce the risk of partially restored non-sensitive state without matching secure wallet secrets.

Benefits:

- lower restore inconsistency risk
- simpler and safer runtime assumptions
- no architectural redesign required