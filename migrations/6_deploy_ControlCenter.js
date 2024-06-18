const ControlCenter = artifacts.require("ControlCenter");
const AmbulanceContract = artifacts.require("AmbulanceContract");
const HospitalContract = artifacts.require("HospitalContract");
const TrafficManagement = artifacts.require("TrafficManagement");

module.exports = async function(deployer) {
  // Ensure the HospitalContract, TrafficManagement, and AmbulanceContract are deployed first
  const hospitalInstance = await HospitalContract.deployed();
  const trafficInstance = await TrafficManagement.deployed();
  const ambulanceInstance = await AmbulanceContract.deployed();

  // Now deploy the ControlCenter with the addresses of AmbulanceContract, HospitalContract, and TrafficManagement
  await deployer.deploy(ControlCenter, ambulanceInstance.address, hospitalInstance.address, trafficInstance.address);
};
