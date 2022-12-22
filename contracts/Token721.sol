//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token721 is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string private baseURI;

    uint64 public cost = 0 ether;
    uint64 public maxSupply = 100;

    mapping(address => uint256[]) private _ownerTokens;

    //Constructor
    constructor() ERC721("Token2", "TKN2") {}

    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function mintNewNFT() public payable {
        uint256 supply = totalSupply();
        require(supply + 1 <= maxSupply, "Supply Limit Reached");
        // require(balanceOf(msg.sender) == 0, "User already minted");
        _safeMint(msg.sender, supply + 1);
        _ownerTokens[msg.sender].push(supply + 1);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "Non Existent Token");
        string memory currentBaseURI = _baseURI();

        return (
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        ".json"
                    )
                )
                : ""
        );
    }

    function tokensOwnedBy(address _userAddress)
        public
        view
        returns (uint256[] memory)
    {
        return _ownerTokens[_userAddress];
    }

    //only owner

    function setMaxSupply(uint64 _maxSupply) public onlyOwner {
        maxSupply = _maxSupply;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }
}
