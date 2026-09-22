// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleNameRegistry is Ownable {
    uint256 public constant PRICE = 1_000_000 gwei; // 0.001 ether

    mapping(string => address) private nameOwner;

    constructor() Ownable(msg.sender) {}

    function buyName(string calldata name) external payable {
        require(msg.value >= PRICE, "Insufficient payment");
        require(nameOwner[name] == address(0), "Name already taken");

        nameOwner[name] = msg.sender;
    }

    function lookupName(string calldata name) external view returns (address) {
        return nameOwner[name];
    }

    function transferName(string calldata name, address to) external payable {
        require(msg.value >= PRICE, "Insufficient payment");
        require(nameOwner[name] == msg.sender, "Not the name owner");
        require(to != address(0), "Invalid recipient");

        nameOwner[name] = to;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
