pragma solidity ^0.4.0;

contract statechange {
        uint storedData;
        // define the storedData as unsigned integer 
       /*Function set: require the input of this set function should uint (unsigned integer),
       also it is public function, then once we have input value x which will be stored in storedData (state value/variable)*/
        function set(uint x) public{
            storedData = x;
        }

        /*function: read the value from the storedData which should be uint (unsigned integer)*/
        function get() constant public returns (uint){
            return storedData;
        }
        /* function: add the storedData value by input uint value (n)*/
        function increment(uint n) public {
            storedData = storedData + n;
            return;
        }
        /* function: reduce the storedData value by input uint value (n)*/
        function decrement(uint n) public {
            storedData = storedData - n;
            return;
        }
}