const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Whitelist Contract", function () {
  it("Should be able to whitelist an user", async function () {
    const Whitelist = await ethers.getContractFactory("Whitelist");
    const whitelist = await Whitelist.deploy();
    await whitelist.deployed();

    const whiteListTx = await whitelist.addToWhitelist("0xAFEeb469Ce6376979Ea037b4CE6b7172f9018007");

    // wait until the transaction is mined
    await whiteListTx.wait();

    const userInWhitelist = await whitelist.checkWhitelist("0xAFEeb469Ce6376979Ea037b4CE6b7172f9018007");
    const userOutWhitelist = await whitelist.checkWhitelist("0xdF3e18d64BC6A983f673Ab319CCaE4f1a57C7097");

    expect(userInWhitelist).to.equal(true);
    expect(userOutWhitelist).to.equal(false);
  });
});