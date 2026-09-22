// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INameRegistry {
    function lookupName(string calldata name) external view returns (address);
    function transferName(string calldata name, address to) external payable;
}

contract NameAuctionV1 {
    enum State { Created, Bidding, Ended }

    INameRegistry public immutable registry;
    uint256 public immutable transferPrice;
    
    address public seller;
    string public name;
    address public highestBidder;
    uint256 public highestBid;
    State public state = State.Created;

    modifier inState(State expected) {
        require(state == expected, "Invalid action for current state");
        _;
    }

    constructor(INameRegistry _registry, uint256 _transferPrice) {
        registry = _registry;
        transferPrice = _transferPrice;
    }

    // Seller deposits the name into escrow, covering the registry's own transfer fee.
    function startAuction(string calldata _name) external payable inState(State.Created) {
        require(registry.lookupName(_name) == msg.sender, "Seller not the name owner");
        require(msg.value >= 2* transferPrice, "Must fund the registry transfer fee");

        seller = msg.sender;
        name = _name;

        registry.transferName{value: transferPrice}(_name, address(this));
        require(registry.lookupName(_name) == address(this), "Deposit failed");
        state = State.Bidding;
    }

    function bid() external payable inState(State.Bidding) {
        require(msg.value > highestBid, "Bid too low");

        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function endAuction() external inState(State.Bidding) {
        require(msg.sender == seller, "Only seller can end auction");

        if (highestBidder != address(0)) {
            registry.transferName{value: transferPrice}(name, highestBidder);
            payable(seller).transfer(highestBid);
        } else {
            registry.transferName{value: transferPrice}(name, seller);
        }

        state = State.Ended;
    }
}
