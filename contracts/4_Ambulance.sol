// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./3_Hospital.sol";
import "./1_Traffic.sol";

contract AmbulanceContract {
    enum AmbulanceStatus { Free, Busy }

    struct Ambulance {
        string numberPlate;
        string currentLocation;
        AmbulanceStatus status;
    }

    HospitalContract public hospitalContract;
    TrafficManagement public trafficContract;

    mapping(string => Ambulance) internal ambulances;

    constructor(address _hospitalContractAddress, address _trafficContractAddress) public {
        hospitalContract = HospitalContract(_hospitalContractAddress);
        trafficContract = TrafficManagement(_trafficContractAddress);
    }

    function getStatus(string memory _numberPlate) public view returns (AmbulanceStatus) {
        return ambulances[_numberPlate].status;
    }

    function getCurrentLocation(string memory _numberPlate) public view returns (string memory) {
        return ambulances[_numberPlate].currentLocation;
    }

    function respondToCommand(string memory _numberPlate, string memory _command) public {
        // Implement response logic here
    }

    function getHospitalInfo() public view returns (HospitalContract.Hospital memory) {
        return hospitalContract.getHospitalInfo();
    }

    function getExpectedTime(string memory _locationFrom, string memory _locationTo) public view returns (uint256) {
        return trafficContract.getEstimatedTravelTime(_locationFrom, _locationTo);
    }

    function findOptimizedPath(string memory _locationFrom, string memory _locationTo) public view returns (string[] memory) {
        return trafficContract.optimizeTravelTime(_locationFrom, _locationTo);
    }
}
