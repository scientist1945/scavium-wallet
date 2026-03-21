# SCAVIUM Wallet — Phase 2 Documentation

## 🧭 Overview

Phase 2 introduces **real wallet functionality**, enabling:

- wallet creation
- wallet import
- secure storage
- account derivation

---

## 🔐 Wallet System

### Standards used

- BIP39 (mnemonic)
- BIP32 (derivation)

---

## 🧱 Core Components

### wallet_controller.dart

Responsible for:

- creating wallets
- importing wallets
- exposing current account

---

### wallet_repository.dart

Handles:

- key persistence
- mnemonic storage

---

## 💾 Storage

Two layers:

- secure storage (private data)
- local storage (flags)

---

## 🧠 Account Model

Includes:

- address
- name
- derived key

---

## 🔄 Flow

### Create wallet

1. generate mnemonic  
2. derive account  
3. store securely  

---

### Import wallet

1. input mnemonic  
2. validate  
3. derive account  
4. store  

---

## 📊 Result

Phase 2 delivers:

- functional wallet creation
- import capability
- secure key storage

---

## ⚠️ Limitations

- no blockchain interaction yet
- no balances
- no transactions

---

## 🚀 Conclusion

Phase 2 transforms the app into a **real self-custody wallet base**.