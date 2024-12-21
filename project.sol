// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EarningsForParticipation {
    struct Participant {
        uint256 totalEarnings;
        uint256 participationCount;
    }

    mapping(address => Participant) public participants;
    address public owner;
    uint256 public rewardAmount;
    uint256 public eventCount;

    event Participated(address indexed participant, uint256 earnings);
    event RewardUpdated(uint256 newRewardAmount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(uint256 _rewardAmount) {
        owner = msg.sender;
        rewardAmount = _rewardAmount;
        eventCount = 0;
    }

    function participate() public {
        require(eventCount > 0, "No events have been created yet");
        
        participants[msg.sender].participationCount += 1;
        participants[msg.sender].totalEarnings += rewardAmount;

        emit Participated(msg.sender, rewardAmount);
    }

    function createEvent() public onlyOwner {
        eventCount += 1;
    }

    function updateRewardAmount(uint256 _newRewardAmount) public onlyOwner {
        rewardAmount = _newRewardAmount;
        emit RewardUpdated(_newRewardAmount);
    }

    function getParticipantInfo(address _participant) public view returns (uint256, uint256) {
        return (participants[_participant].totalEarnings, participants[_participant].participationCount);
    }
}