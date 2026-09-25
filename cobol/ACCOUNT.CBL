       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACCOUNT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-ACCOUNT-ID PIC 9(10) VALUE 1000000001.
       01  WS-BALANCE    PIC 9(9)V99 VALUE 1500.00.
       01  WS-AMOUNT     PIC 9(9)V99 VALUE 0.
       01  WS-OPTION     PIC 9 VALUE 0.

       PROCEDURE DIVISION.
           DISPLAY "LEGACY-BANK".
           DISPLAY "Conta: " WS-ACCOUNT-ID.
           DISPLAY "Saldo: R$ " WS-BALANCE.
           DISPLAY "1 - Deposito".
           DISPLAY "2 - Saque".
           DISPLAY "3 - Consultar".
           ACCEPT WS-OPTION.

           EVALUATE WS-OPTION
               WHEN 1
                   DISPLAY "Valor do deposito:"
                   ACCEPT WS-AMOUNT
                   ADD WS-AMOUNT TO WS-BALANCE
                   DISPLAY "Novo saldo: R$ " WS-BALANCE
               WHEN 2
                   DISPLAY "Valor do saque:"
                   ACCEPT WS-AMOUNT
                   IF WS-AMOUNT <= WS-BALANCE
                       SUBTRACT WS-AMOUNT FROM WS-BALANCE
                       DISPLAY "Novo saldo: R$ " WS-BALANCE
                   ELSE
                       DISPLAY "SALDO INSUFICIENTE"
                   END-IF
               WHEN 3
                   DISPLAY "Saldo: R$ " WS-BALANCE
               WHEN OTHER
                   DISPLAY "Opcao invalida"
           END-EVALUATE.

           GOBACK.
