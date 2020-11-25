FROM --platform=linux/arm64 alpine:latest

ENV NPC_VERSION=0.26.8
ENV SERVERIP=127.0.0.1:1024
ENV VKEY=123

RUN set -x && \
    wget --no-check-certificate https://github.com/cnlh/nps/releases/download/v${NPC_VERSION}/linux_arm64_client.tar.gz && \
    mkdir /npc && \
    mv linux_arm64_client* /npc  && \
    cd /npc &&  tar xzf linux_arm64_client.tar.gz &&  rm -rf *.tar.gz &&  rm -rf nps/conf/


CMD ["sh", "-c", "/npc/npc -server=$SERVERIP -vkey=$VKEY"]
