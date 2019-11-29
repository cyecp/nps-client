FROM alpine:latest

ENV NPC_VERSION=0.24.0
ENV SERVERIP=127.0.0.1:1024
ENV VKEY=123

RUN set -x && \
    wget --no-check-certificate https://github.com/cnlh/nps/releases/download/v${NPC_VERSION}/linux_amd64_client.tar.gz && \
    mkdir /npc && \
    mv linux_amd64_client* /npc  && \
    cd /npc &&  tar xzf linux_amd64_client.tar.gz &&  rm -rf *.tar.gz &&  rm -rf nps/conf/


CMD ["sh", "-c", "/npc/nps/npc -server=$SERVERIP -vkey=$VKEY"]