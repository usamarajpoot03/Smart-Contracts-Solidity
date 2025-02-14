pragma solidity ^0.5.13;

contract FunctionExample {
    
    mapping(address => uint) public balanceReceived;
    address payable owner;

    constructor() public {
        owner = msg.sender;
    }
    
    function destroySmartContract() public payable {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function convertIntoEther(uint _amount) public pure returns(uint) {
        return _amount/1 ether;
    }

    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount ) public {
        uint balanceOfSender = balanceReceived[msg.sender];
        require (balanceOfSender >= _amount, 'You have no balance to widthdraw');
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    function() external payable  {
        receiveMoney();
    }
}   