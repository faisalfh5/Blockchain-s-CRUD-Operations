// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {

  const Contract = await ethers.getContractFactory("GameLand");

  // here we deploy the contract
  const deployedContract = await Contract.deploy();

  // wait for the contract to deploy
  await deployedContract.deployed();

  // print the address of the deployed contract
  console.log("NFT Contract Address:", deployedContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
