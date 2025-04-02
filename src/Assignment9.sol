// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import Openzeppelin Ownable contract
import "@openzeppelin/contracts/access/AccessControl.sol";
// inherit from Ownable contract 
contract Assignment9 is AccessControl {
    // create a public array called `deployedContracts` to store contracts addresses in it 
    address[] public deployedContracts;

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");

    // call Ownable constructor of openzeppelin contract
    constructor () {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(CREATOR_ROLE, msg.sender);
        
    }

    // @dev Factory to deploy new instances of `SimpleContract`
    // make only the owner is the one who can call this function
    function createContract() external onlyRole (CREATOR_ROLE) {
        // deploy new instance of SimpleContract
            // Hint: When you create a new instance, do not forget to pass any arbitrary initial value in the constructor
        SimpleContract newContract = new SimpleContract(1);

        // push the new deployed instance to deployedContracts array
        deployedContracts.push(address(newContract));
    }
}

// Simple contract to be deployed by the factory
contract SimpleContract {
    uint256 public value;

    constructor(uint256 _initialValue) {
        value = _initialValue;
    }

    function setValue(uint256 newValue) external {
        value = newValue;
    }
}
