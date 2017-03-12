FROM centos:7
MAINTAINER Ryan Eady
ARG MC_VERSION=1.11.2
ARG MC_PORT=25565
RUN yum -y update
RUN yum -y install java-1.7.0-openjdk openssl bash screen wget vim
RUN mkdir -p /usr/local/minecraft/world
RUN mkdir -p /usr/local/minecraft/bin
ADD start.sh /usr/local/minecraft/bin
ADD manage.sh /usr/local/minecraft/bin
RUN chown root:root -R /usr/local/minecraft
RUN chmod +x -R /usr/local/minecraft/bin
RUN wget -q https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar -O /usr/local/minecraft/minecraft_server.jar
EXPOSE ${MC_PORT}
COPY world/ /usr/local/minecraft/world
WORKDIR /usr/local/minecraft
ENTRYPOINT bin/start.sh