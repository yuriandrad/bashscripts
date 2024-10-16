#!/bin/bash

# Definindo as variáveis de cor 
azul='\e[34m'
reset='\e[0m'
vermelho='\e[31m'

# Verificando se uma URL foi passada como argumento
if [ "$#" -eq 0 ]; then
    echo "#########################################"
    echo -e "MODO DE USO:${azul} $0 ${reset}${vermelho}www.alvo.com.br${reset}"
    echo "#########################################"
    exit 1
fi

# A URL fornecida como argumento
url=$1
output_file="$url.ip.txt"

# Baixando o conteúdo da página
echo "Resolvendo URLs em: $url"
if wget -q -O "$output_file" "$url"; then
    echo "Conteúdo baixado com sucesso."
else
    echo "Falha ao baixar o conteúdo da URL."
    exit 1
fi

echo ""

# Filtrando possíveis subdomínios
cat "$output_file" | grep href | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" 

