FROM ubuntu:22.04
ARG TARGETARCH
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get upgrade \
    && apt-get install -y openssh-client git curl 
RUN if [ "$TARGETARCH" = "arm64" ] ; then curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm64" --output /tmp/vscode-cli.tar.gz ; fi
RUN if [ "$TARGETARCH" = "amd64" ] ; then curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" --output /tmp/vscode-cli.tar.gz ; fi
RUN tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin && \
    rm /tmp/vscode-cli.tar.gz
RUN useradd -ms /bin/bash ubuntu
USER ubuntu
WORKDIR /home/ubunut
RUN mkdir .ssh

CMD ["code", "tunnel", "--accept-server-license-terms"]