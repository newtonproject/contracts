//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract SampleERC721 is ERC721, Ownable {
  uint private _tokenIds = 0;

  constructor(string memory name, string memory symbol) public ERC721(name, symbol) {}

  function createToken(address _to, string memory tokenURI) public returns (uint256) {
    _tokenIds++;
    uint256 newItemId = _tokenIds;
    _mint(_to, newItemId);
    _setTokenURI(newItemId, tokenURI);
    return newItemId;
  }
}
