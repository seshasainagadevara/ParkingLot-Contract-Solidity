//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Owner{
    
     address payable public owner;
     constructor(){
           owner = payable(tx.origin);
     }
    modifier checkOwnership(){
        require(owner==tx.origin, "access denied");
        _;
    }
    
}

