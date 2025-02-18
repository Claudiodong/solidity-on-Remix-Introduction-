pragma solidity ^0.4.0;

contract StateTransition{

    enum Stage {Init, Registration, Vote, Done} // define the states by using enum

    Stage public stage; // using enum type variable (Stage), public it and able to access in interface
    // then define it as data variable (stage), make sure stage have enum data type as define as (Stage)

    uint startTime;      // private the start time which unable to access
    uint public timeNow; // public the timeNow
    uint voteTime = 10 seconds; // define the voteTime, public it.

    // constructor function: initilise some variable internally for user only without public
    function StateTrans() public {
        // initilise the stage with Stage.Init, using dot(.) to access the state
        stage = Stage.Init; 
        // initilise the startTime by using variable now, which design the timestamping is now
        startTime = now; 
    }

    

    // state transition function (moving forward)
    function ForwardState() public { 
        timeNow = now; // define the time now is now
        if (stage == Stage.Init) {stage = Stage.Registration; return;} // move from 0 to 1 
        if (stage == Stage.Registration) {stage = Stage.Vote; return;} // move from 1 to 2

        if (timeNow < (startTime + voteTime))
        {
            startTime = timeNow;     
            if (stage == Stage.Vote) {stage = Stage.Done; return;}        
            // move from 2 to 3 only when vote within the voteTime
            return;   
        } 
        else {startTime = timeNow; return;} // do nothing if pass the voteTime
        // also update the time;
    }
}

// when forward the state, if in state Init, it will move to registration, if it is in registration, it move to vote stage.
// however, it only to move from vote to done when startTime and timeNow have a difference that less than voteTime.
// So it only have 10 second to vote in this case (Votetime = 10 second)