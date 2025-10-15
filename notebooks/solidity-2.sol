// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/* 
Exercise 1: Storing is expensive!
Below is a simple contract for storing bytes in blockchain. 
1- Deploy the contract, then add a few different byte arrays of varying lengths. 
2- Observe and compare the gas costs when storing different lengths of data.
*/

contract StringStorage {
    string public storedString;

    // Function to store a new string
    function storeString(string memory _newString) public {
        storedString = _newString;
    }
}

/* 
Exercise 2: Store as little as possible!
Since storing is expensive on chain, we should avoid it as much as possible. 
Below is a stub of a contract with two different functions. 
1- Deploy the contract and try these two functions. Do you understand the difference between memory and storage? 
2- Observe and compare the gas costs for these two functions. What do you think?
3- When do you think we should use storage, and when should we use memory?
*/

contract MemoryVsStorage {
    uint[] public storageArray;

    // Initialize the storage array
    constructor() {
        storageArray.push(1);
        storageArray.push(2);
        storageArray.push(3);
    }

    // Modify using storage reference (changes will persist)
    function modifyWithStorage() public {
        uint[] storage ref = storageArray;
        for (uint i = 0; i < ref.length; i++) {
            ref[i] *= 2; 
        }
    }

    // Modify using memory reference (changes will NOT persist)
    function modifyWithMemory() public view returns (uint[] memory) {
        uint[] memory tempArray = storageArray;
        for (uint i = 0; i < tempArray.length; i++) {
            tempArray[i] *= 2; 
        }
        return tempArray;
    }
}

/* 
Exercise 3: Everything is public!
Everything is public in blockchain. So sometimes we need to store the hash first, and then verify it later. 
Below is a simple contract for storing and comparing hashes. 
1- Implement storeHash and compareHash functions. 
1- Deploy the contract, then call storeHash with strings of varrying sizes. How much gas is needed?
2- Call the compare hash function. Observe and compare the gas costs with different strings.
3- Is it cheap to compute hashes on chain? 
*/

contract StringHashStorage {
    // State variable to store the hash of the string
    bytes32 public storedHash;

    // Function to receive a string, calculate its hash, and store it
    function storeHash(string memory _input) public {
        //Calculate hash of the input using keccak256(abi.encodePacked(_input)
        // Store the hash in storedHash
    }

    function compareHash(string memory _input) public view returns (bool) {
        //Calculate hash of _input and compare it with storedHash. 
    }

}

