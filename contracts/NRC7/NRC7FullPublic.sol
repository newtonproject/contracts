// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "../openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "../openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../openzeppelin-contracts/contracts/access/AccessControlEnumerable.sol";
import "../openzeppelin-contracts/contracts/utils/Context.sol";
import "../openzeppelin-contracts/contracts/utils/Counters.sol";

/**
 * @dev {ERC721} token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - a minter role that allows for token minting (creation)
 *  - a pauser role that allows to stop all token transfers
 *  - token ID and URI autogeneration
 *  - token baseURI and tokenURI manager
 *
 * This contract uses {AccessControl} to lock permissioned functions using the
 * different roles - head to its documentation for details.
 *
 * The account that deploys the contract will be granted the minter and pauser
 * roles, as well as the default admin role, which will let it grant both minter
 * and pauser roles to other accounts.
 */
contract NRC7FullPublic is Context, AccessControlEnumerable, ERC721Enumerable, ERC721Burnable, ERC721Pausable, ERC721URIStorage {
    using Counters for Counters.Counter;

    string public constant NEWTON_CONTRACT_NAME = "NRC7FullPublic";
    string public constant NEWTON_CONTRACT_VERSION = "1.0.0";

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    Counters.Counter private _tokenIdTracker;

    string private _baseTokenURI;

    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
     * account that deploys the contract.
     *
     * Token URIs will be autogenerated based on `baseURI` and their token IDs.
     * See {ERC721-tokenURI}.
     */
    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        _setupRole(PAUSER_ROLE, _msgSender());
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata newBaseTokenURI) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "NRC7Full: must have admin role to set");
        _baseTokenURI = newBaseTokenURI;
    }

   /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev Check whether `tokenId` exists.
     */
    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    /**
     * @dev Creates a new token for `to`. Its token ID will be automatically
     * assigned (and available on the emitted {IERC721-Transfer} event), and the token
     * URI autogenerated based on the base URI passed at construction.
     *
     * See {ERC721-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(address to) public virtual {
        // We cannot just use balanceOf to create the new tokenId because tokens
        // can be burned (destroyed), so we need a separate counter.
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }
    function mintWithTokenURI(address to, string memory _tokenURI) public {
        // We cannot just use balanceOf to create the new tokenId because tokens
        // can be burned (destroyed), so we need a separate counter.
        _mint(to, _tokenIdTracker.current());
        _setTokenURI(_tokenIdTracker.current(), _tokenURI);
        _tokenIdTracker.increment();
    }

    /**
     * @dev Pauses all token transfers.
     *
     * See {ERC721Pausable} and {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "NRC7Full: must have pauser role to pause");
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {ERC721Pausable} and {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "NRC7Full: must have pauser role to unpause");
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC721, ERC721Enumerable, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControlEnumerable, ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }


    /**
     * @dev See {ERC721URIStorage}.
     */
    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }


   /**
   * @dev Gets the list of all token IDs assigned to an address
   * Try NOT to use this function
   * @param owner address The owner whose token we are interested in
   * @return ownerTokens Returns a list of all token IDs assigned to an address
   */
    function tokensOfOwner(address owner) public view returns(uint256[] memory ownerTokens) {
        uint256 length = ERC721.balanceOf(owner);
        for (uint256 i = 0;i<length;i++) {
            ownerTokens[i] = ERC721Enumerable.tokenOfOwnerByIndex(owner, i);
        }
    }
}
