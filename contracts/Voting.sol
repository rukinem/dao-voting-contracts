// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorTimelockControl.sol";

contract DaoVotingContracts is Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes, GovernorTimelockControl {
    uint256 public constant QUORUM_PERCENTAGE = 4;

    constructor(string memory name_, IVotes token, TimelockController timelock, uint48 initialVotingDelay, uint32 initialVotingPeriod, uint256 initialProposalThreshold)
        Governor(name_) GovernorSettings(initialVotingDelay, initialVotingPeriod, initialProposalThreshold) GovernorVotes(token) GovernorTimelockControl(timelock) {}

    function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description) public override returns (uint256) {
        return super.propose(targets, values, calldatas, description);
    }

    function votingDelay() public view override(Governor, GovernorSettings) returns (uint256) { return super.votingDelay(); }
    function votingPeriod() public view override(Governor, GovernorSettings) returns (uint256) { return super.votingPeriod(); }
    function quorum(uint256 blockNumber) public view override(Governor, GovernorCountingSimple) returns (uint256) { return totalSupply(blockNumber) * QUORUM_PERCENTAGE / 100; }
    function state(uint256 proposalId) public view override(Governor, GovernorTimelockControl) returns (ProposalState) { return super.state(proposalId); }
    function proposalNeedsQueuing(uint256 proposalId) public view override(Governor, GovernorTimelockControl) returns (bool) { return super.proposalNeedsQueuing(proposalId); }
    function proposalThreshold() public view override(Governor, GovernorSettings) returns (uint256) { return super.proposalThreshold(); }
}