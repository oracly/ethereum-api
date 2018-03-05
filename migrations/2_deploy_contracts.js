var Ownable = artifacts.require("./zeppelin/ownership/Ownable.sol");
var Connector = artifacts.require("./OraclyConnector.sol");
var Verifier = artifacts.require("./OraclyVerifier.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.link(Ownable, Connector);
  deployer.deploy(Connector);
  deployer.link(Ownable, Verifier);
  deployer.deploy(Verifier);

};
