# Pipeline de build — visão de estudo

Um fluxo tradicional pode envolver:

```text
COBOL source
   |
SQL precompiler
   |
CICS translator
   |
compiler
   |
link-edit
   |
load module
```

Para Db2 existe também o fluxo de DBRM/bind, conforme ambiente e configuração. A sequência exata depende da versão, JCL e ferramentas da empresa.
