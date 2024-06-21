// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	mapping (address => uint) balances;
	uint conversionFactor;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor(address budy,uint cFactor) public {
		balances[msg.sender] = 10000;
		balances[budy] = 5000;
		conversionFactor = cFactor;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		require(balances[msg.sender] >= amount, 'insufficient metacoin');
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),conversionFactor);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}

	function buy() public payable returns(uint) {
		uint amount = ConvertLib.convertBack(msg.value, conversionFactor);
		require(ConvertLib.convert(amount, conversionFactor) == msg.value, 'payed amount cannot be evenly devided into metacoins');
		balances[msg.sender] += amount;
	}
}
