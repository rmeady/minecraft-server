#!/bin/sh
# Accept EULA
echo eula=true > eula.txt

java -Xms1G -Xmx1G -jar /usr/local/minecraft/minecraft_server.jar nogui