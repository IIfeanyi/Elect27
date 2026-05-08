// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract elct27{

    struct Candidates{
        string name;
        string party;
        string manifesto;
        uint256 votes;
        }


    mapping(uint256 => Candidates) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidateCount;


constructor(){
    candidateCount = 0;
}


    function addCandidate( string memory _name, string memory _party, string memory _manifesto) public {
        candidateCount ++;
        candidates[candidateCount] = Candidates({
            name: _name,
            party: _party,
            manifesto: _manifesto,
            votes: 0
        });
    }

    function voters(uint _candidateID) public {
        require(!hasVoted[msg.sender], "Sorry, You're obligated to one vote only");
        require(_candidateID > 0 && _candidateID <= candidateCount, "Pick a candidate");
        hasVoted[msg.sender] = true;
        candidates[_candidateID].votes ++;
        }

    function electWinner() public view returns ( string memory _winnerName, uint256 _totalVotes){
        require(candidateCount > 0, "pick a candidate");

        uint highestVotes;
        uint winnersID;

        for (uint i = 1; i <= candidateCount; i++){
            if (candidates[i].votes > highestVotes){
                highestVotes = candidates[i].votes;
                winnersID = i;
            }
            _winnerName = candidates[winnersID].name;
            _totalVotes = candidates[winnersID].votes;
        }
    }

        
}
