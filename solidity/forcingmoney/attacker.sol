// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ForceSend {
    constructor() payable {}

    function force(address payable target) external {
        selfdestruct(target);
    }
}