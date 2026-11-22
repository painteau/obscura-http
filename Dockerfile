FROM ubuntu:24.04

# apt-get upgrade : l'image ubuntu:24.04 peut retarder sur les correctifs de sécurité
# (libbrotli1 1.1.0-2ubuntu0.1, CVE-2026-111497, USN-8956-1). Le Node d'Ubuntu
# charge cette libbrotli du système, il est corrigé avec elle.
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    ca-certificates curl nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Refuse le build si la libbrotli1 installée n'est pas corrigée.
RUN v="$(dpkg-query -W -f='${Version}' libbrotli1)" \
    && echo "libbrotli1 $v" \
    && dpkg --compare-versions "$v" ge 1.1.0-2ubuntu0.1

WORKDIR /app

RUN curl -L https://github.com/h4ckf0r0day/obscura/releases/download/v0.1.1/obscura-x86_64-linux.tar.gz \
    | tar -xz && chmod +x obscura

COPY package.json ./
RUN npm install

COPY server.js entrypoint.sh ./
RUN chmod +x entrypoint.sh

EXPOSE 3100

CMD ["./entrypoint.sh"]
