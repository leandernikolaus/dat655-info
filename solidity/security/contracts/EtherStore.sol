// SPDX-License-Identifier: MIT
pragma solidity 0.5.11;

contract EtherStore {
    enum WTYPE {Call, Send, Transfer}

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds(WTYPE wt, uint256 _weiToWithdraw) public {
        require(balances[msg.sender] >= _weiToWithdraw);
        // limit the withdrawal
        require(_weiToWithdraw <= withdrawalLimit);
        // limit the time allowed to withdraw
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);

        if (wt == WTYPE.Call) {
            withdrawFundsCall(_weiToWithdraw);
        } else if (wt == WTYPE.Send) {
            withdrawFundsSend(_weiToWithdraw);
        } else {
            withdrawFundsTransfer(_weiToWithdraw);
        }
    }

    // 1) No re-entrancy is possible, `transfer` will throw an exception
    // due to the gas stipend of 2300 gas
    function withdrawFundsTransfer(uint256 _weiToWithdraw) private {
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
        msg.sender.transfer(_weiToWithdraw);
    }

    // 2) `send` will not succeed due to the gas stipend of 2300 gas
    function withdrawFundsSend(uint256 _weiToWithdraw) private {
        bool success = msg.sender.send(_weiToWithdraw);
        if (success) {
            balances[msg.sender] -= _weiToWithdraw;
            lastWithdrawTime[msg.sender] = now;
        }
    }

    // 3) re-entrancy problem: in this way the attacker can drain
    // all funds stored in the contract
    function withdrawFundsCall(uint256 _weiToWithdraw) private {
        (bool success, ) = msg.sender.call.value(_weiToWithdraw)("");
        if (success) {
            balances[msg.sender] -= _weiToWithdraw;
            lastWithdrawTime[msg.sender] = now;
        }
    }
}
