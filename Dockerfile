FROM ubuntu:latest

ARG BS_VERSION

EXPOSE 43210/udp

RUN apt-get update

RUN apt-get install --no-install-recommends -y \
      wget \
      python3.9 \
      libpython3.9

WORKDIR /usr/src/app/bombsquad-server

RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_${BS_VERSION}.tar.gz --no-check-certificate -O /tmp/bombsquad-server.tar.gz && \
    tar -xvzf /tmp/bombsquad-server.tar.gz -C /tmp && \
    mv /tmp/BombSquad_Server*/** /usr/src/app/bombsquad-server && \
    rm -rf /tmp

CMD [ "/usr/src/app/bombsquad-server/bombsquad_server" ]

