var CryptoZombies = artifacts.require("./CryptoZombies.sol");
module.exports = async function(deployer) {
  console.log('deploying...');
  await deployer.deploy(CryptoZombies);
  console.log('deployed');
};