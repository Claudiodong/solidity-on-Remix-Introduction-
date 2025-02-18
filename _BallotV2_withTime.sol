pragma solidity ^0.4.0;
contract Ballot{

    // struct data type
    struct Voter{ // struct is data type, for Voter
        uint weight;
        bool voted;
        uint8 vote; // unsigned integer for 8 bits
    }

    struct Proposal { // struct for Proposal, what is the varible contain inside the array
        uint votecount;
    }

    // enum data type
    enum Stage {Init, Registration, Vote, Done} // stage 0, 1, 2, 3
    Stage public stages = Stage.Init; // define the stage as variable with enum Stage

    /* new feature with time */
    uint startTime; // define the startTime
    uint VoteTime = 10 seconds; // define the votetime
    

    // address type
    address chairperson; // chairperson address is specific by a state variable
    mapping(address => Voter) voters; // mapping the key_type(chairperson) with data type (Voter), and variable (voters)
    // mapping from address to Voter that is specified by the variable voters

    Proposal[] proposals; // array and array variable name

    function Ballot(uint8 _numProposals) public {
        chairperson = msg.sender; 
        voters[chairperson].weight = 2;   // change the voters[chairperson]'s weight as 2.
        proposals.length = _numProposals; // the length proposal is _numProposals as it is designed by sender

        /* new feature with time*/
        stages = Stage.Registration;      // chairperson finish its own registration
        startTime = now;                  // update the time since this person finish the registration
    }

    function register(address toVoter) public returns (string memory) {
        /* use revert to reject the transaction and aviod waste of source */
        if (stages != Stage.Registration) { revert("Need to register with Chairperson !");}
        // if is not in Reg state, do nothing, need to register; 
        // But once the chairperson deploy/create the contract, it already go to Reg state.(The state is for entire contract)
        if(msg.sender != chairperson || voters[toVoter].voted) 
        {revert("You are not the Chairperson or You already voted !");}
        // if the sender is not chairperson or the voters already voted (true) -> return
        // only chairperson able to register
        voters[toVoter].weight = 1; // change the weight to 1
        voters[toVoter].voted = false; // mark the voter have not yet voted as false.

        /* new feature with time*/
        if (now > (startTime + VoteTime)) 
        // if it pass the first two condition, then move to this, go to vote state straight since it must registered already.
        {stages = Stage.Vote; startTime = now;}
    }

    function vote(uint8 toProposal) public { 
        // toProposal means which person you want to vote
        Voter storage sender = voters[msg.sender]; 
        if (stages != Stage.Vote) {return;}
        // create a sender that have struct of Voter 
        // and storage voters information of current address
        // So, sender have struct of Voter (including weight,voted and vote.)
        // then, all the values inside the sender is assigned to be value of current address voters.

        if (sender.voted || toProposal >= proposals.length) return;
        // if the current address voted is True -> then it return , do nothing
        // or if the toProposal is bigger than proposals array length -> do nothing
        // for example. there is only 3 people, but you vote number 4, but clearly there is not number 4.
        sender.voted = true; // to tell system the person voted now.
        sender.vote = toProposal; // store which person that the sender voted.
        proposals[toProposal].votecount += sender.weight;
        // then find the array proposals that the person is voted by sender
        // then update how many votes it received based on the vote weight of sender.
        // Because chairperson 1 vote = 2 normal person's vote

          /* new feature with time*/
        if (now > (startTime + VoteTime)) {stages = Stage.Done;}
    }

    // a constant function that is unable to change by other
    function winningProposal() public constant returns (uint8 _winningProposal)   // return type, must be the 8 bit unsigned integer
     {
        
        uint256 winningVoteCount = 0;  // initilise the winner number as 0.
        for (uint8 prop = 0; prop < proposals.length; prop++) // for loop, with one condition
        
        // define and initilise the prop as 0, the prop must less than length of proposals, then increment by 1 once finsih the loop.
            if (proposals[prop].votecount > winningVoteCount) { // if statement with condition
                // from the array proposals, if that person (prop) have greater votecount than winningVoteCount

                winningVoteCount = proposals[prop].votecount;
                // then update the winningVoteCount as that person(prop)'s votecount

                _winningProposal = prop;
                // also update the _winningProposal is that person number (prop)

                
            }
        //stages = Stage.Done; // update the state to last state
    } 


}