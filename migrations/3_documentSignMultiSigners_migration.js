var documentSignMulti = artifacts.require('DocumentSignMultiSigners.vy');

module.exports = function(deployer) {
    // documentSignSimple is the contract's name
    deployer.deploy(documentSignMulti);
};