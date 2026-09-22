# Name Registry Lab Session

Solidity examples for lab session, built around a simple
name registry (`SimpleNameRegistry`). 
In each step below, we create a new version of the name registry.

| # | Concept | File(s) | What it demonstrates |
|---|---------|---------|----------------------|
| 1 | Baseline: state + payments | [name-registry0.sol](name-registry0.sol) | `mapping` storage, `payable` functions, `msg.value`/`msg.sender`, basic `owner` access control |
| 2 | Access control (a): custom modifier | [name-registry1-onlyowner.sol](name-registry1-onlyowner.sol) | `onlyOwner` modifier, custom `error` instead of a `require` string |
| 3 | Access control (b): `Ownable` | [name-registry2-ownable.sol](name-registry2-ownable.sol) | OpenZeppelin's `Ownable` as an alternative to a hand-rolled modifier |
| 4 | Commit-reveal | [name-registry-commit-v1.sol](name-registry-commit-v1.sol) | `commit(hash)` / `reveal(name, salt)` split, guarded with timestamps and booleans; includes a `computeCommitment` test helper |
| 5 | Atomic swap (name ↔ ether, agreed price) | [name-swap.sol](name-swap.sol) | Escrow pattern: seller deposits the name, buyer pays the agreed price, both sides settle atomically |
| 6 | State machine pattern (standalone) | [statemachine-demo.sol](statemachine-demo.sol) | The `enum`/modifier pattern in isolation, before applying it to a real example |
| 7 | Atomic swap (with state machine + cancel) | [name-swap-v2.sol](name-swap-v2.sol) | Same swap modeled with `enum State { Created, Deposited, Completed, Cancelled }`, adding a `cancelSwap()` escape hatch |
| 8 | Auction (no state machine) | [name-auction-v1.sol](name-auction-v1.sol) | Plain `bid()`/`endAuction()` guarded with a `bool ended` flag; refunds pushed directly to outbid bidders. **Intentionally buggy**: `startAuction` tries to call `registry.transferName` itself, which always fails since the escrow contract isn't the name's owner — a good example of the "a contract can't authorize a transfer on someone else's behalf" mistake |
| 9 | Auction (with state machine) | [name-auction-v2.sol](name-auction-v2.sol) | `enum State { Created, Bidding, Ended }` and an `inState` modifier, contrasted with #8 |
| 10 | Withdraw pattern (expanded) | [name-auction-v3.sol](name-auction-v3.sol) | `pendingReturns` mapping so every outbid bidder (and the seller) withdraws funds themselves — pull over push |
| 11 | Auction with time-lock deadline | [name-auction-v4.sol](name-auction-v4.sol) | `block.timestamp`-based `biddingEnd` deadline instead of a manual, seller-triggered end |
| 12 | Factory pattern *(optional)* | [name-auction-factory.sol](name-auction-factory.sol) | One contract spawning many independent `NameAuctionV4` instances |

## Notes

- Steps 5, 7–12 use an `INameRegistry` interface and interact with a deployed
  `SimpleNameRegistry` (from step 1) by address — deploy the registry first, then
  the escrow/auction contracts, passing the registry's address and its `PRICE`
  constant to the constructor.
- For the swap (steps 5, 7) and the fixed auctions (steps 9–11), the seller must
  call the registry's `transferName` directly (only the current owner can
  authorize that), then call the escrow's `depositName` (swap) or
  `registerAuction` + `startAuction` (auction) to confirm and fund it. Step 8
  (`name-auction-v1.sol`) keeps the broken single-step version on purpose.
- Step 3 imports `@openzeppelin/contracts/access/Ownable.sol`, which Remix
  resolves automatically via npm — an internet connection is required in the
  Remix environment.
- Reentrancy, integer overflow/underflow, and forced-ether-transfer topics are
  intentionally omitted here; they are covered in the separate security-focused
  lab session.
