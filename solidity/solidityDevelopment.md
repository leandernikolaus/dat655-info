# Developing Smart Contracts with Solidity, Ganache and Truffle

## Preliminaries
### Install:

* Install [Ganache](https://www.trufflesuite.com/ganache)
* Install [node.js](https://nodejs.org) including the npm package manager

### Ganache

Ganache simulates a local instance of the Ethereum blockchain, and a Ethereum client connected to the blockchain.
The **Quickstart** blockchain includes 10 addresses each holding 100 Ether. This allows you to get started and send some ether back and forth.
On the cogwheel, you can:
* Edit the port on which the Ethereum client is running (needed to connect to it later)
* Select a truffle project (workspace) that will be displayed.

### VSCode

I like to use VSCode. Install e.g. the *solidity* extension from Juan Blanco.

### Truffle

Use the npm package manager to install truffle. For global install do:
```
$ npm install -g truffle
```

Create a new folder, inside the folder, you can initialize a new project:
```
$ mkdir mynewproject
$ cd mynewproject
$ truffle init
```

The folder will now cointain the following:
* `contracts/`: Directory for Solidity contracts
* `migrations/`: Directory for scriptable deployment files
* `test/`: Directory for test files
* `truffle-config.js`: Config file, to configure address for ethereum client, slidity compiler version, ...

## Example

We will look at an example, created by the truffle people:
```
$ mkdir metaCoin
$ cd metaCoin
$ truffle unbox metacoin
```

The project contains the same folders as described above.

### Connecting truffle and Ganache
* In `truffle-config.js` uncomment the network config and check port, to connect to a ganache.
* In *Ganache*, go to settings, **WORKSPACE**, **ADD PROJECT** and select the `truffle-config.js` file of our metaCoin.

OBS: If you use the Quickstart workspace in Ganache, you will have to do that again!

### Compiling the existing contracts

Check out the contracts. In `contracts/`. 
* `Migrations.sol` is the standard migration coontract used by truffle to manage deployments.
* `ConvertLib.sol` is a library that contains a function for simple currency conversion.
* `MetaCoin.sol` is a simple kind of token. Different addresses can have a token and send tokens to each other.
    The MetaCoin conract uses the ConvertLib.

```
$ truffle compile
```
Will compile the contracts.
After compilation you can find the `json` descriptions of the conracts in the `build/` folder.

### Deploy the contracts

The `migrations/` folder contains javascript code to deploy the contracts to the chain. 
Chechout this [blog](https://medium.com/@blockchain101/demystifying-truffle-migrate-21afbcdf3264) if to better understand what the migrations do.


```
$ truffle migrate
```
This should create contract instances on the chain. 
Check out the contracts in Ganache.
To transactions have also been made on the `Migrations` contract.
They mark the first and second migration as completed. (`1_....js` and `2_....js` files)

### Truffle console

You can use the contracts from the truffle console, using JavaScript.
*OBS: Most methods return promises. We use async/await to handle these.*

```
#Start the console:
$ truffle console
```

The console already has a reference to `web3` injected, a JavaScript library with many utilities. `
Checkout the [documentation](https://web3js.readthedocs.io/).

```javascript
// get the deployed version of the MetaCoin contract:
let contract = await MetaCoin.deployed();

// get the addresses of the external accounts created for you on the ganache blockchain:
let accounts = await web3.eth.getAccounts();

// returns a BN (Big number)
let balance = await contract.getBalance(accounts[0]);
console.log(balance.toString());

// send coins from the default address (accounts[0])
contract.sendCoin(accounts[1], 1000);

// send coins from the a different address
contract.sendCoin(accounts[2], 1000, { from: accounts[1], value: 0});
```

Check *Ganache* to verify that functions `getBalance` and `getBalanceInEth` do not trigger transactions. That is because they have the `view` attribute.

For transactions, it is not possible to inspect the return value. Check emitted Events instead.

### Changing the contract
We can change the `MetaCoin` constructor to include a conversions rate, that will then be used in `getBalanceInEth`.

To deploy the new contract, we can create a new migration file: `3_redeploy_metaCoin.js`.

The following deploys the `metaCoin` contract with parameter `3`. This is deployed using the second address:
```javascript
module.exports = function(deployer, network, accounts) {
  //deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin, 3, {from: accounts[2]});
};
```

### Tests
The `test/` folder contains tests. 
Tests can be written both in Solidity and in JavaScript.
* `test/TestMetaCoin.sol` contains two tests in Solidity.
* `test/metacoin.js` contains tests written in Javascript.

To allow us to test for events and errors we can include libraries:
```javascript
const { expectEvent, expectRevert } = require('@openzeppelin/test-helpers');
```

To install this use
```
$ npm install @openzeppelin/test-helpers
```
