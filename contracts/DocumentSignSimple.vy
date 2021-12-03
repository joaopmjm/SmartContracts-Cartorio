# @version >=0.1.0-beta.16
# Smart Contract Document Assurence v1.0.0

document: bytes32 ## Hash do documento
owner: address ## Address do Cartório
signer: address ## Address de quem está assinando o documento
signed: bool
signedDate: uint256 ## Data que foi assinado
creationDate: uint256 ## Data de criação do documento



@external
def __init__(signer: address ,documentHash: Bytes[100]):
    self.owner = msg.sender
    self.signer = signer
    self.document = keccak256(documentHash)
    self.creationDate = block.timestamp

@external
def Sign():
    assert self.signer == msg.sender
    assert self.signed == False
    self.signedDate = block.timestamp
    self.signed = True

@external
@view
def MatchDocument(document: Bytes[100]) -> bool:
    return keccak256(document) == self.document 

@external
@view
def GetDocument() -> (bytes32, bool):
    return (self.document, self.signed)

@external
@view
def GetSignedInfo() -> (address, bool, uint256):
    return (self.signer, self.signed, self.signedDate)