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

    modifier vaildState(Stage reqStage){
         require(stages == reqStage); // check the stage must be the same as reqStage, in order to continous the contract.
         _;
    }

    event VoltingCompleted(); // a event function

    function Ballot(uint8 _numProposals) public {
        chairperson = msg.sender; 
        voters[chairperson].weight = 2;   // change the voters[chairperson]'s weight as 2.
        proposals.length = _numProposals; // the length proposal is _numProposals as it is designed by sender
        /* new feature with time*/
        stages = Stage.Registration;      // chairperson finish its own registration
        startTime = now;                  // update the time since this person finish the registration
    }

    function register(address toVoter) public vaildState(Stage.Registration) returns (string memory) {
        /* use revert to reject the transaction and aviod waste of source */
        if (stages != Stage.Registration) { revert("Need to register with Chairperson !");}
        if(msg.sender != chairperson || voters[toVoter].voted) 
        {revert("You are not the Chairperson or You already voted !");}
        voters[toVoter].weight = 1; // change the weight to 1
        voters[toVoter].voted = false; // mark the voter have not yet voted as false.

        /* new feature with time*/
        if (now > (startTime + VoteTime)) 
        // if it pass the first two condition, then move to this, go to vote state straight since it must registered already.
        {stages = Stage.Vote; startTime = now;}
    }

    function vote(uint8 toProposal) vaildState(Stage.Vote) public { 
        // toProposal means which person you want to vote
        Voter storage sender = voters[msg.sender]; 
        // if (stages != Stage.Vote) {return;} // can be replaced by the modifier
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true; // to tell system the person voted now.
        sender.vote = toProposal; // store which person that the sender voted.
        proposals[toProposal].votecount += sender.weight;

          /* new feature with time*/
        if (now > (startTime + VoteTime)) {stages = Stage.Done; VoltingCompleted();} // mention the event happens
    }

    // a constant function that is unable to change by other
    function winningProposal() public constant vaildState(Stage.Done) returns (uint8 _winningProposal)   // return type, must be the 8 bit unsigned integer
     {
        
        uint256 winningVoteCount = 0;  // initilise the winner number as 0.
        for (uint8 prop = 0; prop < proposals.length; prop++) // for loop, with one condition
            if (proposals[prop].votecount > winningVoteCount) { // if statement with condition

                winningVoteCount = proposals[prop].votecount;
                _winningProposal = prop;   
            }
        /* vaildation process*/
        assert (winningVoteCount > 0); // since the default setting of solidity will give winner to 0 proposal when not voter or vote registered.
        // solve this problem by using assert function which able to deny the transaction and gas fee when it is invailed.
    } 


}