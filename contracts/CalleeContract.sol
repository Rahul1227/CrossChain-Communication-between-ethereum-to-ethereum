// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract CalleeContract {

    uint public myNumber;
    string public myString;

    // Function to demonstrate a failing method
    function failingMethod() public {
        require(false, "This method intentionally fails");
    }

    // Function to be called remotely
    function remoteMethod(uint _myNumber, string memory _myString) public {
        myNumber = _myNumber;
        myString = _myString;
    }
}
