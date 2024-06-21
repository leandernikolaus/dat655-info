pragma solidity >=0.4.25 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MetaCoin.sol";

contract TestMetaCoin {

  // function testInitialBalanceUsingDeployedContract() public {
  //   MetaCoin meta = MetaCoin(DeployedAddresses.MetaCoin());

  //   uint expected = 10000;

  //   Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  // }

  address constant budy = address(0x883729F776E37E7dc2517AA7209939BE264B6298);

  function testInitialBalanceWithNewMetaCoin() public {
    
    MetaCoin meta = new MetaCoin(budy, 3);

    uint expected = 10000;
    uint expected1 = 5000;
    uint expected3 =30000;

    Assert.equal(meta.getBalance(address(this)), expected, "Owner should have 10000 MetaCoin initially");
    Assert.equal(meta.getBalance(budy), expected1, "Budy should have 5000 MetaCoin initially");
    Assert.equal(meta.getBalanceInEth(address(this)), expected3, "Owner should have 30000 MetaCoin ether equivalent initially");
  }
}
