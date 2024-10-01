#/!/bin/bash
#scannet.sh

if [ "$1" == ""] #Se o argumento estiver vazio
then #Então
    echo "- PORTSCAN NETWORK -"
    echo "Modo de uso $0 [REDE] [PORTA]"
    echo "Exemplo: $0 172.16.1 80"
else
for ip in {1..254}; #Para cada endereço de 1 até 254
do #Faça
hping -S -p $2 -c 1 $1.$ip; 2> /dev/null; | grep "flags=SA" | cut -d " " -f 2; #Um envio de pacote (1) SYN apenas na porta 80 para o argumento inserido pelo usuário
done
