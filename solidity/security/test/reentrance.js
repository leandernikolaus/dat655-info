const { BN, expectRevert } = require('@openzeppelin/test-helpers');

const EtherStore = artifacts.require("EtherStore");
const EtherStoreAttack = artifacts.require("EtherStoreAttack");

const WTYPE_CALL = new BN(0);
const WTYPE_SEND = new BN(1);
const WTYPE_TRANSFER = new BN(2);

contract("EtherStoreAttack", () => {
    beforeEach(async () => {
        this.accounts = await web3.eth.getAccounts();
        this.es = await EtherStore.new();
        this.esa = await EtherStoreAttack.new();
        // connect attacker to new ether store
        await this.esa.setEtherStoreAddress(this.es.address);

        // deposit 5 ether from account 1
        await this.es.depositFunds({ "from": this.accounts[1], "value": web3.utils.toWei("5") });
        // deposit 5 ether from account 2
        await this.es.depositFunds({ "from": this.accounts[2], "value": web3.utils.toWei("5") });
    });
    it("revert due to failed transfer", async () => {

        await expectRevert.unspecified(this.esa.attackEtherStore(WTYPE_TRANSFER, { "from": this.accounts[3], "value": web3.utils.toWei("1") }));

        esBalance = web3.utils.fromWei(await web3.eth.getBalance(this.es.address));
        assert.equal(esBalance, 10);

        attackerBalance = web3.utils.fromWei(await web3.eth.getBalance(this.esa.address));
        assert.equal(attackerBalance, 0);
    });

    it("does not successfully withdraw due to failed send", async () => {
        await this.esa.attackEtherStore(WTYPE_SEND, { "from": this.accounts[3], "value": web3.utils.toWei("1") });

        // But the initial deposit performed by the attacker by calling
        // `attackEtherStore` still succeed.
        esBalance = web3.utils.fromWei(await web3.eth.getBalance(this.es.address));
        assert.equal(esBalance, 11);

        attackerBalance = web3.utils.fromWei(await web3.eth.getBalance(this.esa.address));
        assert.equal(attackerBalance, 0);
    });

    it("successfully withdraw all funds in the contract due to the re-entrancy attack", async () => {
        await this.esa.attackEtherStore(WTYPE_CALL, { "from": this.accounts[3], "value": web3.utils.toWei("1") });

        esBalance = web3.utils.fromWei(await web3.eth.getBalance(this.es.address));
        assert.equal(esBalance, 0);

        attackerBalance = web3.utils.fromWei(await web3.eth.getBalance(this.esa.address));
        assert.equal(attackerBalance, 11);
    });
});