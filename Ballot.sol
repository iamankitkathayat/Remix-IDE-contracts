// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.6.0;

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }


}
