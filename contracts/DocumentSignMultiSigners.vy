# @version >=0.1.0-beta.16
# Smart Contract Document Assurence v1.0.1

struct signature:
    signed: bool
    signDate: uint256

document: bytes32 ## Hash do documento
owner: address ## Address do Cartório
signerStatus: public(HashMap[address, signature]) ## Address de quem está assinando o documento
fullySigned: bool
signers: public(address[5]) # Maximo de 5 assinantes
nsigners: uint256   # Contabiliza quantos assinantes tem
creationDate: uint256 ## Data de criação do documento


@external
def __init__(signer: address, documentHash: Bytes[100]):
    self.owner = msg.sender
    self.signerStatus[signer] = signature({
        signed : False,
        signDate: 0
        })
    self.document = keccak256(documentHash)
    self.signers[0] = signer
    self.nsigners = 1
    self.creationDate = block.timestamp

@external
def AddSigner(signer: address):
    assert msg.sender == self.owner, "Your are not the owner"
    self.signerStatus[signer] = signature({
            signed : False,
            signDate: 0
        })
    self.signers[self.nsigners] = signer
    self.nsigners += 1


@external
def Sign():
    assert msg.sender in self.signers, "You're not a signer"
    assert self.signerStatus[msg.sender].signed == False, "Você já assinou"
    self.signerStatus[msg.sender] = signature({
            signed : True,
            signDate: block.timestamp
        })
    self.fullySigned = True

    num_checked : uint256 = 0
    for i in self.signers:
        self.fullySigned = self.fullySigned and self.signerStatus[i].signed
        if num_checked <= self.nsigners: break
        num_checked += 1

@external
@view
def MatchDocument(document: Bytes[100]) -> bool:
    return self.document == keccak256(document)

@external
@view
def GetDocument() -> (bytes32, bool):
    return (self.document, self.fullySigned)

@external
@view
def GetSignatureStatus(signer: address) -> (bool):
    return (self.signerStatus[signer].signed)