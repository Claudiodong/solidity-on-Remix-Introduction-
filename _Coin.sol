pragma solidity ^0.4.0;

contract Coin{

    address public minter; // state variable, public minter
    mapping (address => uint) public balances;
    // the address is mapped into the balance that we have

    event Sent(address from, address to, uint amount);
    // from who the money was sent, 
    // to what address the money was sent, 
    // the amount of money that was sent

    // This is the constructor whose 
    // code is run only when the contract is created
    function Coin() public{ // must have same name as the contract, 
    // otherwise will create a new public word rather than checking the minter is same as the sender
        minter = msg.sender;
    // only the sender able to create the contract, which need a address for creation of smart contract
    }

    // if the msg.sender is equal to the minter, then it allow minter to mint the coin.
    function mint(address receiver, uint amount) public  {
        if (msg.sender != minter) return;  // if msg.sender is not the minter, nothing happens
        balances[receiver] += amount; // if the msg.sender is the minter, it able to increase its balance by amount.
    }

    function Send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) {return;} // if less than amount, nothing happened
        else{ // otherwise, sender lose amount, and receiver receive the money.
            balances[msg.sender] -= amount;
            balances[receiver] += amount;
            Sent(msg.sender,receiver,amount); // event happens and it is logged.
        }
    }
}