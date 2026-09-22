// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INameRegistry {
    function lookupName(string calldata name) external view returns (address);
    function transferName(string calldata name, address to) external payable;
}

contract NameSwapV2 {
    enum State { Created, Deposited, Completed, Cancelled }

    INameRegistry public immutable registry;
    uint256 public immutable transferPrice;

    address public seller;
    address public buyer;
    string public name;
    uint256 public agreedPrice;
    State public state = State.Created;

    modifier inState(State expected) {
        require(state == expected, "Invalid action for current state");
        _;
    }

    constructor(INameRegistry _registry, uint256 _transferPrice) {
        registry = _registry;
        transferPrice = _transferPrice;
    }

    // Seller agrees on terms before moving the name into escrow.
    function proposeSwap(string calldata _name, address _buyer, uint256 _agreedPrice) external inState(State.Created) {
        require(registry.lookupName(_name) == msg.sender, "Not the name owner");

        seller = msg.sender;
        buyer = _buyer;
        name = _name;
        agreedPrice = _agreedPrice;
    }

    // Seller must call registry.transferName(name, address(this)) directly beforehand,
    // since only the current name owner (the seller) can authorize that transfer.
    // This just verifies the name arrived and the escrow fee was funded.
    function depositName() external payable inState(State.Created) {
        require(msg.sender == seller, "Only seller can deposit");
        require(registry.lookupName(name) == address(this), "Name not transferred to escrow");
        require(msg.value >= transferPrice, "Must fund the registry transfer fee");

        state = State.Deposited;
    }

    // Buyer pays the agreed price; contract atomically forwards the name and the payment.
    function executeSwap() external payable inState(State.Deposited) {
        require(msg.sender == buyer, "Only buyer can execute swap");
        require(msg.value >= agreedPrice, "Incorrect payment");

        state = State.Completed;

        registry.transferName{value: transferPrice}(name, buyer);
        payable(seller).transfer(agreedPrice);
    }

    // Seller can back out any time before completion, reclaiming the name and escrowed fee.
    function cancelSwap() external {
        require(msg.sender == seller, "Only seller can cancel");
        require(state == State.Created || state == State.Deposited, "Cannot cancel now");

        bool wasDeposited = state == State.Deposited;
        state = State.Cancelled;

        if (wasDeposited) {
            registry.transferName{value: transferPrice}(name, seller);
        }
    }
}
