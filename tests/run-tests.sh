#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COBOL_DIR="$SCRIPT_DIR/../cobol"

echo "================================="
echo "       LEGACY-BANK TESTS"
echo "================================="
echo

echo "[1/4] Compilando TEST_DEPOSIT..."

rm -f "$SCRIPT_DIR/test_deposit.exe"

if ! cobc -x -free -o "$SCRIPT_DIR/test_deposit.exe" "$SCRIPT_DIR/TEST_DEPOSIT.CBL" "$COBOL_DIR/DEPOSIT.CBL"; then
echo "ERRO: Falha ao compilar TEST_DEPOSIT."
exit 1
fi

echo "OK"
echo

echo "[2/4] Compilando TEST_WITHDRAW..."

rm -f "$SCRIPT_DIR/test_withdraw.exe"

if ! cobc -x -free -o "$SCRIPT_DIR/test_withdraw.exe" "$SCRIPT_DIR/TEST_WITHDRAW.CBL" "$COBOL_DIR/WITHDRAW.CBL"; then
echo "ERRO: Falha ao compilar TEST_WITHDRAW."
exit 1
fi

echo "OK"
echo

echo "[3/4] Compilando TEST_INQUIRY..."

rm -f "$SCRIPT_DIR/test_inquiry.exe"

if ! cobc -x -free -o "$SCRIPT_DIR/test_inquiry.exe" "$SCRIPT_DIR/TEST_INQUIRY.CBL" "$COBOL_DIR/INQUIRY.CBL"; then
echo "ERRO: Falha ao compilar TEST_INQUIRY."
exit 1
fi

echo "OK"
echo

echo "[4/4] Compilando TEST_VALIDATE_ACCOUNT..."

rm -f "$SCRIPT_DIR/test_validate_account.exe"

if ! cobc -x -free -o "$SCRIPT_DIR/test_validate_account.exe" "$SCRIPT_DIR/TEST_VALIDATE_ACCOUNT.CBL" "$COBOL_DIR/VALIDATE_ACCOUNT.CBL"; then
    echo "ERRO: Falha ao compilar TEST_VALIDATE_ACCOUNT."
    exit 1
fi

echo "OK"
echo

echo "================================="
echo "       EXECUTANDO TESTES"
echo "================================="
echo

echo "[TEST] DEPOSIT"
"$SCRIPT_DIR/test_deposit.exe"

if [ $? -ne 0 ]; then
echo
echo "ERRO: TEST_DEPOSIT falhou."
exit 1
fi

echo
echo "[TEST] WITHDRAW"
"$SCRIPT_DIR/test_withdraw.exe"

if [ $? -ne 0 ]; then
echo
echo "ERRO: TEST_WITHDRAW falhou."
exit 1
fi

echo
echo "[TEST] INQUIRY"
"$SCRIPT_DIR/test_inquiry.exe"

if [ $? -ne 0 ]; then
echo
echo "ERRO: TEST_INQUIRY falhou."
exit 1
fi

echo
echo "[TEST] VALIDATE_ACCOUNT"
"$SCRIPT_DIR/test_validate_account.exe"

if [ $? -ne 0 ]; then
    echo
    echo "ERRO: TEST_VALIDATE_ACCOUNT falhou."
    exit 1
fi

echo
echo "================================="
echo "       ALL TESTS PASSED"
echo "       15/15 TESTS PASSED"
echo "================================="

exit 0
