//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployNft;
    BasicNft public basicNft;
    address public USER  = makeAddr("user");
    string public constant PUG ="https://ipfs.io/ipns/k51qzi5uqu5dmaq5y7ld7vsvlm7ykg5oe223da50u2rfo8xm4bjgwopnu9jfal";
    function setUp() public {
        deployNft = new DeployBasicNft();
        basicNft = deployNft.run();
    }

    function testNameIsCorrect() public view{
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }
    function testCanMintAndhaveBalace() public{
        vm.prank(USER);
        basicNft.mintNFT(PUG);
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
    
}