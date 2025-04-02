//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";
contract MintBasicNft is Script {
    string public constant PUG ="ipfs://bafybeihocybqsno42gkucckkjvbhnqlzaxuzm5xj3v6wakkjhtzj3gz2du";
    function run() external  {
       address mostRecentDeployedContract = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
       mintNftOncontract(mostRecentDeployedContract);
    }

    function mintNftOncontract(address contractAddress) public {
       vm.startBroadcast();
       BasicNft(contractAddress).mintNFT(PUG);
       vm.stopBroadcast();
    }
   
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedMoodNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}