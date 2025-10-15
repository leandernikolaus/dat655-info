// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

/* 
Exercise 1: Is require, required?
1- Try calling both transfer and transfer2 functions. 
2- Try calling them in a way that they fail (transfering a value more than the balance). 
3- What is the difference? 
*/

/* 
Exercise 2: self destruction!
1- Try calling close function. What does it do?
2- There is a security vulnerability in this function. Can you find and fix it?
*/

/* 
Exercise 3: underflow!
1- Try calling the transferunder function for a account with 0 balance in the system, to transfer some amount to another account.
2- What happens? Why?
*/

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;
  address public owner;

  constructor(uint _initialSupply) {
    balances[msg.sender] = _initialSupply;
    totalSupply = _initialSupply;
    owner = msg.sender;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] >= _value, "Insufficient balance");
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function transfer2(address _to, uint _value) public returns (bool) {
    if (balances[msg.sender] >= _value) {
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      return true;
    } else {
      return false;
    }
  }

  function transferunder(address _to, uint _value) public returns (bool) {
    if (balances[msg.sender] - _value >=0 ) {
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      return true;
    } else {
      return false;
    }
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }

  function close(address _to) public {
    require(msg.sender == owner, "Only owner can close");
    selfdestruct(payable(_to));
  }
}