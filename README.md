# SmartContracts-Cartorio

## Dependencies

- Truffle
- Vyper
- Ganache
## Running

#### Ganache must be opened

``` $ truffle console --network development ```

``` (development) compile ```

### Criar contrato simples:

Inicia o contrato

``` let simple = await DocumentSignSimple.new({Endereço do signatario},web3.utils.asciiToHex('{CID do IPFS}'),{from:{Endereço do cartorio}}) ```

Assinar (apenas o signarário consegue)

``` simple.sign({from:{Endereço do signatario}}) ```

Bater um CID com o guardado (qualquer um consegue)

``` simple.MatchDocument(web3.utils.asciiToHex('{CID do IPFS}')) ```

#### Funções Publicas

Retorna o documento e o status (assinado ou não)

``` simple.GetDocument() ```

Retorna informações do Signatário e se já assinou

``` simple.GetSignedInfo() ```

### Criar contrato com multiplos signatários

Iniciar o contrato

``` let complex = await DocumentSignMultiSigners.new({Endereço do signatario 1},web3.utils.asciiToHex('{CID do IPFS}'),{from:{Endereço do cartorio}}) ```

Adicionar novos signatários

``` complex.AddSigner(accounts[2],{from:accounts[0]}) ```

Assinar

``` complex.Sign({from: {Endereço do assinante}}) ```

Certificar documento

``` complex.MatchDocument(web3.utils.asciiToHex("{CID do documento que quer comparar}")) ```

Buscar documento e o status (assinado ou não)

``` complex.GetDocument() ```

Buscar status da assinatura de alguém

``` complex.GetSignatureStatus({endereço do signatário}) ```

## Contribuition

1. Create Branch
2. Develop
3. Open Pull Request
4. Resolve conflits if needed
5. Merge with master
6. Delete branch

### Owners

- Maulem
- Mariana Borst
- Leonardo Baran
- João Marcelo
- João Pedro Meirelles