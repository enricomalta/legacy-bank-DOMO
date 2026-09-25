# LEGACY-BANK — Common Errors

Documentação dos erros encontrados durante a compilação e execução do projeto COBOL com GnuCOBOL no MSYS2 UCRT64.





## 1. Erro `default.conf: No such file or directory`

### Erro

```text
configuration error: /ucrt64/share/gnucobol/config\default.conf:
No such file or directory
```

### Causa

O GnuCOBOL está instalado no ambiente UCRT64, mas o diretório de configuração não foi localizado automaticamente.

### Solução

Executar:

```bash
export COB_CONFIG_DIR=/ucrt64/share/gnucobol/config
```

Depois verificar:

```bash
cobc --version
```

Se o comando funcionar, o compilador está configurado corretamente.

### Observação

Esse `export` vale apenas para a sessão atual do terminal MSYS2.

Se fechar o terminal e abrir novamente, pode ser necessário executar o comando outra vez.

---

## 2. Terminal aberto no diretório errado

### Sintoma

Os arquivos `.CBL` existem, mas os comandos não encontram os arquivos ou o executável.

### Solução

Entrar no diretório do projeto:
abaixo um exemplo de path coloque o local correto onde se encontra o projeto

```bash
cd /c/Users/[NOME-COMPUTADOR]/Desktop/legacy-bank/cobol
```

Verificar:

```bash
pwd
```

O resultado esperado é:

```text
/c/Users/[NOME-COMPUTADOR]/Desktop/legacy-bank/cobol
```

Listar os arquivos:

```bash
ls
```

---

## 3. Markdown dentro do arquivo COBOL

### Erro

O compilador apresenta erros inesperados em linhas contendo:

```text
```

````

ou:

```text
```cobol
````

### Causa

O conteúdo do arquivo `.CBL` recebeu acidentalmente delimitadores de Markdown usados para apresentar código em documentação.

Esses caracteres não fazem parte do código COBOL.

### Solução

O arquivo `.CBL` deve conter somente COBOL.

Remover qualquer linha contendo:

```text
```

````

Depois recompilar.

### Regra

Arquivos COBOL:

```text
ACCOUNT.CBL
DEPOSIT.CBL
WITHDRAW.CBL
INQUIRY.CBL
````

devem conter somente código COBOL.

Arquivos Markdown:

```text
README.md
COMMON_ERRORS.md
```

podem utilizar Markdown normalmente.

---

## 4. Compilação de um programa COBOL

Para compilar apenas um módulo:

```bash
cobc -c -free DEPOSIT.CBL
```

Exemplo:

```bash
cobc -c -free WITHDRAW.CBL
```

O parâmetro `-c` gera o objeto sem criar o executável final.

---

## 5. Erro de `WinMain` ao fazer link manual dos `.o`

### Erro

Ao tentar:

```bash
cobc -x -o account.exe ACCOUNT.o DEPOSIT.o WITHDRAW.o INQUIRY.o
```

pode ocorrer:

```text
undefined reference to `WinMain'
```

### Causa

O processo de linkedição dos objetos não identificou corretamente o programa principal no ambiente Windows/GnuCOBOL.

Isso ocorreu quando tentamos montar o executável manualmente a partir dos arquivos `.o`.

### Solução

Para este projeto, é mais simples deixar o `cobc` compilar e linkar os fontes diretamente:

```bash
rm -f *.o account.exe
```

Depois:

```bash
cobc -x -free -o account.exe ACCOUNT.CBL DEPOSIT.CBL WITHDRAW.CBL INQUIRY.CBL
```

Executar:

```bash
./account.exe
```

---

## 6. Executável antigo sendo executado

### Sintoma

O código foi alterado, mas o comportamento do `account.exe` continua igual.

### Causa

O executável anterior ainda está presente e não foi recompilado corretamente.

### Solução

Remover o executável e os objetos antigos:

```bash
rm -f *.o account.exe
```

Recompilar:

```bash
cobc -x -free -o account.exe ACCOUNT.CBL DEPOSIT.CBL WITHDRAW.CBL INQUIRY.CBL
```

Executar:

```bash
./account.exe
```

---

## 7. Programa não encontra subprograma chamado com `CALL`

### Sintoma

O programa principal compila, mas durante a execução ocorre erro relacionado a:

```text
CALL "DEPOSIT"
```

ou:

```text
CALL "WITHDRAW"
```

ou:

```text
CALL "INQUIRY"
```

### Causa

O subprograma não foi incluído corretamente na compilação/linkedição ou o módulo não está disponível para o runtime.

### Solução

Compilar o programa principal junto com todos os subprogramas:

```bash
cobc -x -free -o account.exe ACCOUNT.CBL DEPOSIT.CBL WITHDRAW.CBL INQUIRY.CBL
```

---

## 8. Alteração de variável não aparece no programa principal

### Sintoma

Um subprograma altera uma variável, mas o programa principal não recebe a alteração.

### Causa

Quando usamos `CALL`, os dados precisam ser declarados corretamente na `LINKAGE SECTION` do subprograma e recebidos através de:

```cobol
PROCEDURE DIVISION USING ...
```

Exemplo:

```cobol
LINKAGE SECTION.

01 LK-BALANCE     PIC S9(9)V99.
01 LK-AMOUNT      PIC S9(9)V99.
01 LK-RETURN-CODE PIC 9.
```

E:

