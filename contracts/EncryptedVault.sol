// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Encrypted Vault using Fully Homomorphic Encryption (FHE)

    - Encrypted balances
    - Encrypted withdrawal constraints
    - No plaintext leakage
*/

import "@fhenixprotocol/contracts/FHE.sol";

contract EncryptedVault {
    address public owner;
    euint32 private encryptedBalance;

    event Deposited();
    event Withdrawn();
    event BalanceRevealed(uint32 balance);

    constructor() {
        owner = msg.sender;
        encryptedBalance = FHE.asEuint32(0);
    }

    function deposit(euint32 amount) external {
        encryptedBalance = FHE.add(encryptedBalance, amount);
        emit Deposited();
    }

    function withdraw(euint32 amount) external {
        ebool canWithdraw = FHE.gte(encryptedBalance, amount);
        FHE.req(canWithdraw);

        encryptedBalance = FHE.sub(encryptedBalance, amount);
        emit Withdrawn();
    }

    function revealBalance() external returns (uint32) {
        require(msg.sender == owner, "Only owner");
        uint32 balance = FHE.decrypt(encryptedBalance);
        emit BalanceRevealed(balance);
        return balance;
    }
}
