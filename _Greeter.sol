pragma solidity ^0.4.0;

contract Greeter {
   /* Define variable greeting of the type string */
   string public yourName;

   /*This runs when the contract is executed*/
   function Greeter() public {
    yourName = "World";
    }
    /*initialise yourName as World as string type*/

   /*function 2: Initilise the yourName to the name provided by the sender*/
   function set(string name)public {
      yourName = name;
   
   }
   /* return function: returns the whatever value that was set in the state variable*/
   function hello() constant returns (string) {
    return yourName;
   }


}
