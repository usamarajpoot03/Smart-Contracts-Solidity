pragma solidity ^0.5.13;

contract Simplest {
   string public myString = "Hello to Simplest";
    uint public myInt;
    
    function setMyInt(uint _myInt) public {
        myInt = _myInt;
    } 
}