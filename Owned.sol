pragma solidity ^0.6.0;

contract Owned {
    address payable owner;
 
    constructor() public {
        owner = msg.sender;
    }
    
     modifier onlyOwner {
        require(msg.sender == owner ,"you are not the owner");
        _;
    }
    
    function isOwner() public view returns(bool) {
     return msg.sender == owner;   
    }
}
