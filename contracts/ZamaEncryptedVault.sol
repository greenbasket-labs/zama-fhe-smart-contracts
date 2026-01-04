// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Zama Encrypted Vault
    - Private deposits
    - Private balance storage
    - Owner-controlled reveal (demo purpose)
*/

import "@fhenixprotocol/contracts/FHE.sol";

contract ZamaEncryptedVault {
    address public owner;

    // Encrypted balance
    euint32 private encryptedBalance;

    event Deposited();
    event Withdrawn();
    event BalanceRevealed(uint32 balance);

    constructor() {
        owner = msg.sender;
        encryptedBalance = FHE.asEuint32(0);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Deposit an encrypted amount
    function deposit(euint32 amount) external {
        encryptedBalance = FHE.add(encryptedBalance, amount);
        emit Deposited();
    }

    // Withdraw an encrypted amount
    function withdraw(euint32 amount) external {
        encryptedBalance = FHE.sub(encryptedBalance, amount);
        emit Withdrawn();
    }

    // Reveal balance (demo: owner only)
    function revealBalance() external onlyOwner returns (uint32) {
        uint32 balance = FHE.decrypt(encryptedBalance);
        emit BalanceRevealed(balance);
        return balance;
    }
}
