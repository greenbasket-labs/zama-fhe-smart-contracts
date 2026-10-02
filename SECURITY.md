# Security Policy

This repository contains educational FHE smart-contract patterns. It is **not audited** and is not intended for production custody, governance, or financial use.

## Reporting

If you identify a security issue in the code or documentation, please avoid publishing sensitive exploit details in a public issue until maintainers have had an opportunity to review them.

Report the affected contract, a concise description of the behavior, reproduction steps when safe, and the potential impact.

## Scope

Particularly relevant areas include:

- authorization and access-control boundaries
- encrypted state transitions
- reveal/decryption assumptions
- withdrawal and financial constraints
- incorrect assumptions about FHE guarantees
- unintended plaintext exposure

Do not submit real private keys, secrets, or sensitive user data.

## Production Warning

Any production use would require framework-specific validation, comprehensive tests, threat modeling, independent security review, and appropriate key-management design.
