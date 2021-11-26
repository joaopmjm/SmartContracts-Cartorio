# Smart Contract Document Assurence v1.0.1

struct signature:
    signed: bool
    signDate: uint256

document: bytes32 ## Hash do documento
owner: address ## Address do Cartório
signerStatus: HashMap[address, signature] ## Address de quem está assinando o documento
fullySigned: bool
signers: address[5] # Maximo de 5 assinantes
nsigners: uint256   # Contabiliza quantos assinantes tem
creationDate: uint256 ## Data de criação do documento


@external
def __init__(signer: address, documentHash: bytes32):
    self.owner = msg.sender
    self.signerStatus[signer] = signature({
        signed : False,
        signDate: 0
        })
    self.document = documentHash
    self.nsigners = 1
    self.creationDate = block.timestamp

@external
def AddSigner(signer: address):
    assert msg.sender == self.owner, "Your are not the owner"
    self.signerStatus[signer] = signature({
            signed : False,
            signDate: 0
        })
    self.signers[self.nsigners] = msg.sender


@external
def sign():
    assert msg.sender in self.signers, "You're not a signer"
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
def GetDocument() -> (bytes32, bool):
    return (self.document, self.fullySigned)

@external
@view
def GetSignatureStatus() -> (bool):
    assert msg.sender in self.signers, "Você não tem acesso"
    return (self.signerStatus[msg.sender].signed)