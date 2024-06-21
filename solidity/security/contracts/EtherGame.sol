// SPDX-License-Identifier: MIT
pragma solidity 0.5.11;

contract EtherGame {
    uint256 public payoutMileStone1 = 3 ether;
    uint256 public mileStone1Reward = 2 ether;
    uint256 public payoutMileStone2 = 5 ether;
    uint256 public mileStone2Reward = 3 ether;
    uint256 public finalMileStone = 10 ether;
    uint256 public finalReward = 5 ether;

    mapping(address => uint256) redeemableEther;

    // Users pay 0.5 ether. At specific milestones, credit their accounts.
    function play() public payable {
        require(msg.value == 0.5 ether); // each play is 0.5 ether
        uint256 currentBalance = address(this).balance + msg.value;
        // ensure no players after the game has finished
        require(currentBalance <= finalMileStone);
        // if at a milestone, credit the player's account
        if (currentBalance == payoutMileStone1) {
            redeemableEther[msg.sender] += mileStone1Reward;
        } else if (currentBalance == payoutMileStone2) {
            redeemableEther[msg.sender] += mileStone2Reward;
        } else if (currentBalance == finalMileStone) {
            redeemableEther[msg.sender] += finalReward;
        }
        return;
    }

    function claimReward() public {
        // ensure the game is complete
        require(address(this).balance == finalMileStone);
        // ensure there is a reward to give
        require(redeemableEther[msg.sender] > 0);
        uint256 transferValue = redeemableEther[msg.sender];
        redeemableEther[msg.sender] = 0;
        msg.sender.transfer(transferValue);
    }
}
