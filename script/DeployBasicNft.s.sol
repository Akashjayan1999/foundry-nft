//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function run() public returns (BasicNft) {
        vm.startBroadcast();
        BasicNft nft = new BasicNft();
        vm.stopBroadcast();
        return nft;
    }
}