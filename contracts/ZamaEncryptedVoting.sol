// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Zama FHE imports
import "@fhenix/lib/TFHE.sol";

contract ZamaEncryptedVoting {
    using TFHE for euint32;

    // Encrypted vote counts
    euint32 private yesVotes;
    euint32 private noVotes;

    // Prevent double voting
    mapping(address => bool) public hasVoted;

    // Owner (can reveal results)
    address public owner;

    // Events
    event VoteCast(address indexed voter);
    event ResultsRevealed(uint32 yes, uint32 no);

    constructor() {
        owner = msg.sender;
        yesVotes = TFHE.asEuint32(0);
        noVotes = TFHE.asEuint32(0);
    }

    /// @notice Cast an encrypted vote
    /// @param encryptedVote 1 = YES, 0 = NO (encrypted off-chain)
    function vote(euint32 encryptedVote) external {
        require(!hasVoted[msg.sender], "Already voted");

        // If vote == 1 → yesVotes++
        yesVotes = yesVotes + encryptedVote;

        // If vote == 0 → noVotes++
        // (1 - encryptedVote) works fully encrypted
        noVotes = noVotes + (TFHE.asEuint32(1) - encryptedVote);

        hasVoted[msg.sender] = true;
        emit VoteCast(msg.sender);
    }

    /// @notice Reveal final results (owner only)
    function revealResults() external returns (uint32 yes, uint32 no) {
        require(msg.sender == owner, "Only owner");

        yes = TFHE.decrypt(yesVotes);
        no = TFHE.decrypt(noVotes);

        emit ResultsRevealed(yes, no);
        return (yes, no);
    }
}