```cobol
PROCEDURE DIVISION USING LK-BALANCE
                           LK-AMOUNT
                           LK-RETURN-CODE.
```

O programa principal deve passar os campos:

```cobol
CALL "DEPOSIT"
    USING WS-BALANCE
          WS-AMOUNT
          WS-RETURN-CODE
```

### Regra

`WORKING-STORAGE` pertence ao programa.

`LINKAGE SECTION` é utilizada para dados recebidos pelo programa chamado.

---

## 9. Variável aparentemente "perdida" após alteração do código

### Sintoma

Uma variável parece não existir, ou uma condição `88` começa a funcionar incorretamente depois de reorganizar o `WORKING-STORAGE`.

### Causa

Níveis `88` pertencem ao campo imediatamente anterior.

Exemplo:

```cobol
01 WS-OPTION PIC 9 VALUE 0.

88 OPTION-DEPOSIT VALUE 1.
88 OPTION-WITHDRAW VALUE 2.
88 OPTION-INQUIRY VALUE 3.
```

Essas condições pertencem a `WS-OPTION`.

Se outro campo for colocado entre eles:

```cobol
01 WS-OPTION PIC 9 VALUE 0.
01 WS-OTHER PIC 9 VALUE 0.

88 OPTION-DEPOSIT VALUE 1.
```

as condições `88` passam a pertencer a `WS-OTHER`, causando comportamento incorreto.

### Regra

Sempre manter os `88` imediatamente abaixo do campo ao qual pertencem.

---

## 10. `EVALUATE TRUE` não entra no `WHEN` esperado

### Sintoma

O usuário digita `1`, `2` ou `3`, mas aparece:

```text
ERRO: Opcao invalida.
```

### Causa

As condições `88` podem estar associadas ao campo errado.

Exemplo correto:

```cobol
01 WS-OPTION PIC 9 VALUE 0.

88 OPTION-DEPOSIT  VALUE 1.
88 OPTION-WITHDRAW VALUE 2.
88 OPTION-INQUIRY VALUE 3.
```

Depois:

```cobol
EVALUATE TRUE
    WHEN OPTION-DEPOSIT
        PERFORM DEPOSIT

    WHEN OPTION-WITHDRAW
        PERFORM WITHDRAW

    WHEN OPTION-INQUIRY
        PERFORM INQUIRY

    WHEN OTHER
        DISPLAY "ERRO: Opcao invalida."
END-EVALUATE.
```

Se os `88` estiverem associados ao campo errado, o `EVALUATE` não encontrará a condição esperada.

---

## 11. Saldo volta para R$ 1500 após executar novamente

### Sintoma

O programa começa novamente com:

```text
Saldo: R$ +000001500.00
```

mesmo depois de realizar depósitos e saques.

### Causa

O saldo atualmente está em `WORKING-STORAGE`:

```cobol
01 WS-BALANCE PIC S9(9)V99 VALUE 1500.00.
```

O valor existe somente enquanto o programa está executando.

Ao encerrar o processo, o valor é perdido.

### Solução futura

A persistência será implementada com DB2.

Fluxo planejado:

```text
ACCOUNT
   |
   v
DB2
   |
   +--> ACCOUNT
   |
   +--> BANK_TRANSACTION
```

Depois disso, o saldo não dependerá mais do valor inicial definido no COBOL.

---

## 12. Limpar compilação anterior

Quando houver comportamento estranho depois de várias tentativas de compilação:

```bash
rm -f *.o account.exe
```

Depois recompilar tudo:

```bash
cobc -x -free -o account.exe ACCOUNT.CBL DEPOSIT.CBL WITHDRAW.CBL INQUIRY.CBL
```

Executar:

```bash
./account.exe
```

---

## 13. Sequência padrão de recuperação






Se amanhã o ambiente apresentar um erro que não lembramos:

### 1. Entrar no diretório

```bash
cd /c/Users/[NOME-COMPUTADOR]/Desktop/legacy-bank/cobol
```

### 2. Configurar o GnuCOBOL

```bash
export COB_CONFIG_DIR=/ucrt64/share/gnucobol/config
```

### 3. Limpar objetos e executável

```bash
rm -f *.o account.exe
```

### 4. Compilar

```bash
cobc -x -free -o account.exe ACCOUNT.CBL DEPOSIT.CBL WITHDRAW.CBL INQUIRY.CBL
```

### 5. Executar

```bash
./account.exe
```

### 6. Se houver erro

Não apagar ou alterar arquivos imediatamente.

Guardar a mensagem completa do terminal e analisar:

```bash
cobc --version
```

e o comando exato utilizado na compilação.

---

## Ambiente utilizado

* Windows
* MSYS2
* UCRT64
* GnuCOBOL 3.2.0
* Projeto: LEGACY-BANK
* Diretório COBOL:

```text
/c/Users/[NOME-COMPUTADOR]/Desktop/legacy-bank/cobol
```

## Estrutura atual

```text
cobol/
├── ACCOUNT.CBL
├── ACCOUNT_DB2.CBL
├── DEPOSIT.CBL
├── DEPOSIT_DB2.CBL
├── HELLO.CBL
├── INQUIRY.CBL
├── WITHDRAW.CBL
└── WITHDRAW_DB2.CBL
```

Este documento deve ser atualizado quando um novo erro recorrente for identificado durante o desenvolvimento do LEGACY-BANK.
