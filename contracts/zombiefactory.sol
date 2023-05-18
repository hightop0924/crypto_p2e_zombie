pragma solidity ^=0.5.0;


import "./ownable.sol";
import "./safemath.sol";


contract ZombieFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;
    

    uint dnaDigits = 16;

    uint dnaModulus = 10 ** dnaDigits;

    uint cooldownTime = 1 days; //(24 * 60 * 60);

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    event NewZombie(uint zombieId, string name, uint dna, uint32 level, uint32 readyTime);

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    
    mapping (address => uint) ownerZombieCount;

    function updateTimestamp() public {
        cooldownTime = now;
    }

    function fiveMinutesHavePassed() public view returns (bool) {
        return (now >= (lastUpdated + 5 minutes));
    }

    function eatHamburgers(string memory _name, uint amount) public {

    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint dna = _generateRandomDna(_name);
        _createZombie(_name, dna);
    }

    function _createZombie(string memory _name, uint dna) internal {
        uint id = zombies.push(Zombie(_name, dna, 1, uint32(now + cooldownTime))) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender].add(1);
        emit NewZombie(id, _name, dna, level, readyTime);
    }

    function _generateRandomDna(string memory _str) view private returns (uint) {
        return keccak256(abi.encode(str)) % dnaModulus;
    }    
}