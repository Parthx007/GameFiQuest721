const hre = require("hardhat");

async function main() {
  const GameFiQuest = await hre.ethers.getContractFactory("GameFiQuest");
  const gameFiQuest = await GameFiQuest.deploy();

  await gameFiQuest.deployed();
  console.log(`GameFiQuest deployed to: ${gameFiQuest.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
