pragma solidity ^0.5.13;

contract Owned {
    address payable owner;
 
    constructor() public {
        owner = msg.sender;
    }
    
     modifier onlyOwner {
        require(msg.sender == owner ,"you are not the owner");
        _;
    }
}
