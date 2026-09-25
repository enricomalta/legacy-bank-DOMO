# LEGACY-BANK

Laboratório de estudos de COBOL, CICS, DB2 e processamento Batch.

## Status

Em desenvolvimento.

## Roadmap

### 1. COBOL

* Refatorar ACCOUNT.CBL
* Utilizar PERFORM e parágrafos
* Utilizar níveis 88
* Melhorar validação de entrada
* Implementar tratamento de erros
* Estudar CALL
* Estudar LINKAGE SECTION
* Estudar USING
* Estudar COPY

### 2. DB2

* Aprofundar SQLCODE e SQLSTATE
* Trabalhar com JOIN
* Estudar constraints e índices
* Implementar cursores
* Estudar DECLARE CURSOR, OPEN, FETCH e CLOSE
* Estudar DBRM
* Estudar BIND
* Estudar PACKAGE e PLAN

### 3. CICS

* Aprofundar RECEIVE e SEND
* Estudar LINK
* Estudar XCTL
* Estudar COMMAREA
* Estudar CHANNEL e CONTAINER
* Estudar SYNCPOINT
* Estudar RESP e RESP2

### 4. COBOL Batch

* Criar programa Batch
* Trabalhar com arquivos sequenciais
* Estudar FILE SECTION
* Utilizar READ e WRITE
* Gerar arquivos de saída
* Criar processamento de relatório
* Implementar tratamento de registros inválidos

### 5. JCL

* Estudar JOB
* Estudar EXEC
* Estudar DD
* Estudar datasets
* Estudar JOB STEPs
* Trabalhar com Return Codes
* Criar um fluxo Batch completo

### 6. Transações

Aprofundar o funcionamento de uma unidade de trabalho:

```text
UPDATE ACCOUNT
      |
      v
INSERT TRANSACTION
      |
      +---- sucesso ----> COMMIT
      |
      +---- erro -------> ROLLBACK
```

Estudar:

* Locks
* Concorrência
* Deadlocks
* Recovery
* Atomicidade
* Tratamento de falhas

### 7. Testes

Criar testes para:

* Consulta de conta
* Conta inexistente
* Depósito
* Saque
* Saldo insuficiente
* Valor inválido
* Falha de SQL
* COMMIT
* ROLLBACK
* Histórico de transações

### 8. C# / .NET

Depois de consolidar o ambiente legado:

* Criar API ASP.NET Core
* Criar camada de serviços
* Utilizar SQL Server
* Implementar operações bancárias
* Criar testes automatizados
* Documentar API com OpenAPI/Swagger

### 9. Modernização

Estudar como uma aplicação moderna pode coexistir com o sistema legado:

```text
              API .NET
                  |
          Camada de integração
                  |
              CICS / COBOL
                  |
                 DB2
```

Estudar:

* Adapter
* APIs
* Integração com sistemas legados
* Migração gradual
* Strangler Fig Pattern
* Anti-Corruption Layer
* Mensageria
* Event-driven architecture

## Ordem de evolução

```text
COBOL
  ↓
COBOL estruturado
  ↓
DB2
  ↓
Transações
  ↓
CICS
  ↓
Batch
  ↓
JCL
  ↓
Testes
  ↓
C# / .NET
  ↓
Modernização
```

## Objetivo

Ao final, o projeto tem como objetivo demonstrar conhecimento prático do fluxo de um sistema bancário legado:

```text
CICS
  ↓
COBOL
  ↓
DB2
```

e também de processamento Batch:

```text
JCL
  ↓
COBOL Batch
  ↓
DB2 / Arquivos
```

seguido de uma camada moderna:

```text
C# / .NET
  ↓
Integração
  ↓
COBOL / CICS / DB2
```
