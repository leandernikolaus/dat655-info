const TimeLock = artifacts.require("TimeLock");
const SafeTimeLock = artifacts.require("SafeTimeLock");
const EtherStore = artifacts.require("EtherStore");
const EtherStoreAttack = artifacts.require("EtherStoreAttack");

module.exports = function(deployer) {
  deployer.deploy(TimeLock);
  deployer.deploy(SafeTimeLock);
  deployer.deploy(EtherStore);
  deployer.deploy(EtherStoreAttack);
};
