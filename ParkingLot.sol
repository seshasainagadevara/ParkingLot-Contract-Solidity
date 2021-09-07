//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "./Owner.sol";

contract ParkingLot is Owner{
    
    uint public lotId;
   
    enum ParkingLotStatus {EMPTY, FULL}
    ParkingLotStatus public lotStatus;
    
    constructor(uint _lotId){
        super;
        lotId = _lotId;
        lotStatus = ParkingLotStatus.EMPTY;
    }
    
    modifier checkVacancy(){
         require(lotStatus == ParkingLotStatus.EMPTY, "CURRENTLY NO EMPTY SLOTS");
         _;
    }
    
    modifier checkEther(uint _amount){
         require(msg.value>=_amount,"not enough");
         _;
    }
    
    event Parked(address _parker, uint _value);
    
    function payForPark() payable external checkVacancy checkEther(10 ether){
        lotStatus = ParkingLotStatus.FULL;
        owner.transfer(msg.value);
        emit Parked(msg.sender, msg.value);
    }
    
    function updateParkStatus() external checkOwnership{
        lotStatus = ParkingLotStatus.EMPTY;
    }
    
    function isLotFree() external view returns(bool){
        
        if(lotStatus == ParkingLotStatus.EMPTY)return true;
        else return false;
        
    }
    
}