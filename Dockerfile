# Copyright 2015-2019 Sean Nelson <audiohacked@gmail.com>
FROM openjdk:8-jre-alpine
LABEL maintainer="Sean Nelson <audiohacked@gmail.com>"

ENV SERVER_PORT="25565/tcp"
ENV BASE_URL="https://ftb.forgecdn.net/FTB2/modpacks/${MODPACK}"

WORKDIR /minecraft
WORKDIR /minecraft/backups
WORKDIR /minecraft/world
WORKDIR /minecraft

RUN adduser -D minecraft
RUN apk --no-cache add wget

ADD --chown=minecraft:minecraft CheckEula.sh /minecraft/
RUN chmod u+x CheckEula.sh

RUN chown -R minecraft:minecraft /minecraft

WORKDIR /minecraft
USER minecraft

EXPOSE ${SERVER_PORT}
VOLUME ["/minecraft/world", "/minecraft/backups"]
ENTRYPOINT ["/bin/sh", "/minecraft/ServerStart.sh"]

# FROM openjdk:8-jre-alpine
# LABEL maintainer="Sean Nelson <audiohacked@gmail.com>"
# ADD --chown=minecraft ${BASE_URL}/${FTB_VERSION}/${SERVER_FILE} .
# RUN unzip ${SERVER_FILE}
# RUN sed -i '2i /bin/sh /minecraft/CheckEula.sh' /minecraft/ServerStart.sh
# RUN chmod u+x FTBInstall.sh ServerStart.sh
# RUN /minecraft/FTBInstall.sh

