//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployNft;
    function setUp() public {
        deployNft = new DeployMoodNft();
    }
    function testSvgToImageUTI() public view{
       string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjUwMCIgaGVpZ2h0PSI1MDAiPjx0ZXh0IGZpbGw9ImJsYWNrIiB4PSIxMDAiIHk9IjEwMCIgZm9udC1zaXplPSI1MCI+SGVsbG8gV29ybGQhPC90ZXh0Pjwvc3ZnPg==";
        string memory svg = '<svg xmls="http://www.w3.org/2000/svg" width="500" height="500"><text fill="black" x="100" y="100" font-size="50">Hello World!</text></svg>';
        string memory createdUri = deployNft.svgToImageUTI(svg);
        assert(keccak256(abi.encodePacked(expectedUri)) == keccak256(abi.encodePacked(createdUri)));
      
    }
    
}