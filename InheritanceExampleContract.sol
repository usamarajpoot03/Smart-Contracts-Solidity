pragma solidity ^0.5.13;
import "./Owned.sol";


contract InheritanceExampleContract is Owned {
    
    
    mapping(address => uint) public tokenBalance;
    uint tokenPrice = 1 ether;


    constructor() public {
        tokenBalance[owner] = 100;
    }
    
    event NewTokenCreated(address _to,address _from, uint _amount);
   
    
    function createNewToken() public onlyOwner  {
        assert(tokenBalance[owner] + 1 > tokenBalance[owner]);
        tokenBalance[owner]++;
        emit NewTokenCreated(msg.sender,owner,tokenBalance[owner]);
    }
    
    function burnToken() public onlyOwner {
        assert(tokenBalance[owner] - 1 < tokenBalance[owner]);
        tokenBalance[owner]--;
    }
    
    function destroySmartContract() public onlyOwner {
        selfdestruct(owner);
    }
    
    function purchaseTokens() public payable {
        require(tokenBalance[owner] * tokenPrice > 0 ,"Tokens not available");
        tokenBalance[owner] -= msg.value/tokenPrice;
        tokenBalance[msg.sender] += msg.value/tokenPrice;
    }
    
    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >=_amount ,"not enough balance");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

    
}   