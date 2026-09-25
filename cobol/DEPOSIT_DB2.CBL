       IDENTIFICATION DIVISION.
       PROGRAM-ID. DEPOSIT.

      * Fluxo didatico: UPDATE + INSERT + COMMIT ou ROLLBACK.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL
           INCLUDE SQLCA
       END-EXEC.

       01  WS-ACCOUNT-ID PIC 9(10) VALUE 1000000001.
       01  WS-AMOUNT     PIC S9(9)V99 COMP-3 VALUE 100.00.
       01  WS-ERROR      PIC X VALUE "N".

       PROCEDURE DIVISION.
           EXEC SQL
               UPDATE ACCOUNT
                  SET BALANCE = BALANCE + :WS-AMOUNT
                WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
           END-EXEC.

           IF SQLCODE NOT = 0
               MOVE "Y" TO WS-ERROR
           END-IF.

           IF WS-ERROR = "N"
               EXEC SQL
                   INSERT INTO BANK_TRANSACTION
                       (ACCOUNT_ID, TRANSACTION_TYPE, AMOUNT)
                   VALUES
                       (:WS-ACCOUNT-ID, 'DEPOSIT', :WS-AMOUNT)
               END-EXEC
           END-IF.

           IF SQLCODE NOT = 0
               MOVE "Y" TO WS-ERROR
           END-IF.

           IF WS-ERROR = "N"
               EXEC SQL COMMIT END-EXEC
               DISPLAY "DEPOSIT COMMITTED"
           ELSE
               EXEC SQL ROLLBACK END-EXEC
               DISPLAY "DEPOSIT ROLLED BACK"
           END-IF.
           GOBACK.
