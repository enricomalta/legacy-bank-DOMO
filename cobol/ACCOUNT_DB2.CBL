       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACCOUNTDB.

      * Laboratorio: COBOL + SQL embutido + DB2.
      * EXEC SQL e processado pelo precompiler.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL
           INCLUDE SQLCA
       END-EXEC.

       01  WS-ACCOUNT-ID PIC 9(10).
       01  WS-BALANCE    PIC S9(9)V99 COMP-3.
       01  WS-STATUS     PIC X(10).

       PROCEDURE DIVISION.
           MOVE 1000000001 TO WS-ACCOUNT-ID.

           EXEC SQL
               SELECT BALANCE, STATUS
                 INTO :WS-BALANCE, :WS-STATUS
                 FROM ACCOUNT
                WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
           END-EXEC.

           EVALUATE TRUE
               WHEN SQLCODE = 0
                   DISPLAY "ACCOUNT: " WS-ACCOUNT-ID
                   DISPLAY "BALANCE: " WS-BALANCE
                   DISPLAY "STATUS: " WS-STATUS
               WHEN SQLCODE = 100
                   DISPLAY "ACCOUNT NOT FOUND"
               WHEN OTHER
                   DISPLAY "DB2 ERROR. SQLCODE: " SQLCODE
           END-EVALUATE.
           GOBACK.
