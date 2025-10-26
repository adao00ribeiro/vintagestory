#!/bin/bash

# Inicia o servidor em background
./VintagestoryServer &

SERVER_PID=$!

# Aguarda alguns segundos para o servidor inicializar
sleep 20

# Envia comandos para o console do servidor
echo "/serverconfig whitelistmode off" | ./VintagestoryServer
#echo "/serverconfig OnlyWhitelisted false" > /proc/$SERVER_PID/fd/0

# Mantém o container vivo com shell interativo
wait $SERVER_PID
