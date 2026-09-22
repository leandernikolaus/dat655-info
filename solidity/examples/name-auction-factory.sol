// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./name-auction-v4.sol";

contract NameAuctionFactory {
    INameRegistry public immutable registry;
    uint256 public immutable transferPrice;

    NameAuctionV4[] public auctions;

    constructor(INameRegistry _registry, uint256 _transferPrice) {
        registry = _registry;
        transferPrice = _transferPrice;
    }

    function createAuction() external returns (NameAuctionV4 auction) {
        auction = new NameAuctionV4(registry, transferPrice);
        auctions.push(auction);
    }

    function auctionCount() external view returns (uint256) {
        return auctions.length;
    }
}
