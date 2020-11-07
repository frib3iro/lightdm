#!/usr/bin/env bash

# variaveis e password root/user
ciano='\033[0;36m'
verde='\033[0;32m'
vermelho='\033[0;31m'
amarelo='\033[0;32m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

clear
echo -e "${seta} ${ciano}Modificando a fonte do terminal${fim}"
sleep 2s
setfont ter-132n
clear

# Tela de boas vindas
clear
echo -e "${seta} ${ciano}Bem vindo a correção de drivers de vídeo do Arch Linux${fim}"
sleep 2s
clear

# Listando os discos
echo -e "${seta} ${ciano}Listando os discos${fim}"
sleep 2s
lsblk -l | grep disk

# Informando o nome do seu disco
echo -en "\n${seta} ${ciano}Informe o nome do seu disco:${fim} "
read disco
disco=/dev/${disco}
clear

# Montando partições
echo -e "${seta} ${ciano}Montando as partições${fim}"
sleep 2s
mount ${disco}2 /mnt
# mount ${disco}1 /mnt/boot/efi
clear

# Listando partições
echo -e "${seta} ${ciano}Conferindo as partições${fim}"
lsblk ${disco}
sleep 3s
clear

# Copiando o script drivers02.sh para /mnt
echo -e "${seta} ${ciano}Copiando o script drivers02.sh para /mnt${fim}"
sleep 2s
cp driver02.sh /mnt
clear

# Iniciando arch-chroot
echo -e "${seta} ${ciano}Iniciando arch-chroot${fim}"
sleep 2s
arch-chroot /mnt ./driver02.sh

