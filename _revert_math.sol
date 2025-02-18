pragma solidity ^0.8.0;

contract Example {
    function checkValue(uint number) public pure returns (string memory) {
        if (number > 10) {
            revert( "The number is greater than 10");
        } else {
            return "The number is 10 or less";
        }
    }
}