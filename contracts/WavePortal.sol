// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {

    uint256[] totaWaves;

    mapping(address => uint256) userWaves;
    address[] userAddresses;

    constructor() {
        console.log("WavePortal contract deployed");
    }

    // Make a wave
    function wave() public {
        totaWaves.push(1);
        userWaves[msg.sender] = userWaves[msg.sender] + 1;
        console.log("%s has waved!", msg.sender);
    }

    // Get the total number of waves
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %s waves!", totaWaves.length);
        return totaWaves.length;

    }

    // Get the number of waves for a user
    function getUserWaves(address user) public view returns (uint256) {
        console.log("%s has waved %s times!", user, userWaves[user]);
        return userWaves[user];
    }
}