// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NameRegistryCommitV1 {
    uint256 public constant PRICE = 1_000_000 gwei; // 0.001 ether
    uint256 public constant REVEAL_DELAY = 1 minutes;

    mapping(string => address) private nameOwner;
    mapping(address => bytes32) public commitments;
    mapping(address => uint256) public commitTimestamps;

    // commitment = keccak256(abi.encodePacked(name, salt, msg.sender)), hiding the desired name
    function commit(bytes32 commitment) external {
        commitments[msg.sender] = commitment;
        commitTimestamps[msg.sender] = block.timestamp;
    }

    function reveal(string calldata name, uint256 salt) external payable {
        require(commitments[msg.sender] != bytes32(0), "No active commitment");
        require(
            block.timestamp >= commitTimestamps[msg.sender] + REVEAL_DELAY,
            "Reveal too early"
        );
        require(
            keccak256(abi.encodePacked(name, salt, msg.sender)) == commitments[msg.sender],
            "Commitment mismatch"
        );
        require(msg.value >= PRICE, "Insufficient payment");
        require(nameOwner[name] == address(0), "Name already taken");

        delete commitments[msg.sender];
        nameOwner[name] = msg.sender;
    }

    function lookupName(string calldata name) external view returns (address) {
        return nameOwner[name];
    }

    // Helper for testing: computes the commitment hash for a given name/salt/sender.
    function computeCommitment(string calldata name, uint256 salt) external view returns (bytes32) {
        return keccak256(abi.encodePacked(name, salt, msg.sender));
    }
}
