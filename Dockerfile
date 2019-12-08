# Copyright 2015-2019 Sean Nelson <audiohacked@gmail.com>
FROM openjdk:8-jre-alpine
LABEL maintainer="audiohacked@gmail.com"

ENV SERVER_PORT="25565/tcp"

WORKDIR /minecraft
USER root
RUN adduser -D minecraft
RUN apk --no-cache add wget
RUN chown -R minecraft:minecraft /minecraft
# RUN mkdir -p /minecraft/world
ADD --chown=minecraft:minecraft CheckEula.sh /minecraft/
RUN chmod u+x CheckEula.sh

EXPOSE ${SERVER_PORT}
VOLUME ["/minecraft/world", "/minecraft/backups"]
ENTRYPOINT ["/bin/sh", "/minecraft/ServerStart.sh"]
# CMD ["-"]
