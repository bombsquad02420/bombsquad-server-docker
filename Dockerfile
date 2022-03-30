FROM ubuntu:latest

ARG BS_VERSION

EXPOSE 43210/udp

RUN apt-get update

RUN apt-get install --no-install-recommends -y \
      wget \
      python3.9 \
      libpython3.9

WORKDIR /usr/src/app/bombsquad-server

COPY ./downloads/linux/x86_64/bombsquad-server.tar.gz /tmp/bombsquad-server.tar.gz

RUN tar -xvzf /tmp/bombsquad-server.tar.gz -C /tmp && \
    mv /tmp/BombSquad_Server*/** /usr/src/app/bombsquad-server && \
    rm -rf /tmp

CMD [ "/usr/src/app/bombsquad-server/bombsquad_server" ]

