const MetaCoin = artifacts.require("MetaCoin");
const { expectEvent, expectRevert } = require('@openzeppelin/test-helpers');

contract('MetaCoin', (accounts) => {
  describe('deployment test', ()=> {
    it('should put 10000 MetaCoin in the first account', async () => {
      const metaCoinInstance = await MetaCoin.deployed();
      const balance = await metaCoinInstance.getBalance.call(accounts[2]);

      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
    it('should call a function that depends on a linked library', async () => {
      const metaCoinInstance = await MetaCoin.deployed();
      const metaCoinBalance = (await metaCoinInstance.getBalance.call(accounts[1])).toNumber();
      const metaCoinEthBalance = (await metaCoinInstance.getBalanceInEth.call(accounts[1])).toNumber();

      assert.equal(metaCoinEthBalance, 3 * metaCoinBalance, 'Library function returned unexpected function, linkage may be broken');
    });
  });
  describe('constructor', ()=> {
    before(async () => {
      meta = await MetaCoin.new(accounts[3],4, {from: accounts[1]});
    });
    it('should put 10000 MetaCoin in the creator account', async () => {
      const balance = await meta.getBalance.call(accounts[1]);
  
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
    it('should put 5000 MetaCoin in the budies account', async () => {
      const balance = await meta.getBalance.call(accounts[3]);
  
      assert.equal(balance.valueOf(), 5000, "5000 wasn't in the first account");
    });
    it('should call a function that depends on a linked library', async () => {
      const metaCoinBalance = (await meta.getBalance.call(accounts[3])).toNumber();
      const metaCoinEthBalance = (await meta.getBalanceInEth.call(accounts[3])).toNumber();
  
      assert.equal(metaCoinEthBalance, 4 * metaCoinBalance, 'Library function returned unexpected function, linkage may be broken');
    });
  });
  
  it('should send coin correctly', async () => {
    const meta = await MetaCoin.new(accounts[1],4, {from: accounts[0]});
    
    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (await meta.getBalance.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await meta.getBalance.call(accountTwo)).toNumber();

    // Make transaction from first account to second.
    const amount = 10;
    const { logs } = await meta.sendCoin(accountTwo, amount, { from: accountOne });

    // Get balances of first and second account after the transactions.
    const accountOneEndingBalance = (await meta.getBalance.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await meta.getBalance.call(accountTwo)).toNumber();


    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
    expectEvent.inLogs(logs, 'Transfer', {
      _from: accounts[0],
      _to: accounts[1],
      _value: "10",
    });
  });
  it('revert if sender does not have coin', async () => {
    const meta = await MetaCoin.new(accounts[1],4, {from: accounts[0]});
    
    // Setup 2 accounts.
    const accountOne = accounts[1];
    const accountTwo = accounts[0];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (await meta.getBalance.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await meta.getBalance.call(accountTwo)).toNumber();

    // Make transaction from first account to second.
    const amount = 6000;
    await expectRevert(meta.sendCoin(accountTwo, amount, { from: accountOne }), 'insufficient metacoin');
  });
  it('anyone can buy coins', async () => {
    const meta = await MetaCoin.new(accounts[1],4, {from: accounts[0]});

    const accountFour = accounts[3];

    await meta.buy({from: accountFour, value: 40000});
    const balance = await meta.getBalanceInEth(accountFour);
    assert.equal(balance.valueOf(), 40000, 'did not receive correct balance on payment');
  });
});
