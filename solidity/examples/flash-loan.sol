// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IFlashLoanReceiver {
    function executeOperation(uint256 amount) external payable;
}

contract SimpleFlashLender {
    

    receive() external payable {}

    function flashLoan(address receiver, uint256 amount) external {
        uint256 balanceBefore = address(this).balance;
        require(balanceBefore >= amount, "Insufficient liquidity");

        (bool sent, ) = payable(receiver).call{
            value: amount
        }(abi.encodeWithSelector(IFlashLoanReceiver.executeOperation.selector, amount));
        require(sent, "Loan or callback failed");

        require(address(this).balance >= balanceBefore, "Loan not repaid");
    }
}

contract SimpleFlashBorrower is IFlashLoanReceiver {
    SimpleFlashLender public immutable lender;
    event BalanceLogged(uint256 balance);

    constructor(SimpleFlashLender _lender) {
        lender = _lender;
    }

    function requestLoan(uint256 amount) external {
        lender.flashLoan(address(this), amount);
    }

    function executeOperation(uint256 amount) external payable override {
        require(msg.sender == address(lender), "Unauthorized lender");

        // Use the borrowed Ether here.
        emit BalanceLogged(address(this).balance);
        

        (bool repaid, ) = payable(address(lender)).call{value: amount}("");
        require(repaid, "Repayment failed");
    }

    receive() external payable {}
}