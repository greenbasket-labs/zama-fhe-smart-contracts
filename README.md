# Zama FHE Smart Contracts

This repository contains a collection of small, focused smart contracts built
while learning and experimenting with **Fully Homomorphic Encryption (FHE)**
using Zama’s FHE Solidity framework.

The goal is to understand how encrypted computation changes smart contract
design, state management, and access control on-chain.

---

## 📦 Contracts

- **ZamaEncryptedCounter.sol**  
  Encrypted counter demonstrating deterministic state updates over encrypted values.

- **ZamaEncryptedVault.sol**  
  A private vault using encrypted balances, showcasing secure value storage and access control.

- **ZamaEncryptedVoting.sol**  
  Private voting logic with encrypted tallies and controlled result revelation.

- **ZamaEncryptedDAO.sol**  
  Simple DAO-style patterns built on top of encrypted voting primitives.

---

## 🎯 Focus Areas

- Replacing standard Solidity primitives with **Zama encrypted types**
- Working with encrypted state and arithmetic
- Designing secure reveal patterns
- Understanding developer ergonomics when building with FHE
- Writing clean, minimal contracts for learning and demonstration

---

## 🚧 Project Status

- All contracts compile successfully
- Built as a **learning + portfolio** project
- No production deployment yet
- Frontend, relayer, or integration layers may be explored later

---

## 📚 Notes

This repository is intentionally kept simple.
Contracts are not optimized for production use and are meant to
demonstrate concepts rather than provide audited implementations.

---

Built by **GreenBasket Labs**  
Learning Zama FHE, one contract at a time.
