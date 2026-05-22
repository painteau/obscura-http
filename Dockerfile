FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    ca-certificates curl nodejs npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -L https://github.com/h4ckf0r0day/obscura/releases/download/v0.1.1/obscura-x86_64-linux.tar.gz \
    | tar -xz && chmod +x obscura

COPY package.json ./
RUN npm install

COPY server.js entrypoint.sh ./
RUN chmod +x entrypoint.sh

EXPOSE 3100

CMD ["./entrypoint.sh"]
