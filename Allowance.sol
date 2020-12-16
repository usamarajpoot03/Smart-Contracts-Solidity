pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    
    using SafeMath for uint;
    
    mapping(address => uint) public allowance;
    
    event AllowanceChanged(address indexed _forWho,address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    
    modifier OwnerOrAllowed(uint _amount) {
        require(msg.sender == owner() || allowance[msg.sender] >= _amount, "you are not allowed");
        _;
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    function reduceAllowance(address _fromWhom, uint _amount) internal {
        emit AllowanceChanged(_fromWhom, msg.sender, allowance[_fromWhom], allowance[_fromWhom].sub(_amount));
        allowance[_fromWhom] = allowance[_fromWhom].sub(_amount);
    }
}
