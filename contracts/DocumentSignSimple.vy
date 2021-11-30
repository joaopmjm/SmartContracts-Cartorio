# Smart Contract Document Assurence v1.0.0

document: bytes32 ## Hash do documento
owner: address ## Address do Cartório
signer: address ## Address de quem está assinando o documento
signed: bool
signedDate: uint256 ## Data que foi assinado
creationDate: uint256 ## Data de criação do documento



@external
def __init__(signer: address ,documentHash: bytes32):
    self.owner = msg.sender
    self.signer = signer
    self.document = documentHash
    self.creationDate = block.timestamp

@external
def sign():
    assert self.signer == msg.sender
    assert self.signed == False
    self.signedDate = block.timestamp
    self.signed = True

@external
@view
def GetDocument() -> (bytes32, bool):
    return (self.document, self.signed)

@external
@view
def GetSignedInfo() -> (address, bool, uint256):
    return (self.signer, self.signed, self.signedDate)