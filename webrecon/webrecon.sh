#!/bin/bash

# Cores
RESET="\e[0m"
BOLD="\e[1m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"

# Título
echo -e "${BOLD}${CYAN}==========================================="
echo -e "${CYAN}              Web Recon"
echo -e "${CYAN}           Script de Reconhecimento"
echo -e "${CYAN}===========================================${RESET}"

# Verifica se foi fornecido um URL como parâmetro
if [ -z "$1" ]; then
  echo -e "${RED}Uso: $0 <URL> <wordlist_diretorios> <wordlist_arquivos>${RESET}"
  exit 1
fi

# URL base
URL=$1

# Wordlist de diretórios / arquivos
wordlist_diretorios=$2
wordlist_arquivos=$3

# Verifica se as wordlists existem
if [ ! -f "$wordlist_diretorios" ]; then
  echo -e "${RED}A wordlist de diretórios '$wordlist_diretorios' não foi encontrada!${RESET}"
  exit 1
fi

if [ ! -f "$wordlist_arquivos" ]; then
  echo -e "${RED}A wordlist de arquivos '$wordlist_arquivos' não foi encontrada!${RESET}"
  exit 1
fi

# Separador
echo -e "${YELLOW}==================== Verificação de Diretórios ====================${RESET}"

# Loop diretórios
for palavra in $(cat $wordlist_diretorios); do
  resposta_dir=$(curl -s -H "User-Agent: DesecTool" -o /dev/null -w "%{http_code}" "$URL/$palavra/")

  if [ "$resposta_dir" == "200" ]; then
    echo -e "${GREEN}Diretório encontrado: $URL/$palavra/${RESET}"
  fi
done

# Separador
echo -e "${YELLOW}==================== Verificação de Arquivos ======================${RESET}"

# Loop arquivos
for palavra in $(cat $wordlist_arquivos); do
  resposta_arquivo=$(curl -s -H "User-Agent: DesecTool" -o /dev/null -w "%{http_code}" "$URL/$palavra")

  if [ "$resposta_arquivo" == "200" ]; then
    echo -e "${GREEN}Arquivo encontrado: $URL/$palavra${RESET}"
  fi
done

# Mensagem final
echo -e "${CYAN}Processo de verificação concluído.${RESET}"
