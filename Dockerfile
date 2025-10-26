FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    libgtk-3-0 libglib2.0-0 libopenal1 ca-certificates curl tar unzip nano \
    && curl -sSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh \
    && bash dotnet-install.sh --channel 8.0 --install-dir /usr/share/dotnet \
    && rm dotnet-install.sh \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Baixa e extrai o cliente Linux
RUN curl -L -o vintagestory-client.tar.gz "https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_1.21.5.tar.gz" \
    && tar --strip-components=1 -xzf vintagestory-client.tar.gz \
    && rm vintagestory-client.tar.gz \
    && chmod +x Vintagestory

#RUN mkdir -p /root/.config/VintagestoryData/BackupSaves PERSISTIDO  
#RUN mkdir -p /root/.config/VintagestoryData/Backups PERSISTIDO
#RUN mkdir -p /root/.config/VintagestoryData/Cache   PERSISTIDO  
#RUN mkdir -p /root/.config/VintagestoryData/Logs    PERSISTIDO    
#RUN mkdir -p /root/.config/VintagestoryData/Macros  PERSISTIDO  
#RUN mkdir -p /root/.config/VintagestoryData/Mods    NAO
#RUN mkdir -p /root/.config/VintagestoryData/Playerdata  PERSISTIDO   
#RUN mkdir -p /root/.config/VintagestoryData/Saves PERSISTIDO
#RUN mkdir -p /root/.config/VintagestoryData/WorldEdit NAO

COPY VintagestoryData/Mods/ /root/.config/VintagestoryData/Mods
COPY VintagestoryData/serverconfig.json /root/.config/VintagestoryData/serverconfig.json
COPY VintagestoryData/servermagicnumbers.json /root/.config/VintagestoryData/servermagicnumbers.json
COPY VintagestoryData/ModConfig /root/.config/VintagestoryData/ModConfig


EXPOSE 42420/tcp
EXPOSE 42420/udp

CMD ["./VintagestoryServer"]
