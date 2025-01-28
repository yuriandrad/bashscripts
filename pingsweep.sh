#!/bin/bash

# Verifica se um argumento foi passado
if [ "$1" == "" ]; then
    echo "PING SWEEP"
    echo "Modo de uso: $0 REDE"
    echo "Exemplo: $0 192.168.0"
    exit 1
fi

# Verifica se o comando 'ping' está disponível
if ! command -v ping > /dev/null; then
    echo "Erro: o comando 'ping' não está disponível."
    exit 1
fi

echo "Iniciando ping sweep na rede $1.0..."

# Loop para verificar todos os hosts de 1 a 254
for host in {1..254}; do
    ip="$1.$host" # Concatena o IP
    response=$(ping -c 1 -W 1 $ip | grep "64 bytes") # Faz o ping e verifica a resposta
    if [ "$response" != "" ]; then
        echo "Host ativo: $ip"
    fi
done

echo "Ping sweep concluído."
