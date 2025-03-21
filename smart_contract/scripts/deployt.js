const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const Transactions = await hre.ethers.getContractFactory("Transactions");

  // Deploy the contract
  const transactions = await Transactions.deploy();

  // Wait for deployment to finish
  await transactions.waitForDeployment(); // ✅ FIX: Correct function to use

  console.log("Transactions deployed to:", await transactions.getAddress());
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });