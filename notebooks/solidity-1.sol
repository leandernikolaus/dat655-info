// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

/* 
Exercise 1: Implementing a contract!
Below is a simple contract for keeping balances and transfer the credits. 
1- Implement the constructor, transfer and balanceOf functions. 
2- Deploy the contract and play around with it. Check that everything works. 
*/
contract Token_naive {

  address[] public addresses;
  uint[] public balances;
  uint public totalSupply;

  constructor(uint _initialSupply) 
  {
    // The constructor receives the _initialSupply that determines the money of the owner. 
    // Use msg.sender for the address of whoever that has called the function (owner). 
    // Use the push function to add the owner and their initial balance. 
  }

  function transfer(address _to, uint _value) public returns (bool) 
  {
    // This function should transfer the _value from the account msg.sender to the account _to. 
    // Check whether msg.sender exists in the array and has enough balance using require
    // If _to is already in array, increase its balance. Else, add it to the array.
  }

  function balanceOf(address _owner) public view returns (uint balance) 
  {
    // return balance of the account _owner. 
  }

}

/* 
Exercise 2: Loop is bad!
1- Try increasing the number of accounts in the array. Check the gasses. 
2- Can you guess with the current gass limit, what is the maximum array length? 
*/


/* 
Exercise 3: Avoiding loops!
Below is the same contract that uses mapping instead of arrays to avoid loops. 
1- Implement the constructor, transfer and balanceOf functions. 
2- Deploy the contract and play around with it. Check that everything works.
*/

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;
  address public owner;

  constructor(uint _initialSupply) 
  {
    // The constructor receives the _initialSupply that determines the money of the owner. 
    // Use msg.sender for the address of whoever that has called the function (owner). 
    // Use the balances[msg.sender] to change the balance of the sender. 
    // Adjust the owner as the msg.sender
  }

  function transfer(address _to, uint _value) public returns (bool) 
  {
    // This function should transfer the _value from the account msg.sender to the account _to. 
    // Check whether msg.sender has enough balance using require. Do we need to check whether it exists or not in the mapping?
    // Increase _to balance and decrease sender balance.
  }

  function balanceOf(address _owner) public view returns (uint balance) 
  {
    // return balance of the account _owner. 
  }

}

/* 
Exercise 4: Comparison!
Below is the same contract that uses mapping instead of arrays to avoid loops. 
1- Try increasing the number of accounts. Check the gasses. 
2- Can you guess with the current gass limit, what is the maximum number of accounts? 
3- Draw a chart and compare Token and Token_naive gase usage having 1,2,3,4,5 accounts. What do you think?
*/