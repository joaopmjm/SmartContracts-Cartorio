# Smart Contract Document Assurence v1.0.0

document: bytes32 ## Hash do documento
owner: address ## Address do Cartório
signer: HashMap[address, bool] ## Address de quem está assinando o documento
signed: bool
signers: address[5]
nsigners: uint256
creationDate: uint256 ## Data de criação do documento


@external
def __init__(signer: address, documentHash: bytes32):
    self.owner = msg.sender
    self.signer[signer] = False
    self.document = documentHash
    self.nsigners = 1
    self.creationDate = block.timestamp

@external
def AddSigner(signer: address):
    assert msg.sender == self.owner, "Your are not the owner"
    self.signer[signer] = False
    self.signers[self.nsigners] = msg.sender


@external
def sign():
    assert msg.sender in self.signers, "You're not a signer"
    self.signer[msg.sender] = True

@external
@view
def GetDocument() -> (bytes32, bool):
    return (self.document, self.signed)

