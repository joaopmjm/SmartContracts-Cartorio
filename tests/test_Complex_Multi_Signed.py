# @version 0.1.0b13
import pytest
import brownie
import time

DOCUMENT = "d2b20bc6c608e9dc2b0096a0b39d877956f2848cc40742b40f1fd345701c5f4e"
FAKE_DOC = "fad06716122adc0951a06f392f1907116752a69bf9384dd7924cb0d4ab9c0f90"
SIGNER_ADDRESS= ""

@pytest.fixture(scope="function", autouse=True)
def sign_contract_ok(DocumentSignMultiSigners, accounts):
    # deploy the contract with the initial values as a constructor argument
    yield DocumentSignMultiSigners.deploy(accounts[1], DOCUMENT, {'from': accounts[0]})


def test_initial_state(sign_contract_ok,accounts):
    # Check if the constructor of the contract is set up properly
    assert sign_contract_ok.GetDocument()[1] == False
    assert sign_contract_ok.GetSignatureStatus(accounts[1]) == False 


def test_contract(sign_contract_ok, accounts):
    # Funding Test
    assert sign_contract_ok.GetSignatureStatus(accounts[1]) == False  # Directly access donations
    assert sign_contract_ok.GetDocument()[1] == False
    
    sign_contract_ok.AddSigner(accounts[2],{'from':accounts[0]})
    sign_contract_ok.AddSigner(accounts[2],{'from':accounts[0]})
    assert sign_contract_ok.GetSignatureStatus(accounts[2]) == False
    
    sign_contract_ok.Sign({'from': accounts[1]})
    assert sign_contract_ok.GetSignatureStatus(accounts[1]) == True  # Directly access donations
    assert sign_contract_ok.GetSignatureStatus(accounts[2]) == False
    sign_contract_ok.Sign({'from': accounts[2]})
    
    assert sign_contract_ok.GetDocument()[1] == True
    
    assert sign_contract_ok.MatchDocument(FAKE_DOC) == False