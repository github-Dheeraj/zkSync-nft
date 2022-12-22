require("@matterlabs/hardhat-zksync-deploy");
require("@matterlabs/hardhat-zksync-solc");
require("dotenv").config()
module.exports = {
    zksolc: {
        version: "1.2.1",
        compilerSource: "binary",
        settings: {},
    },
    defaultNetwork: "zkSyncTestnet",

    networks: {
        zkSyncTestnet: {
            url: "https://zksync2-testnet.zksync.dev",
            ethNetwork: "https://eth-goerli.g.alchemy.com/v2/t1Go_ayvy6JnXRjSoDusKPWxlD9uqOTO", // Can also be the RPC URL of the network (e.g. `https://goerli.infura.io/v3/<API_KEY>`)
            zksync: true,
            accounts: [`0x${process.env.PRIVATE_KEY}`]
        },
    },
    solidity: {
        version: "0.8.16",
    },
};