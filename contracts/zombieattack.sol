pragma solidity ^=0.5.0;

import "./zombiehelper.sol";
import "./safemath.sol";


contract ZombieAttack is ZombieHelper {

    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;

    uint randNonce = 0;

    uint attackVictoryProbability = 70;

    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        
        uint rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount.add(1);
            myZombie.level.add(1);
            enemyZombie.lossCount ++;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount.add(1);
            enemyZombie.winCount.add(1);
            _triggerCooldown(enemyZombie);
        }
    }

    function randMod(uint _modulus) internal returns (uint) {
        randNonce.add(1);
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % modulus;
    }


}