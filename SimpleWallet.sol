pragma solidity ^0.6.0;
import '/Allowance.sol';
contract SimpleWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _to, uint _amount);
    
    function withdrawMoney(address payable _to, uint _amount) public OwnerOrAllowed(_amount) {
        if(msg.sender != owner())
        {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}