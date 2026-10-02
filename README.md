# Privacy-Preserving Smart Contract Patterns with FHE

**Minimal Solidity reference implementations for encrypted governance and financial constraints.**

This repository explores how Fully Homomorphic Encryption (FHE) can change the way sensitive state and decisions are represented in smart contracts.

> **Status: reference / educational implementation — not audited or production-ready.**

## Why FHE?

Traditional smart contracts expose state and computation publicly. That is useful for transparency, but problematic when applications need to protect information such as:

- voting choices
- balances and financial positions
- thresholds and quotas
- sensitive governance inputs

FHE enables computation over encrypted values without requiring the plaintext to be exposed to the contract logic.

## Included Patterns

### Encrypted Governance

The `EncryptedGovernance` pattern demonstrates:
- encrypted vote submission
- encrypted tally computation
- encrypted decision logic
- explicit result revelation under access control

### Encrypted Vault

The `EncryptedVault` pattern explores:
- encrypted balances
- encrypted comparisons
- withdrawal constraints
- keeping sensitive financial state from being exposed as plaintext

## Design Goals

- Keep the contracts small and inspectable
- Make encrypted state transitions explicit
- Separate encrypted computation from intentional revelation
- Demonstrate patterns that developers and auditors can study

## Verification Mindset

The repository is designed for source-level inspection. Claims should be checked against the actual Solidity implementation rather than treated as production security guarantees.

## Scope

### In scope
- FHE smart-contract patterns
- encrypted state
- encrypted decision-making
- privacy-preserving governance
- privacy-preserving financial constraints
- developer education

### Out of scope
- production deployment
- audited security guarantees
- gas optimization
- complete frontends
- production key-management infrastructure

## Security Disclaimer

These examples are **not audited** and should not be used to custody real assets or secure production systems without additional engineering, testing, and independent security review.

## Goal

Provide small, readable examples that help Solidity developers reason about privacy-preserving computation and encrypted state.