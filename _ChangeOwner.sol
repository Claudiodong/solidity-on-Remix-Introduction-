pragma solidity ^0.5.0;

contract ChangeOwnerShip{


    address public owner;

    // pre-defined the owner address to be the sender address (who create this contract)
    constructor() public {
        owner = msg.sender; // let the owner to be the message sender, this only to be internal access
    }
    
    modifier onlyOwner(){ // only allow the owner to access
        require(msg.sender == owner, 'Not Owner'); // error message is 'Not Owner'
        _; // continuous the function further it is true condition, if not stop the function
    }

    modifier ValidData(address _address) {
        require(_address != address(0), 'Not Valid Address'); // error message Not Vaild Address
        _;
    }

    function ChangeOwner(address _NewOwner) public onlyOwner ValidData(_NewOwner) 
    // Here adding two extra conditions about the onlyowner and validdata, do not forget the input
    {
       owner = _NewOwner; // if those conditions are satisfised, change the owner address
    }
   
}