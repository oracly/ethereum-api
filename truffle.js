var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic = process.env.TRUFFLE_MNEMONIC;
var infuraKey = process.env.INFURA_KEY;
var addressIndex = process.env.TRUFFLE_ADDRESS_INDEX;

module.exports = {
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    main: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/" + infuraKey, addressIndex);
      },
      gas: 3000000,
      network_id: 1
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/" + infuraKey, addressIndex);
      },
      gas: 3000000,
      network_id: 3
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/" + infuraKey, addressIndex);
      },
      gas: 3000000,
      network_id: 4
    },
    kovan: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://kovan.infura.io/" + infuraKey, addressIndex);
      },
      gas: 3000000,
      network_id: 42
    },
    test: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "http://localhost:8545/");
      },
      gas: 3000000,
      network_id: '*'
    }
  }
};
