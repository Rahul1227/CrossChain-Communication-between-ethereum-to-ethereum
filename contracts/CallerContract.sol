// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./RPCProxy.sol";

contract CallerContract {

    RPCProxy public rpcProxy;
    address public remoteContract;
    uint public dappSpecificId;

    event RemoteMethodCalled(uint indexed dappId, uint myNumber, string myString);

    constructor(address rpcProxyAddr, address remoteContractAddr) public {
        rpcProxy = RPCProxy(rpcProxyAddr);
        remoteContract = remoteContractAddr;
    }

    // Function to call the remote method on CalleeContract
    function callRemoteMethod(uint _myNumber, string memory _myString, uint _dappSpecificId) public {
        dappSpecificId = _dappSpecificId;

        // Encoding the function call for remote execution
        bytes memory callData = abi.encodeWithSignature("remoteMethod(uint256,string)", _myNumber, _myString);

        // Making a remote call using RPCProxy
        rpcProxy.callContract(remoteContract, _dappSpecificId, callData, "myCallback");

        // Emitting an event for demonstration purposes
        emit RemoteMethodCalled(_dappSpecificId, _myNumber, _myString);
    }

    // Callback function to handle the result of the remote call
    function myCallback(uint _dappId, bytes memory _result, bool _success) public {
        require(_dappId == dappSpecificId, "Invalid dappSpecificId");
        // Handle the callback logic here
    }

    // Function to intentionally cause a failure in the remote call
    function callRemoteMethodFailedCallback(uint _myNumber, string memory _myString, uint _dappSpecificId) public {
        dappSpecificId = _dappSpecificId;

        // Encoding the function call for remote execution
        bytes memory callData = abi.encodeWithSignature("remoteMethod(uint256,string)", _myNumber, _myString);

        // Making a remote call using RPCProxy with a failing callback
        rpcProxy.callContract(remoteContract, _dappSpecificId, callData, "callbackWithFailure");
    }

    // Failing callback function to handle the result of the intentionally failed remote call
    function callbackWithFailure(uint _dappId, bytes memory _result, bool _success) public {
        require(_dappId == dappSpecificId, "Invalid dappSpecificId");
        require(!_success, "Callback should fail");
        // Handle the failure callback logic here
    }
}
