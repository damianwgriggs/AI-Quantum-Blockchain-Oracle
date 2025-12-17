
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// We import URIStorage because we need to attach unique metadata (the Pollinations image)
// to every single token individually.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QuantumCentaur is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    // The constructor sets the Name and Ticker.
    // Ownable(msg.sender) sets YOU as the admin immediately upon deployment.
    constructor() ERC721("Quantum Centaur", "QCENT") Ownable(msg.sender) {}

    // The Mint Function
    // 1. onlyOwner: Prevents random people from minting; only your Python script can do this.
    // 2. _safeMint: Prevents minting to invalid addresses (black holes).
    // 3. _setTokenURI: Attaches the specific Quantum/AI generation to this ID.
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
    
    // Required overrides for Solidity to compile correctly with OpenZeppelin 5.0
    // These ensure the URIStorage extension interacts correctly with the base contract.
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
