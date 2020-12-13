pragma solidity ^0.6.0;

contract MyContract
{
    string public myString = "hello world!2";
    uint256 public myUint;
    
    function setMyUint(uint _myUint) public
    {
        myUint = _myUint;
    }
    
    address public myAddress;
    
    function setMyAddress(address _MyAddress) public
    { 
        myAddress = _MyAddress;
    }
    
    function getBalance() public view returns(uint){
        return myAddress.balance;
    }
    
}   