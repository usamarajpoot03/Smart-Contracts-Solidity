pragma solidity 0.6.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;
    
     
    ItemManager  parentContract;
     
    constructor(uint _priceInWei, uint _index, ItemManager __parentContract) public {
        
        priceInWei = _priceInWei;
        index = _index;
        parentContract = __parentContract;
    }
    
    receive() external payable {
        
        require( pricePaid == 0 , "Item is already paid");
        require( priceInWei == msg.value , "Only full payments accepted");
        pricePaid += msg.value;
        
        // 1 : issue is with transfer( high level call we can onlt 
        // transfer limited gas with that we can only do liminted work)
        // address(parentContract).transfer(msg.value);
        
        
        // 2 : low level call/
        // it dangerous as it doesn't throw exception/ return balance
        // in case anything goes wrong
        
        (bool success,) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)",index));
        
        require(success , "Transaction is not compeleted, something goes wrong");
    }
    
}
contract ItemManager is Ownable{
 
    enum SuppyChainState {Created, Paid, Delievered}
  
    struct S_Item {
        Item _item;
        string _identiier;
        uint _itemPrice;
        ItemManager.SuppyChainState _state;
    }
    
    mapping(uint => S_Item) public items;
    uint itemIndex;
    
    event SuppyChainStep (uint _itemIndex, uint _step, address _item);
    
    function createItem(string memory _identiier, uint _itemPrice ) public onlyOwner {
        
        Item item = new Item(_itemPrice, itemIndex, this);
        items[itemIndex]._item = item;
        items[itemIndex]._identiier = _identiier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SuppyChainState.Created;
        itemIndex++;
        
        emit SuppyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
    }
    
    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value, "Only full payments accepted");
        require(items[_itemIndex]._state == SuppyChainState.Created , "Item is already processed");
        items[_itemIndex]._state = SuppyChainState.Paid;
        emit SuppyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));
    }
    
    function triggerDelievery(uint _itemIndex) public onlyOwner {
        require(items[_itemIndex]._state == SuppyChainState.Paid , "Item is already processed");
        items[_itemIndex]._state = SuppyChainState.Delievered;
        emit SuppyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));
    }
    
    
}