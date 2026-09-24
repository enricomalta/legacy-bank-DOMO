# LEGACY-BANK — laboratório COBOL + CICS + DB2

Projeto de estudos para vaga de estágio da Domo Inovação aplicado para preparação técnica em sistemas legados em COBOL.

## Objetivo

Simular uma pequena aplicação bancária transacional e estudar COBOL, WORKING-STORAGE, SQL embutido, DB2, SQLCA/SQLCODE, CICS, COMMIT/ROLLBACK, tratamento de erros e modernização.

> Laboratório educacional. Os fontes CICS/DB2 são didáticos e precisam de um ambiente IBM z/OS/CICS/DB2 apropriado para execução real.

## Arquitetura

```text
CICS transaction
      |
      v
 COBOL program
      |
      +---- EXEC SQL ----> DB2
      |
      +---- EXEC CICS ---> CICS services
```

## Transações

- INQ1 — consulta de conta
- DEP1 — depósito
- WDR1 — saque
- HST1 — histórico

## Ordem de estudo

1. `cobol/HELLO.CBL`
2. `cobol/ACCOUNT.CBL`
3. `db2/001-schema.sql`
4. `cobol/ACCOUNT_DB2.CBL`
5. `cics/INQ1.CBL`
6. `cics/DEP1.CBL`
7. `cics/WDR1.CBL`
8. `docs/TRANSACTIONS.md`
9. `docs/MODERNIZATION.md`
