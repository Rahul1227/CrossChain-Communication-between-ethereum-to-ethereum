const TrafficManagement = artifacts.require("TrafficManagement");

module.exports = function(deployer) {
  deployer.deploy(TrafficManagement);
};
