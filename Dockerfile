# Copyright 2015-2019 Sean Nelson <audiohacked@gmail.com>

### Builder Image
FROM golang:latest AS builder
LABEL maintainer="Sean Nelson <audiohacked@gmail.com>"
ENV HCBIN="mchc"
WORKDIR /go/src/healthcheck
COPY healthcheck.go /go/src/healthcheck/main.go
RUN go get github.com/ldilley/minestat/Go/minestat
RUN go build -ldflags "-linkmode external -extldflags -static" -a -o ${HCBIN} /go/src/healthcheck/main.go

### Main Image
FROM openjdk:8-jre-alpine
LABEL maintainer="Sean Nelson <audiohacked@gmail.com>"

ENV SERVER_PORT="25565/tcp"
ENV RCON_PORT="25575/tcp"
ENV BASE_URL="https://ftb.forgecdn.net/FTB2/modpacks"

WORKDIR /minecraft/backups
WORKDIR /minecraft/world
WORKDIR /minecraft

RUN adduser -D minecraft
RUN apk --no-cache add wget

COPY --from=builder /go/src/healthcheck/${HCBIN} .
COPY --chown=minecraft:minecraft CheckEula.sh /minecraft/
RUN chmod u+x CheckEula.sh

RUN chown -R minecraft:minecraft /minecraft

WORKDIR /minecraft
USER minecraft

EXPOSE ${SERVER_PORT}
EXPOSE ${RCON_PORT}
HEALTHCHECK --interval=1m --start-period=5m CMD /minecraft/${HCBIN}
VOLUME ["/minecraft/world", "/minecraft/backups"]
ENTRYPOINT ["/bin/sh", "/minecraft/ServerStart.sh"]
