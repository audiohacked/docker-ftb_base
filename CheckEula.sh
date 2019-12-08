#!/bin/bash
if [ -a /minecraft/eula.txt ] && grep -qi true /minecraft/eula.txt && echo $EULA | grep -qi true ; then
    echo "EULA already accepted!"
elif  echo $EULA | grep -qi true ; then
    echo "EULA accepted by docker run -e"
    echo "# EULA accepted on $(date) by docker run -e" > /minecraft/eula.txt
    echo "eula=$EULA" >> /minecraft/eula.txt
else
    echo ""
    echo "Please accept the Minecraft EULA hosted at"
    echo "  https://account.mojang.com/documents/minecraft_eula"
    echo "by adding ' -e EULA=TRUE' after 'docker run'"
    echo ""
    > /minecraft/eula.txt
    exit 1
fi
