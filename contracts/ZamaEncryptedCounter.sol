// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Zama FHE library imports
import "@fhenixprotocol/contracts/FHE.sol";
import "@fhenixprotocol/contracts/access/Permissioned.sol";

/// @title ZamaEncryptedCounter
/// @notice A simple counter using Fully Homomorphic Encryption (FHE)
/// @dev Demonstrates private state updates and selective reveal
contract ZamaEncryptedCounter is Permissioned {

    // Encrypted counter value
    euint32 private encryptedCounter;

    // Events
    event CounterIncremented();
    event CounterRevealed(uint32 value);

    /// @notice Constructor initializes counter to encrypted zero
    constructor() {
        encryptedCounter = FHE.asEuint32(0);
    }

    /// @notice Increment the encrypted counter by 1
    function increment() external {
        encryptedCounter = encryptedCounter + FHE.asEuint32(1);
        emit CounterIncremented();
    }

    /// @notice Reveal the counter value (only owner / permitted)
    /// @return value decrypted counter
    function revealCounter()
        external
        onlyPermitted
        returns (uint32 value)
    {
        value = FHE.decrypt(encryptedCounter);
        emit CounterRevealed(value);
        return value;
    }
}
