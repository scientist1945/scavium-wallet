# SCAVIUM Wallet — Application Flows

## 🧭 Context

These flows represent the **final behavior of the wallet after Phase 5 (up to 5.4)**.

Earlier phases introduced partial flows, which are now fully consolidated.

---

## 💸 Transaction Flow

### Native transaction

1. User inputs address and amount  
2. Input validation  
3. Preview generation  
4. User confirmation  
5. Transaction execution  
6. History persistence  
7. State refresh  

---

## 🔍 Preview Flow

Handled by:

native_send_preview_controller.dart

Includes:

- gas estimation
- fee calculation
- total cost

---

## 🔁 Auto-refresh Flow

1. Timer triggers  
2. Check lock state  
3. Invalidate providers  
4. UI rebuild  

---

## 🔒 Lifecycle Flow

1. App goes to background  
2. AppLifecycleGuard triggers lock  
3. Router redirects to LockScreen  
4. User unlocks  
5. Router returns to Home  
6. Auto-refresh restarts  

---

## 📊 History Flow

1. Transaction sent  
2. Saved locally  
3. Marked as pending  
4. Receipt polling  
5. Updated to confirmed/failed  

---

## 📊 Result

Flows are:

- predictable
- resilient
- user-safe

---

## 🚀 Conclusion

All core flows are **fully operational and stable**.