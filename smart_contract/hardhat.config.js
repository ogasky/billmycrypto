require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
    solidity: "0.8.28",
    networks: {
        polygon: {
            url: process.env.ALCHEMY_POLYGON_RPC_URL,
            accounts: [process.env.PRIVATE_KEY], // Ensure this key is correct
     },
    },
};
