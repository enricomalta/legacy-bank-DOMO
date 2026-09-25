       IDENTIFICATION DIVISION.
       PROGRAM-ID. DEP1.

      * CICS -> COBOL -> DB2 -> COMMIT/ROLLBACK.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       01 WS-ACCOUNT-ID PIC 9(10).
       01 WS-AMOUNT PIC S9(9)V99 COMP-3.

       PROCEDURE DIVISION.
           EXEC CICS RECEIVE END-EXEC.

           EXEC SQL
               UPDATE ACCOUNT
                  SET BALANCE = BALANCE + :WS-AMOUNT
                WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
           END-EXEC.

           IF SQLCODE = 0
               EXEC SQL
                   INSERT INTO BANK_TRANSACTION
                       (ACCOUNT_ID, TRANSACTION_TYPE, AMOUNT)
                   VALUES (:WS-ACCOUNT-ID, 'DEPOSIT', :WS-AMOUNT)
               END-EXEC
           END-IF.

           IF SQLCODE = 0
               EXEC SQL COMMIT END-EXEC
           ELSE
               EXEC SQL ROLLBACK END-EXEC
           END-IF.

           EXEC CICS SEND TEXT END-EXEC.
           EXEC CICS RETURN END-EXEC.
