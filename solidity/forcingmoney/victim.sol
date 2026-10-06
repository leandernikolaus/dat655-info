// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Crowdfunding {
    uint256 public constant CONTRIBUTION = 0.005 ether;
    uint256 public constant GOAL = 10 ether;

    bool public campaignEnded;
    address public receiver;

    constructor(address _receiver) {
        campaignEnded = false;
        receiver = _receiver;
    }

    function contribute() external payable {
        require(!campaignEnded, "Campaign has ended");
        require(msg.value == CONTRIBUTION, "Must contribute exactly 0.005 ETH");

        if ( address(this).balance == GOAL) {
            campaignEnded = true;
        }
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {
        revert("Use contribute()");
    }
}