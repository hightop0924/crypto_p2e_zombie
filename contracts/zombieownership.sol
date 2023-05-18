pragma solidity ^=0.5.0;

import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";


contract ZombieOwnership is ZombieAttack, ERC721 {

    using SafeMath for uint256;

    mapping(uint => address) zombieApprovals;

    function balanceOf(address _owner) external view returns (uint256) {
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address){
        return zombieToOwner[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require(zombieApprovals[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
        zombieApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private onlyOwnerOf(_tokenId) {
        ownerZombieCount[_from].sub(1);
        ownerZombieCount[_to].add(1);        
        zombieToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
}