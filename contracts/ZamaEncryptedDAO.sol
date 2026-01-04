// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Zama FHE imports
import "@fhenix/lib/TFHE.sol";

contract ZamaEncryptedDAO {
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

    /// @notice Vote on a proposal (encrypted)
    /// @param id Proposal ID
    /// @param encryptedVote 1 = YES, 0 = NO (encrypted off-chain)
    function vote(uint256 id, euint32 encryptedVote) external {
        Proposal storage proposal = proposals[id];

        require(proposal.active, "Proposal closed");
        require(!hasVoted[id][msg.sender], "Already voted");

        proposal.yesVotes = proposal.yesVotes + encryptedVote;
        proposal.noVotes =
            proposal.noVotes + (TFHE.asEuint32(1) - encryptedVote);

        hasVoted[id][msg.sender] = true;
        emit VoteCast(id, msg.sender);
    }

    /// @notice Close proposal and reveal result (owner only)
    function closeProposal(uint256 id)
        external
        returns (uint32 yes, uint32 no)
    {
        require(msg.sender == owner, "Only owner");

        Proposal storage proposal = proposals[id];
        require(proposal.active, "Already closed");

        proposal.active = false;

        yes = TFHE.decrypt(proposal.yesVotes);
        no = TFHE.decrypt(proposal.noVotes);

        emit ProposalClosed(id, yes, no);
        return (yes, no);
    }
}
