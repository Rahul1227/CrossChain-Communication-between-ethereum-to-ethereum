const CalleeContract = artifacts.require("CalleeContract");

module.exports = function(deployer) {
  deployer.deploy(CalleeContract);
};
