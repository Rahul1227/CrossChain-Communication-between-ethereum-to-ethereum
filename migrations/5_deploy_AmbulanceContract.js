const AmbulanceContract = artifacts.require("AmbulanceContract");
const HospitalContract = artifacts.require("HospitalContract");
const TrafficManagement = artifacts.require("TrafficManagement");

module.exports = async function(deployer) {
  // Ensure the HospitalContract and TrafficManagement are deployed first
  await deployer.deploy(HospitalContract, "KIMS", "Bhubaneswar", "Contact: 123-456-789", "Facilities: ICU, MRI");
  const hospitalInstance = await HospitalContract.deployed();

  await deployer.deploy(TrafficManagement);
  const trafficInstance = await TrafficManagement.deployed();

  // Now deploy the AmbulanceContract with the addresses of HospitalContract and TrafficManagement
  await deployer.deploy(AmbulanceContract, hospitalInstance.address, trafficInstance.address);
};
