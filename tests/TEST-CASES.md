# Casos de teste

Para rodar todos os testes automaticamente rode ./run-tests.sh caso queira testar manualmente abaixo possui a logica do teste o codigo de compilar e codigo de teste.

## INQ1

- conta existente -> saldo retornado
- conta inexistente -> não encontrada
- conta inativa -> regra de negócio aplicada

cobc -x -free -o test_inquiry.exe TEST_INQUIRY.CBL ../cobol/INQUIRY.CBL
./test_inquiry.exe

## DEP1

- depósito válido -> saldo + valor e histórico criado
- valor inválido -> rejeitado
- falha no histórico -> rollback

cobc -x -free -o test_deposit.exe TEST_DEPOSIT.CBL ../cobol/DEPOSIT.CBL
./test_deposit.exe

## WDR1

- saque válido -> saldo - valor e histórico criado
- saldo insuficiente -> rejeitado
- falha no histórico -> rollback

cobc -x -free -o test_withdraw.exe TEST_WITHDRAW.CBL ../cobol/WITHDRAW.CBL
./test_withdraw.exe

## Exercícios adicionais

- conta bloqueada
- concorrência
- valor negativo
- falha de conexão/SQL
- idempotência de uma solicitação repetida




