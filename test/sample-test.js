const { expect } = require("chai");

describe("Greeter", function() {
  it("Should return the new greeting once it's changed", async function() {
    const SampleERC721 = await ethers.getContractFactory("SampleERC721");
    const zombie = await SampleERC721.deploy();

    await zombie.deployed();
  });
});
