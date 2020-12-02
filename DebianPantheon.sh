#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script    : DebianPantheon.sh
# Descrição : Instalando o Pantheon no Debian 10
# Versão    : 0.1
# Autor     : Fabio Junior Ribeiro <rib3iro@live.com>
# Data      : 02/12/2020
# Licença   : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso       : Apenas execute com ./DebianPantheon.sh
#----------------------------------------------------------------------
# variaveis e password
pass_user='123'
vermelho='\033[0;31m'
verde='\033[0;32m'
amarelo='\033[0;33m'
ciano='\033[0;36m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

## Tela de boas vindas
clear
echo -e "${seta} ${ciano}Instalando o Pantheon no Debian 10${fim}"
sleep 2s
clear

## Contents
## 1. Software Requirements and Conventions Used
## 2. How to Install the Required Dependencies
## 3. How to Download and Install The Repository
## 4. How to Install Pantheon
## 5. How to Install Pantheon Extras
## 6. Conclusion

echo -e "${seta} ${ciano}Antes de configurar o repositório Pantheon no Debian, você precisará de algumas dependências.${fim}"
sleep 2s
sudo apt install apt-transport-https software-properties-common wget -y
clear

echo -e "${seta} ${ciano}Baixar e instalar o repositório${fim}"
sleep 2
wget https://gandalfn.ovh/debian/pool/main/p/pantheon-debian-repos/pantheon-debian-repos_0.4-0+pantheon+stretch+loki1_all.deb
clear

echo -e "${seta} ${ciano}Em seguida, instale o pacote com dpkg${fim}"
sleep 2
sudo dpkg -i pantheon-debian-repos_0.4-0+pantheon+stretch+loki1_all.deb -y
clear

echo -e "${seta} ${ciano}Atualize o Apt para incluir o novo repositório${fim}"
sleep 2
sudo apt update
clear

echo -e "${seta} ${ciano}Instalar o Pantheon${fim}"
sleep 2
sudo apt install pantheon -y
clear

echo -e "${seta} ${ciano}Instalar o Pantheon Extras${fim}"
sleep 2
sudo apt install elementary-tweaks indicator-application indicator-systemtray-unity indicator-multiload -y
clear

echo -e "${seta} ${verde}Instalação finalizada!${fim}"
