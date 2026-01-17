// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Encrypted Governance (Voting + DAO)

    This contract combines:
    - Encrypted voting
    - Encrypted vote tallying
    - DAO-style proposal lifecycle
    using Fully Homomorphic Encryption (FHE).

    Individual votes and intermediate tallies are never revealed.
    Only final results may be intentionally revealed.
*/

import "@fhenix/lib/TFHE.sol";

contract EncryptedGovernance {
    using TFHE for euint32;

    address public owner;

    struct Proposal {
        string description;
        euint32 yesVotes;
        euint32 noVotes;
        bool active;
    }

    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // Events
    event ProposalCreated(uint256 indexed id, string description);
    event VoteCast(uint256 indexed id, address voter);
    event ProposalClosed(uint256 indexed id, uint32 yes, uint32 no);

    constructor() {
        owner = msg.sender;
    }

    /// @notice Create a new proposal
    function createProposal(string calldata description) external {
        require(msg.sender == owner, "Only owner");

        proposals[proposalCount] = Proposal({
            description: description,
            yesVotes: TFHE.asEuint32(0),
            noVotes: TFHE.asEuint32(0),
            active: true
        });

        emit ProposalCreated(proposalCount, description);
        proposalCount++;
    }

    /// @notice Cast an encrypted vote
    /// @param encryptedVote 1 = YES, 0 = NO (encrypted off-chain)
    function vote(uint256 id, euint32 encryptedVote) external {
        Proposal storage proposal = proposals[id];

        require(proposal.active, "Proposal closed");
        require(!hasVoted[id][msg.sender], "Already voted");

        // Encrypted tallying
        proposal.yesVotes = proposal.yesVotes + encryptedVote;
        proposal.noVotes =
            proposal.noVotes + (TFHE.asEuint32(1) - encryptedVote);

        hasVoted[id][msg.sender] = true;
        emit VoteCast(id, msg.sender);
    }

    /// @notice Close proposal and reveal final results
    /// Decision logic can occur while values are encrypted
    function closeProposal(uint256 id)
        external
        returns (uint32 yes, uint32 no)
    {
        require(msg.sender == owner, "Only owner");

        Proposal storage proposal = proposals[id];
        require(proposal.active, "Already closed");

        proposal.active = false;

        // NOTE:
        // Encrypted decision logic (e.g. yesVotes > noVotes)
        // can be performed here before decryption if needed.

        yes = TFHE.decrypt(proposal.yesVotes);
        no = TFHE.decrypt(proposal.noVotes);

        emit ProposalClosed(id, yes, no);
        return (yes, no);
    }
}
