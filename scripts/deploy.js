const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // For testing, we use the deployer as the verifier initially.
  // In production, this should be a dedicated backend wallet address.
  const verifierAddress = deployer.address;

  const ConnectivityToken = await hre.ethers.getContractFactory("ConnectivityToken");
  const token = await ConnectivityToken.deploy(deployer.address, verifierAddress);

  await token.waitForDeployment();

  console.log("ConnectivityToken deployed to:", await token.getAddress());
  console.log("Verifier Address set to:", verifierAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
