//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
contract MoodNft is ERC721 {

    //error
    error MoodNft__CantFlipMoodIfNotOwner();
    uint256 public s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    enum Mood {
        Sad,
        Happy
    }
    mapping(uint256 tokenId => Mood tokenMood) public s_tokenIdToMood;
    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }
    function mintNFT() public returns (uint256) {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
        return s_tokenCounter;
    }

    function _baseURI() internal pure  override returns (string memory) {
        return "data:application/json;base64,";
    }
    function flipMood(uint256 tokenId) public {
        if(!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)){
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if(s_tokenIdToMood[tokenId] == Mood.Happy){
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }else{
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
