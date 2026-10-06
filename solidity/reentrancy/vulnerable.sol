// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice INTENTIONALLY VULNERABLE — for testing/education only.
contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];

        require(amount > 0, "Nothing to withdraw");

        // ❌ External call happens BEFORE the balance is updated.
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // Too late — msg.sender can have called withdraw() again
        // while the external call above was executing.
        balances[msg.sender] = 0;
    }
}