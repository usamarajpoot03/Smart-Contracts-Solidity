pragma solidity ^0.6.0;

contract SendMoneyExample
{
    
    address owner;
    uint public balanceReceived;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withDrawBalance() public {
        require(owner == msg.sender, "not the owner");
        address payable to = msg.sender;
        to.transfer(this.getBalance());
    }
    
    function withDrawBalanceTo(address payable to) public {
        require(owner == msg.sender, "not the owner");
        to.transfer(this.getBalance());
    }
    
    function destroySmartContact(address payable _to) public {
        require(owner == msg.sender, "not the owner");
        selfdestruct(_to);    
    }
    
    
    
}   