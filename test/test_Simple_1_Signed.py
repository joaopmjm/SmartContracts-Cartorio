import pytest
import brownie
import time

DOCUMENT = ""
SIGNER_ADDRESS = ""

@pytest.fixture(scope="function", autouse=True)
def sign_contract_ok(DocumentSignSimple,DocumentHash, accounts):

    # deploy the contract with the initial values as a constructor argument
    DOCUMENT = DocumentHash
    SIGNER_ADDRESS = accounts[1]
    yield DocumentSignSimple.deploy(accounts[1], DocumentHash, {'from': accounts[0]})


def test_initial_state(sign_ok):
    # Check if the constructor of the contract is set up properly
    assert sign_ok.signed() == False
    assert sign_ok.signer() == SIGNER_ADDRESS


def test_fund(sign_ok, accounts):

    # Funding Test
    sign_ok.fund({'from': accounts[2], 'value': 10})
    assert sign_ok.donations(
        accounts[2].address) == 10  # Directly access donations

    # Funding Test Other account
    sign_ok.fund({'from': accounts[1], 'value': 20})
    assert sign_ok.donations(
        accounts[1].address) == 20  # Directly access donations

    # Funding Finish Before end
    with brownie.reverts():
        sign_ok.finish({"from": accounts[0]})

    time.sleep(10)

    # Donate after end
    with brownie.reverts():
        sign_ok.fund({"from": accounts[3], 'value': 10})

    # Revert when target
    with brownie.reverts():
        sign_ok.refund({'from': accounts[2]})

    # Revert when target
    with brownie.reverts():
        sign_ok.refund({'from': accounts[1]})

    # Non owner finish
    with brownie.reverts():
        sign_ok.finish({'from': accounts[1]})

    # Finish
    sign_ok.finish({"from": accounts[0]})
