// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DaoVotingContracts is Ownable {
    // TODO: Implement Gas-optimized voting contracts with snapshot, quadratic and conviction voting
    constructor() Ownable(msg.sender) {}
}
