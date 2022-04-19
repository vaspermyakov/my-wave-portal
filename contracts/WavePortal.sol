// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    uint256 private seed;

    // Create a wave event
    event NewWave(address indexed from, uint256 timestamp, string message);

   // Create a struct for a wave
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    // Create a storage for waves
    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("I am your smart contract!");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    // Create a new wave and check the time from the last one for this user
    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30 seconds"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved with message %s", msg.sender, _message);

        // Store wave data in the storage
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed <= 1) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        // Emit a new wave event
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    // Get information about all waves
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    // Get total number of waves
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    // Get information about waves of specific user
    function getUserWaves(address _user) public view returns (Wave[] memory) {
        Wave[] memory userWaves = new Wave[](waves.length);
        uint256 i = 0;
        for (uint256 j = 0; j < waves.length; j++) {
            if (waves[j].waver == _user) {
                userWaves[i] = waves[j];
                i += 1;
            }
        }
        return userWaves;
    }
}