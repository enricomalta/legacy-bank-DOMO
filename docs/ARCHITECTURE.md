# Arquitetura

```text
CICS transaction
       |
       v
COBOL business logic
       |
       +---- EXEC SQL ----> DB2
       |
       +---- EXEC CICS ---> CICS services
```

CICS gerencia o ambiente transacional; COBOL implementa a lógica; DB2 mantém os dados; SQLCA/SQLCODE ajudam o programa a tratar o resultado das operações SQL.

Analogia didática com aplicações modernas:

```text
REST API -> Controller -> Service -> Repository -> DB
CICS     -> COBOL      -> lógica  -> EXEC SQL  -> DB2
```
