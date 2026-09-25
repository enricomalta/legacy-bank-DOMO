       IDENTIFICATION DIVISION.
       PROGRAM-ID. WITHDRAW.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL
           INCLUDE SQLCA
       END-EXEC.

       01  WS-ACCOUNT-ID PIC 9(10) VALUE 1000000001.
       01  WS-AMOUNT     PIC S9(9)V99 COMP-3 VALUE 50.00.
       01  WS-BALANCE    PIC S9(9)V99 COMP-3.
       01  WS-ERROR      PIC X VALUE "N".

       PROCEDURE DIVISION.
           EXEC SQL
               SELECT BALANCE
                 INTO :WS-BALANCE
                 FROM ACCOUNT
                WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
           END-EXEC.

           IF SQLCODE NOT = 0
               MOVE "Y" TO WS-ERROR
           END-IF.

           IF WS-ERROR = "N"
               IF WS-AMOUNT > WS-BALANCE
                   DISPLAY "INSUFFICIENT FUNDS"
                   MOVE "Y" TO WS-ERROR
               ELSE
                   EXEC SQL
                       UPDATE ACCOUNT
                          SET BALANCE = BALANCE - :WS-AMOUNT
                        WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
                   END-EXEC
               END-IF
           END-IF.

           IF SQLCODE NOT = 0
               MOVE "Y" TO WS-ERROR
           END-IF.

           IF WS-ERROR = "N"
               EXEC SQL
                   INSERT INTO BANK_TRANSACTION
                       (ACCOUNT_ID, TRANSACTION_TYPE, AMOUNT)
                   VALUES
                       (:WS-ACCOUNT-ID, 'WITHDRAW', :WS-AMOUNT)
               END-EXEC
           END-IF.

           IF SQLCODE NOT = 0
               MOVE "Y" TO WS-ERROR
           END-IF.

           IF WS-ERROR = "N"
               EXEC SQL COMMIT END-EXEC
           ELSE
               EXEC SQL ROLLBACK END-EXEC
           END-IF.
           GOBACK.
