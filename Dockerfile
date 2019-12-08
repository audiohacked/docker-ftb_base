# Copyright 2015-2019 Sean Nelson <audiohacked@gmail.com>
FROM openjdk:8-jre-alpine
LABEL maintainer="Sean Nelson <audiohacked@gmail.com>"

ENV SERVER_PORT="25565/tcp"
ENV BASE_URL="https://ftb.forgecdn.net/FTB2/modpacks"

WORKDIR /minecraft/backups
WORKDIR /minecraft/world
WORKDIR /minecraft

RUN adduser -D minecraft
RUN apk --no-cache add wget

COPY --chown=minecraft:minecraft CheckEula.sh /minecraft/
RUN chmod u+x CheckEula.sh

RUN chown -R minecraft:minecraft /minecraft

WORKDIR /minecraft
USER minecraft

EXPOSE ${SERVER_PORT}
VOLUME ["/minecraft/world", "/minecraft/backups"]
ENTRYPOINT ["/bin/sh", "/minecraft/ServerStart.sh"]
