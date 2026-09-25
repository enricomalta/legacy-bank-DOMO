       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NAME PIC X(40).

       PROCEDURE DIVISION.
           DISPLAY "================================".
           DISPLAY " LEGACY-BANK / COBOL LAB".
           DISPLAY "================================".
           DISPLAY "Digite seu nome:".
           ACCEPT WS-NAME.
           DISPLAY "Ola, " WS-NAME.
           DISPLAY "Programa COBOL executado com sucesso.".
           GOBACK.
