// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
  enum Statuses{
    Vacant,
    Occupied
    }
  Statuses public currentStatus;
  
  address payable public owner;
  
  event Occupy(address _occupant, uint _amount);
  
  constructor() {
    owner = payable(msg.sender);
    currentStatus = Statuses.Vacant;
  }
  
  modifier onlyWhileVacant {
    require(currentStatus == Statuses.Vacant, "Already Occupied");
    _;
  }
  
  modifier costs(uint _amount) {
    require(msg.value >= _amount , "Not enough ethers provided");
    _;
  }
  
  function book() public payable onlyWhileVacant costs(2 ether) {
    currentStatus = Statuses.Occupied;
    
    // owner.transfer(msg.value);
    (bool sent, bytes memory data) = owner.call{value: msg.value}("H");
    require(true);
    
    emit Occupy(msg.sender, msg.value);
  
    }
}
