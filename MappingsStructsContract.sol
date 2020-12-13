pragma solidity ^0.5.13;

contract MappingsStructsContract {
    
    struct Payment {
        uint amount;
        uint timeStamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayents;
        mapping(uint => Payment) payents;
    }
    
    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        
        assert(balanceReceived[msg.sender].totalBalance + msg.value >= balanceReceived[msg.sender].totalBalance);
        balanceReceived[msg.sender].totalBalance += msg.value;
        Payment memory payment = Payment(msg.value, now);
        balanceReceived[msg.sender].payents[ balanceReceived[msg.sender].numPayents] = payment;
        balanceReceived[msg.sender].numPayents++;
    }
    
    function withdrawMoney(address payable _to, uint _amount ) public {
        uint balanceOfSender = balanceReceived[msg.sender].totalBalance;
        require (balanceOfSender >= _amount, 'You have no balance to widthdraw');
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balanceOfSender = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceOfSender);
    }
    
}   