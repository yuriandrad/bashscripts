#!/bin/bash

# Definindo navegador padrão e o alvo da pesquisa
SEARCH="${SEARCH:-firefox}" 
ALVO="$1"

# Verificando se o argumento foi fornecido
if [ -z "$ALVO" ]; then
    echo "Erro: Nenhum argumento fornecido!"
    echo "Modo de uso: $0 site.com.br"
    exit 1
fi

# Pesquisa no Google
realizar_pesquisa() {
    local descricao="$1"
    local url="$2"
    echo "Iniciando pesquisa: $descricao"
    $SEARCH "$url" 2> /dev/null
}

# Pesquisa no Pastebin
realizar_pesquisa "Pesquisa no Pastebin" "https://google.com/search?q=site:pastebin.com+$ALVO"

# Pesquisa no Trello
realizar_pesquisa "Pesquisa no Trello" "https://google.com/search?q=site:trello.com+$ALVO"

# Pesquisa por arquivos (PHP, ASP, TXT setados)
realizar_pesquisa "Pesquisa por arquivos" "https://google.com/search?q=site:$ALVO+ext:php+OR+ext:asp+OR+ext:txt"

# Pesquisa por diretórios sensíveis
realizar_pesquisa "Pesquisa por diretórios sensíveis" "https://google.com/search?q=site:$ALVO+inurl:admin+OR+inurl:login+OR+inurl:config"

# Pesquisa por senhas vazadas
realizar_pesquisa "Pesquisa por senhas vazadas" "https://google.com/search?q=site:github.com+$ALVO+password"

# Pesquisa no Slack
realizar_pesquisa "Pesquisa no Slack" "https://google.com/search?q=site:slack.com+$ALVO"

echo "Todas as pesquisas foram concluídas."
