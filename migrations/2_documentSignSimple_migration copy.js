var documentSignSimple = artifacts.require('DocumentSignSimple');
var accounts = web3.eth.getAccounts();

module.exports = function(deployer) {
    // documentSignSimple is the contract's name
    deployer.deploy(documentSignSimple);
};