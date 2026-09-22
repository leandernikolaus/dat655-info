// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INameRegistry {
    function lookupName(string calldata name) external view returns (address);
    function transferName(string calldata name, address to) external payable;
}

contract NameSwap {
    INameRegistry public immutable registry;
    uint256 public immutable transferPrice;

    address public seller;
    address public buyer;
    string public name;
    uint256 public agreedPrice;
    bool public nameDeposited;
    bool public completed;

    constructor(INameRegistry _registry, uint256 _transferPrice) {
        registry = _registry;
        transferPrice = _transferPrice;
    }

    // Seller agrees on terms before moving the name into escrow.
    function proposeSwap(string calldata _name, address _buyer, uint256 _agreedPrice) external {
        require(seller == address(0), "Swap already proposed");
        require(registry.lookupName(_name) == msg.sender, "Not the name owner");

        seller = msg.sender;
        buyer = _buyer;
        name = _name;
        agreedPrice = _agreedPrice;
    }

    // Seller must call registry.transferName(name, address(this)) directly beforehand,
    // since only the current name owner (the seller) can authorize that transfer.
    // This just verifies the name arrived and the escrow fee was funded.
    function depositName() external payable {
        require(msg.sender == seller, "Only seller can deposit");
        require(!nameDeposited, "Name already deposited");
        require(registry.lookupName(name) == address(this), "Name not transferred to escrow");
        require(msg.value >= transferPrice, "Must fund the registry transfer fee");

        nameDeposited = true;
    }

    // Buyer pays the agreed price; contract atomically forwards the name and the payment.
    function executeSwap() external payable {
        require(msg.sender == buyer, "Only buyer can execute swap");
        require(nameDeposited, "Name not deposited yet");
        require(!completed, "Swap already completed");
        require(msg.value >= agreedPrice, "Incorrect payment");

        completed = true;

        registry.transferName{value: transferPrice}(name, buyer);
        payable(seller).transfer(agreedPrice);
    }
}
