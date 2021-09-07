//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import "./Owner.sol";
import "./ParkingLot.sol";

contract ParkingArea is Owner{
    
    mapping (uint=>address) public lots;
    
    function createLot(uint _lotId) external checkOwnership{
        ParkingLot lot = new ParkingLot(_lotId);
        lots[_lotId]=address(lot);
    }
    
    function isLotFree(uint _lotId) external view returns(bool){
        ParkingLot lot = ParkingLot(lots[_lotId]);
        return lot.isLotFree();
        
    }
    
    function parkAtLot(uint _lotId) payable external {
        ParkingLot lot = ParkingLot(lots[_lotId]);
        lot.payForPark{value:msg.value}();
    } 
    
    function updateLotStatus(uint _lotId) external checkOwnership{
        ParkingLot lot = ParkingLot(lots[_lotId]);
        lot.updateParkStatus();
    }
}
