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

RUN mkdir -p /root/.config/VintagestoryData/BackupSaves    
RUN mkdir -p /root/.config/VintagestoryData/Backups
RUN mkdir -p /root/.config/VintagestoryData/Cache    
RUN mkdir -p /root/.config/VintagestoryData/Logs    
RUN mkdir -p /root/.config/VintagestoryData/Macros    
RUN mkdir -p /root/.config/VintagestoryData/Mods    
RUN mkdir -p /root/.config/VintagestoryData/Playerdata    
RUN mkdir -p /root/.config/VintagestoryData/Saves
RUN mkdir -p /root/.config/VintagestoryData/WorldEdit

COPY VintagestoryData/Mods/ /root/.config/VintagestoryData/Mods
COPY VintagestoryData/serverconfig.json /root/.config/VintagestoryData/serverconfig.json


EXPOSE 42420/tcp
EXPOSE 42420/udp
COPY start-server.sh /app/start-server.sh
RUN chmod +x /app/start-server.sh
#CMD ["./VintagestoryServer"]
CMD ["/app/start-server.sh"]