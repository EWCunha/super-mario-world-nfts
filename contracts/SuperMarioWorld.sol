// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721.sol";

contract SuperMarioWorld is ERC721 {
    string public name; // ERC721Metadata
    string public symbol; // ERC721Metadata
    uint256 public tokenCount; // keep track the number of NFTs minted and be the unique ID for the NFTs
    mapping(uint256 => string) private tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // Returns a URL that points ti the metadata
    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        // ERC721Metadata
        require(owners[_tokenId] != address(0), "TokenId does not exist");
        return tokenURIs[_tokenId];
    }

    // Creates a new NFT inside our collection
    function mint(string memory _tokenURI) public {
        tokenCount++; // tokenId
        balances[msg.sender]++;
        owners[tokenCount] = msg.sender;
        tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    //
    function supportsInterface(bytes4 _interfaceId)
        public
        pure
        override
        returns (bool)
    {
        return _interfaceId == 0x80ac56cd || _interfaceId == 0x5b5e139f;
    }
}
