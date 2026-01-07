# Zama FHE Smart Contracts

This repository contains a collection of small, focused smart contracts built
while learning and experimenting with **Fully Homomorphic Encryption (FHE)**
using Zama’s FHE Solidity framework.

The goal is to understand how encrypted computation changes smart contract
design, state management, and access control on-chain.
## 🔒 Problem & Motivation
Most smart contracts today expose all state and computation publicly.
While transparency is powerful, it becomes a limitation for applications involving:
-governance and voting
-balances and financial positions
-quotas, thresholds, or counters
-DAO decision-making with sensitive inputs
In these systems, users are harmed by forced transparency, and developers are unable to express privacy-preserving logic directly on-chain without relying on off-chain trust assumptions.
Fully Homomorphic Encryption (FHE) enables encrypted computation on-chain, allowing smart contracts to operate on private data without revealing plaintext values.
This repository explores minimal, concrete smart contract patterns that demonstrate how FHE fundamentally changes:
on-chain state management
access control design
result revelation logic
developer ergonomics
Each contract is intentionally small and focused, designed to make these patterns explicit, inspectable, and verifiable directly from the code.
## 🧠 Design Approach

The design philosophy of this repository is to explore **small, explicit smart contract patterns** that demonstrate how Fully Homomorphic Encryption (FHE) changes on-chain design, without introducing unnecessary abstraction or off-chain dependencies.

Rather than building a single complex application, the project is intentionally split into **minimal contracts**, each focused on one core idea. This makes the encrypted logic easier to reason about, audit, and verify directly from the source code.

### Core Design Principles

- **Encrypted-by-default state**  
  Sensitive values (balances, votes, counters, thresholds) are stored and processed using Zama’s encrypted types, ensuring plaintext data is never exposed on-chain.

- **Deterministic behavior over encrypted data**  
  Contracts are designed so that encrypted state updates remain deterministic and verifiable, preserving blockchain execution guarantees.

- **Explicit access control and reveal logic**  
  Instead of implicit transparency, contracts define clear rules for:
  - who may submit encrypted inputs
  - who may trigger result revelation
  - what information is ever decrypted

- **Minimal trusted assumptions**  
  All core logic executes on-chain. The contracts avoid reliance on off-chain servers, relayers, or trusted computation layers beyond the FHE execution model itself.

- **Readable, inspectable code**  
  Contracts are kept intentionally small and well-scoped so reviewers can understand *what is encrypted*, *when computation happens*, and *why results are revealed* by reading the Solidity code alone.

### Why This Matters

Traditional Solidity patterns assume public state and transparent computation. By replacing standard primitives with encrypted equivalents, this repository demonstrates how developers can:

- express privacy-preserving logic directly on-chain
- reduce leakage of sensitive economic or governance signals
- build systems where correctness is verifiable without revealing inputs

Each contract in this repository serves as a **concrete reference pattern**, not a production-ready system.

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
