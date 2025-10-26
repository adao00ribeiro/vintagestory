#!/bin/bash

# Diretórios persistentes
mkdir -p /vintagestory-persistent/Saves
mkdir -p /vintagestory-persistent/Playerdata

# Pasta original do servidor
mkdir -p /root/.config/VintagestoryData

# Remove qualquer pasta existente e cria links simbólicos
rm -rf /root/.config/VintagestoryData/Saves
rm -rf /root/.config/VintagestoryData/Playerdata

ln -s /vintagestory-persistent/Saves /root/.config/VintagestoryData/Saves
ln -s /vintagestory-persistent/Playerdata /root/.config/VintagestoryData/Playerdata

# Inicia o servidor
cd /app
./VintagestoryServer
