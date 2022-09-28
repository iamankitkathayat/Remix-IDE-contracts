// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.6.0;

contract BallotVoting {
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


    address public chairPerson;

    mapping(address => Voter) public voters;

    Proposal[] public proposals;
    
    constructor(bytes32[] memory proposalNames) {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;

        for(uint i=0; i< proposalNames.length; i++) {
            proposals.push(Proposal({
                name : proposalNames[i],
                voteCount : 0
            }));
        }
    }
    
    function giveRightToVote(address voter) external {
        require(msg.sender == chairPerson, "Only chairperson has the right to vote");
        require(!voters[voter].voted, "The voter has already voted");
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }
    
    function delegate (address to) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You do not have a right to vote");
        require(!sender.voted, "You have already voted");
        require(to != msg.sender, "Self-delegation is disallowed.");
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation.");
        }
        Voter storage delegate_ = voters[to];

        require(delegate_.weight >= 1);

        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }
}
