//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Address.sol";
//import "@openzeppelin/contracts/security/Pausable.sol";



contract RBAC is AccessControl{


//Role for the withdrawer
bytes32 public constant WITHDRAWAL_ROLE = keccak256("WITHDRAWAL_ROLE");

//creating events
event fundsDeposit(address indexed sender, uint _amt);
event fundsWithdrawan(address indexed receiver, uint _amt);

address private withdrawerAdd;

    constructor(address withdrawer){
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _grantRole(WITHDRAWAL_ROLE, withdrawerAdd);
        withdrawerAdd = withdrawer;
    }

    // deposit function

    function deposit() external payable {
        require(msg.value >=  1 ether, "Value should not be zero");
        emit fundsDeposit(msg.sender, msg.value);
    }


    function withdrawalFunds()external payable  {
        require(hasRole(WITHDRAWAL_ROLE,msg.sender),"Caller should be withdrawer");
        address payable receiver = payable(msg.sender);
        uint256 balance = address(this).balance;
            require(balance > 0, "No funds to withdraw");
            (bool send,) = receiver.call{value : msg.value}("");
            require(send,"transfer failed");
            emit fundsWithdrawan(msg.sender, balance);
        }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    
    // // Allows Default Admin to pause the contract
    // function pause() public onlyRole(DEFAULT_ADMIN_ROLE) {
    //     _pause();
    // }

    // // Allows Default Admin to unpause the contract
    // function unpause() public onlyRole(DEFAULT_ADMIN_ROLE) {
    //     _unpause();
    // }

}


