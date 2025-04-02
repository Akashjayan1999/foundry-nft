//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
       string memory sadSvgImageUri = vm.readFile("./Img/sad.svg");
       string memory happySvgImageUri = vm.readFile("./Img/happy.svg");
       
       vm.startBroadcast();
       MoodNft moodNft = new MoodNft(svgToImageUTI(sadSvgImageUri), svgToImageUTI(happySvgImageUri));
       vm.stopBroadcast();
       return moodNft;

    }

    function svgToImageUTI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}

