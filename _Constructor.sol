pragma solidity ^0.4.0;


contract Bidder {

     string public name; 
     uint public bidAmount = 20000;    // initialise the bidAmoutn
     bool public eligible;             // set the eligble 
     uint constant minBid = 1000;      // set the minimum value of bid

    // set the name of the bidder
    function setName(string gameName) public {
        name = gameName; // use the set function, to update the name variable as the sender send string m
    }

    // set the Bid Amount of the gamer, if not set, use the initilised value 20000.
    function setBidAmount(uint inputAmount) public {
        bidAmount = inputAmount;
    }

    // function determine the whether eligible for bid amount.
    function determineEligibility() public {
        if (bidAmount >= minBid) {
            eligible = true; // if larger or equal than, then change it to true
        }
        else{
            eligible = false; // if less than, then change it to false
        }   
    }

}