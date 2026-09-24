# Casos de teste

## INQ1

- conta existente -> saldo retornado
- conta inexistente -> não encontrada
- conta inativa -> regra de negócio aplicada

## DEP1

- depósito válido -> saldo + valor e histórico criado
- valor inválido -> rejeitado
- falha no histórico -> rollback

## WDR1

- saque válido -> saldo - valor e histórico criado
- saldo insuficiente -> rejeitado
- falha no histórico -> rollback

## Exercícios adicionais

- conta bloqueada
- concorrência
- valor negativo
- falha de conexão/SQL
- idempotência de uma solicitação repetida
