
module.exports = {

  // Make sure port fits you ganache port.
  networks: {
    ganache: { // ganache-cli
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777"
    },
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7555,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.5.11",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
}
