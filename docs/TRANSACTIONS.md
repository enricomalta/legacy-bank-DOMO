# Transações, COMMIT e ROLLBACK

Para um depósito, pensei em uma unidade de trabalho:

```text
UPDATE ACCOUNT
      |
INSERT BANK_TRANSACTION
      |
   tudo OK?
    /    \
  sim     nao
  |        |
COMMIT   ROLLBACK
```

Se o saldo for alterado e o histórico falhar, deixar apenas a primeira operação persistida pode produzir estado inconsistente. O exercício é entender como a aplicação detecta a falha e desfaz a unidade de trabalho.

## Exercício

1. Faça o INSERT falhar propositalmente.
2. Observe o SQLCODE.
3. Verifique se o saldo permaneceu alterado.
4. Explique por que o ROLLBACK é importante.
