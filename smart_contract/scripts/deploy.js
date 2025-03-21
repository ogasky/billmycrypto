const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const BillMyCrypto = await hre.ethers.getContractFactory("BillMyCrypto");

  // Deploy the contract
  const billMyCrypto = await BillMyCrypto.deploy();

  // Wait for deployment to finish
  await billMyCrypto.waitForDeployment(); // ✅ FIX: Correct function to use

  console.log("BillMyCrypto deployed to:", await billMyCrypto.getAddress());
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
