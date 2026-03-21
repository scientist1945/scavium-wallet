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