FROM alpine
MAINTAINER Ryan Eady
ARG MC_VERSION=1.11.2
RUN apk update
RUN apk add openjdk8-jre-base openssl bash
RUN mkdir -p /usr/local/minecraft/world
RUN mkdir -p /usr/local/minecraft/bin
ADD start.sh /usr/local/minecraft/bin
RUN chown root:root -R /usr/local/minecraft
run chmod +x /usr/local/minecraft/bin/start.sh
RUN wget -q https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar -O /usr/local/minecraft/minecraft_server.jar
EXPOSE 25565 25565
WORKDIR /usr/local/minecraft
# VOLUME world
ENTRYPOINT bin/start.sh