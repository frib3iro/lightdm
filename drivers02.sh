#!/usr/bin/env bash

# variaveis e password root/user
ciano='\033[0;36m'
verde='\033[0;32m'
vermelho='\033[0;31m'
amarelo='\033[0;32m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

clear
echo -e "${seta} ${ciano}Bem vindo a segunda parte da correção dos drivers de vídeo nvídia${fim}"
sleep 2s
clear

# Removendo os drivers nvidia
echo -e "${seta} ${ciano}Removendo os drivers nvidia${fim}"
sleep 2s
#sudo pacman -R nvidia nvidia-utils nvidia-settings
sudo yay -R nvidia-390xx-dkms
clear

# Reiniciando
echo -e "${seta} ${ciano}Reinicie o sistema para continuar com a terceira parte${fim}"
sleep 2s
exit 

