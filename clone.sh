#!/bin/sh

echo "Cloning repositories..."

CODE=$HOME/Code

# Fonts
git clone https://github.com/powerline/fonts.git $CODE/PowerlineFonts --depth=1 
.$CODE/PowerlineFonts/install.sh 

# Window Manager
# Slate: Old window manager for older devices
cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz
cd -

# Personal
git clone git@github.com:madebyjoe/Git-Test-Hub.git $CODE/GitTestHub

# Gitea
# TODO