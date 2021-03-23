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
//
////// File: contracts/Thing.sol
//
//pragma solidity ^0.5.7;
//
//contract Thing is ERC721Full, ERC721MetadataMintable, ERC721Burnable, Ownable {
//  using SafeMath for uint256;
//  using Strings for string;
//
//  enum TokenState { Pending, ForSale, Sold, Transferred }
//
//  struct Price {
//    uint256 tokenId;
//    uint256 price;
//    string metaId;
//    TokenState state;
//  }
//
//  mapping(uint256 => Price) public items;
//
//  uint256 public id;
//  string public baseUri;
//  address payable public maker;
//  address payable feeAddress;
//
//  constructor(
//    string memory name,
//    string memory symbol,
//    string memory uri,
//    address payable fee,
//    address payable creator
//  ) ERC721Full(name, symbol) public {
//    maker = creator;
//    feeAddress = fee;
//    baseUri = uri;
//    id = 0;
//    transferOwnership(creator);
//    _addMinter(creator);
//
//  }
//
//  event ErrorOut(string error, uint256 tokenId);
//  event BatchTransfered(string metaId, address[] recipients, uint256[] ids);
//  event Minted(uint256 id, string metaId);
//  event BatchBurned(string metaId, uint256[] ids);
//  event BatchForSale(uint256[] ids, string metaId);
//  event Bought(uint256 tokenId, string metaId, uint256 value);
//  event Destroy();
//
//  function tokenURI(uint256 _tokenId) public view returns (string memory) {
//    return Strings.strConcat(
//      baseUri,
//      items[_tokenId].metaId
//    );
//  }
//
//  function setTokenState(uint256[] memory ids, bool isEnabled) public onlyMinter {
//    for (uint256 i = 0; i < ids.length; i++) {
//      if(isEnabled == true){
//        items[ids[i]].state = TokenState.ForSale;
//      } else {
//        items[ids[i]].state = TokenState.Pending;
//      }
//    }
//    emit BatchForSale(ids, items[ids[0]].metaId);
//  }
//
//  function setTokenPrice(uint256[] memory ids, uint256 setPrice) public onlyMinter {
//    for (uint256 i = 0; i < ids.length; i++) {
//      items[ids[i]].price = setPrice;
//    }
//  }
//
//  function mintbaseFee(uint256 amount) internal pure returns (uint256) {
//    uint256 toOwner = SafeMath.mul(amount, 2);
//
//    return SafeMath.div(toOwner, 100);
//  }
//
//  function buyThing(uint256 _tokenId) public payable returns (bool) {
//
//    require(msg.value >= items[_tokenId].price, "Price issue");
//    require(TokenState.ForSale == items[_tokenId].state, "No Sale");
//
//    if(items[_tokenId].price >= 0) {
//      uint256 fee = mintbaseFee(msg.value);
//      uint256 withFee = SafeMath.sub(msg.value, fee);
//
//      maker.transfer(withFee);
//      feeAddress.transfer(fee);
//    }
//
//    _transferFrom(maker, msg.sender, _tokenId);
//    items[_tokenId].state = TokenState.Sold;
//
//    emit Bought(_tokenId, items[_tokenId].metaId, msg.value);
//  }
//
//  function destroyAndSend() public onlyOwner {
//    emit Destroy();
//    selfdestruct(maker);
//  }
//
//  function batchTransfer(address giver, address[] memory recipients, uint256[] memory values) public {
//
//    for (uint256 i = 0; i < values.length; i++) {
//      transferFrom(giver, recipients[i], values[i]);
//      items[values[i]].state = TokenState.Transferred;
//    }
//    emit BatchTransfered(items[values[0]].metaId, recipients, values);
//  }
//
//  function batchMint(address to, uint256 amountToMint, string memory metaId, uint256 setPrice, bool isForSale) public onlyMinter {
//
//    require(amountToMint <= 40, "Over 40");
//
//    for (uint256 i = 0; i < amountToMint; i++) {
//      id = id.add(1);
//      items[id].price = setPrice;
//      items[id].metaId = metaId;
//      if(isForSale == true){
//        items[id].state = TokenState.ForSale;
//
//      } else {
//        items[id].state = TokenState.Pending;
//      }
//      _mint(to, id);
//      emit Minted(id, metaId);
//    }
//
//  }
//
//  function batchBurn(uint256[] memory tokenIds) public onlyMinter {
//    for (uint256 i = 0; i < tokenIds.length; i++) {
//      _burn(tokenIds[i]);
//    }
//    emit BatchBurned(items[tokenIds[0]].metaId, tokenIds);
//  }
//
//  function tokensOfOwner(address owner) public view returns (uint256[] memory) {
//    return _tokensOfOwner(owner);
//  }
//}
