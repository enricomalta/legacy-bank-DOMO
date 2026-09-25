       IDENTIFICATION DIVISION.
       PROGRAM-ID. INQ1.

      * Estrutura didatica de uma transacao CICS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       01 WS-ACCOUNT-ID PIC 9(10).
       01 WS-BALANCE PIC S9(9)V99 COMP-3.
       01 WS-STATUS PIC X(10).

       PROCEDURE DIVISION.
           EXEC CICS RECEIVE END-EXEC.

           EXEC SQL
               SELECT BALANCE, STATUS
                 INTO :WS-BALANCE, :WS-STATUS
                 FROM ACCOUNT
                WHERE ACCOUNT_ID = :WS-ACCOUNT-ID
           END-EXEC.

           EXEC CICS SEND TEXT END-EXEC.
           EXEC CICS RETURN END-EXEC.
