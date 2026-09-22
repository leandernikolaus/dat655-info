// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INameRegistry {
    function lookupName(string calldata name) external view returns (address);
    function transferName(string calldata name, address to) external payable;
}

contract NameAuctionV4 {
    enum State { Created, Bidding, Ended }

    uint256 public constant BIDDING_DURATION = 5 minutes;

    INameRegistry public immutable registry;
    uint256 public immutable transferPrice;

    address public seller;
    string public name;
    address public highestBidder;
    uint256 public highestBid;
    uint256 public biddingEnd;
    State public state = State.Created;

    mapping(address => uint256) public pendingReturns;

    modifier inState(State expected) {
        require(state == expected, "Invalid action for current state");
        _;
    }

    constructor(INameRegistry _registry, uint256 _transferPrice) {
        registry = _registry;
        transferPrice = _transferPrice;
    }

    // Seller registers intent to auction, establishing ownership before escrow.
    function registerAuction(string calldata _name) external inState(State.Created) {
        require(registry.lookupName(_name) == msg.sender, "Not the name owner");

        seller = msg.sender;
        name = _name;
    }

    // Seller must call registry.transferName(name, address(this)) directly beforehand,
    // since only the current name owner (the seller) can authorize that transfer.
    // This just verifies the name arrived and the escrow fee was funded, then starts the clock.
    function startAuction() external payable inState(State.Created) {
        require(msg.sender == seller, "Only seller can start auction");
        require(registry.lookupName(name) == address(this), "Name not transferred to escrow");
        require(msg.value >= transferPrice, "Must fund the registry transfer fee");

        biddingEnd = block.timestamp + BIDDING_DURATION;
        state = State.Bidding;
    }

    function bid() external payable inState(State.Bidding) {
        require(block.timestamp < biddingEnd, "Bidding period over");
        require(msg.value > highestBid, "Bid too low");

        if (highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdraw() external {
        uint256 amount = pendingReturns[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        pendingReturns[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Anyone can trigger the end once the deadline has passed; no manual seller action needed.
    function endAuction() external inState(State.Bidding) {
        require(block.timestamp >= biddingEnd, "Bidding period not over");

        state = State.Ended;

        if (highestBidder != address(0)) {
            registry.transferName{value: transferPrice}(name, highestBidder);
            pendingReturns[seller] += highestBid;
        }
    }
}
