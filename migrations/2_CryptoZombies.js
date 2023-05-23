var CryptoZombies = artifacts.require("./CryptoZombies.sol");
module.exports = async function(deployer) {
  await deployer.deploy(CryptoZombies);
};