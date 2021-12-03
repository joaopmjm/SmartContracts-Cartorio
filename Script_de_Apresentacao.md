# Script para apresentação do projeto

## Preparação

Com truffle funcionando, ganache aberto (pode ser em quickstart), vamos rodar:

```js
> $ truffle console --network development

> truffle(development): compile
```

## Iniciar gravação

Vamos iniciar demonstrando o contrato simples com 1 signatário, lembrando, o ambiente nos fornece 10 contas com 100 ethers, a conta número 0 vai ser o cartório, e as outas pessoas que vão usar o serviço.


```js
// Criação do contrato
> let simpleContract = await DocumentSignSimple.new(accounts[1],web3.utils.asciiToHex("{CID do IPFS}"),{from:accounts[0]})

// Checar Status do contrato, mostrando que não está assinado, nem que o status da assinatura do signatário está "false"
> simpleContract.GetDocument()
// Output: Hash do documento e o status FALSE
> simpleContract.GetSignedInfo()
// Output: O endereço do assinante e o status FALSE
// Testar o Matching Document
// Documento diferente
> simpleContract.MatchDocument(web3.utils.asciiToHex("CID do IPFS do errado"))
// Output: false
// Documento correto
> simpleContract.MatchDocument(web3.utils.asciiToHex("CID do IPFS"))
// Output: true

// Assinar o contrato com a pessoa incorreta
> simpleContract.Sign({from:accounts[2]})
// Output: Retornar erro

// Assinar com a pessoa correta
> simpleContract.Sign({from:accounts[1]})
// Output: Não ser erro

// Checar Status do contrato, mostrando que não está assinado, nem que o status da assinatura do signatário está "false"
> simpleContract.GetDocument()
// Output: Hash do documento e o status TRUE
> simpleContract.GetSignedInfo()
// Output: O endereço do assinante e o status TRUE

```

### ***Fim do contrato simples***

## Script contrato complexo

```js
// Iniciar contrato com o numero 2 como assinantes
> let complexContract = await DocumentSignMultiSigners.new(accounts[2], web3.utils.asciiToHex("CID do IPFS"),{from: accounts[0]})

// Checar contrato não assinado
> complexContract.GetDocument()
// Output: false

// Adicionar mais 2 assinantes, para adicionar precisa ser quem criou
> complexContract.AddSigner(accounts[3],{from:accounts[0]})
> complexContract.AddSigner(accounts[4],{from:accounts[0]})

// Checar status dos assinantes
> complexContract.GetSignatureStatus(accounts[2])
> complexContract.GetSignatureStatus(accounts[3])
> complexContract.GetSignatureStatus(accounts[4])
// Output: False (para os 3)

// 1 Assinatura
> complexContract.Sign({from: accounts[3]})
> complexContract.GetSignatureStatus(accounts[3])
// Output: True

// Checar status do Contrato
> complexContract.GetDocument()
// Output false

// Todos os outros assinam
> complexContract.Sign({from: accounts[2]})
> complexContract.Sign({from: accounts[4]})

// Checar status do Contrato
> complexContract.GetDocument()
// Output: true

```

### ***Fim do contrato Complexo***
