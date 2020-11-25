FROM alpine:latest as qemu

ARG QEMU_VERSION=4.2.0-6
ARG QEMU_ARCHS="aarch64"

RUN apk --update add curl

# Enable non-native runs on amd64 architecture hosts
RUN for i in ${QEMU_ARCHS}; do curl -L https://github.com/multiarch/qemu-user-static/releases/download/v${QEMU_VERSION}/qemu-${i}-static.tar.gz | tar zxvf - -C /usr/bin; done
RUN chmod +x /usr/bin/qemu-*

FROM arm64v8/alpine:latest AS release

COPY --from=qemu /usr/bin/qemu-*-static /usr/bin/

ENV NPC_VERSION=0.26.8
ENV SERVERIP=127.0.0.1:1024
ENV VKEY=123

RUN set -x && \
    wget --no-check-certificate https://github.com/cnlh/nps/releases/download/v${NPC_VERSION}/linux_arm64_client.tar.gz && \
    mkdir /npc && \
    mv linux_arm64_client* /npc  && \
    cd /npc &&  tar xzf linux_arm64_client.tar.gz &&  rm -rf *.tar.gz &&  rm -rf nps/conf/


CMD ["sh", "-c", "/npc/npc -server=$SERVERIP -vkey=$VKEY"]
