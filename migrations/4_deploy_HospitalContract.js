const HospitalContract = artifacts.require("HospitalContract");

module.exports = function(deployer) {
  deployer.deploy(
    HospitalContract,
    "KIMS",
    "Bhubaneswar",
    "Contact: 123-456-789",
    "Facilities: ICU, MRI"
  );
};
