FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    libgtk-3-0 libglib2.0-0 libopenal1 ca-certificates curl tar unzip \
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

# Cria diretórios persistentes
RUN mkdir -p /data/Worlds /data/Saves /data/Logs /mods

VOLUME ["/data", "/mods" , "playerData"]

EXPOSE 42420/tcp
EXPOSE 42420/udp

CMD ["./VintagestoryServer"]
