// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockRollup {
    bytes32 public stateHash;
    mapping(address => uint256) public balancesToWithdraw;

    // No proof verification: anyone can post an update.
    function update(
        bytes calldata state,
        // transactions: calldata only, not stored
        bytes calldata,
        address[] calldata accounts,
        uint256[] calldata balances
    ) external {
        require(
            accounts.length == balances.length,
            "Length mismatch"
        );

        stateHash = keccak256(state);
        for (uint256 i = 0; i < accounts.length; i++) {
            balancesToWithdraw[accounts[i]] = balances[i];
        }
    }
}
