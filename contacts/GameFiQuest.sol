// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GameFiQuest {
    address public owner;
    mapping(address => uint256) public questCompletions;
    mapping(address => uint256) public rewards;

    event QuestCompleted(address indexed player, uint256 reward);
    event RewardClaimed(address indexed player, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function completeQuest(address player) public {
        require(msg.sender == owner, "Only game master can approve quest completion");
        questCompletions[player]++;
        uint256 reward = 100 * questCompletions[player];
        rewards[player] += reward;
        emit QuestCompleted(player, reward);
    }

    function claimReward() public {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit RewardClaimed(msg.sender, amount);
    }

    function deposit() public payable {}

    function getQuestStats(address player) public view returns (uint256 completed, uint256 pendingReward) {
        return (questCompletions[player], rewards[player]);
    }
}
