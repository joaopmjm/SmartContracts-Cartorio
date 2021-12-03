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
> let simpleContract = await DocumentSignSimple.new(accounts[1],web3.utils.asciiToHex("QmZLf3YN6aetfeckzYaodUzYaJU5upF8cMpvVVUPf7hQVa"),{from:accounts[0]})

// Checar Status do contrato, mostrando que não está assinado, nem que o status da assinatura do signatário está "false"
> simpleContract.GetDocument()
// Output: Hash do documento e o status FALSE
> simpleContract.GetSignedInfo()
// Output: O endereço do assinante e o status FALSE
// Testar o Matching Document
// Documento diferente
> simpleContract.MatchDocument(web3.utils.asciiToHex("QmWjr5NMLTVaoqEfCUFoioZVsvM2b5fgwoz6dL2nDRxy7t"))
// Output: false
// Documento correto
> simpleContract.MatchDocument(web3.utils.asciiToHex("QmZLf3YN6aetfeckzYaodUzYaJU5upF8cMpvVVUPf7hQVa"))
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