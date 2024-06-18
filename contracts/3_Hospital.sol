// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./2_Patient.sol";

contract HospitalContract {
    struct Hospital {
        string name;
        string location;
        string contactDetails;
        string facilitiesAvailable;
    }

    struct Patient {
        string name;
        uint256 age;
        string location;
        uint256 contractNumber;
        string bloodGroup;
        string diabeticHistory;
        string fractureHistory;
        string allergies;
        string medications;
        string surgeries;
        string emergencyContact;
    }

    Hospital public hospitalInfo;
    PatientContract public patientContract;
    mapping(address => Patient) public patients;

    constructor(
        string memory _name,
        string memory _location,
        string memory _contactDetails,
        string memory _facilitiesAvailable
    ) public {
        hospitalInfo = Hospital(_name, _location, _contactDetails, _facilitiesAvailable);
        patientContract = new PatientContract();
    }

    function getHospitalInfo() public view returns (Hospital memory) {
        return hospitalInfo;
    }

    function getPatientInfo(address patientContractAddress) public view returns (string memory, uint256, string memory, uint256, string memory) {
        PatientContract patient = PatientContract(patientContractAddress);
        return patient.getGeneralInformation();
    }

    function getSensitivePatientInfo(address patientContractAddress, string memory passkey) public view returns (string memory, string memory, string memory, string memory, string memory) {
        PatientContract patient = PatientContract(patientContractAddress);
        return patient.getSensitiveInformation(passkey);
    }

    function addNewPatient(
        string memory _name,
        uint256 _age,
        string memory _location,
        uint256 _contractNumber,
        string memory _bloodGroup,
        string memory _diabeticHistory,
        string memory _fractureHistory,
        string memory _allergies,
        string memory _medications,
        string memory _surgeries,
        string memory _emergencyContact
    ) public {
        patients[msg.sender] = Patient(
            _name,
            _age,
            _location,
            _contractNumber,
            _bloodGroup,
            _diabeticHistory,
            _fractureHistory,
            _allergies,
            _medications,
            _surgeries,
            _emergencyContact
        );
    }
}
