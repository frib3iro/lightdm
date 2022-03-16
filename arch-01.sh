#!/usr/bin/env bash
#---------------------------------------------------------------
# Script    : [install-01.sh]
# Descrição : Script para instalação do arch linux no modo UEFI
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 11/12/2020
# Licença   : GNU/GPL v3.0
#---------------------------------------------------------------
# Uso       : ./install-01.sh
#---------------------------------------------------------------

source variaveis.sh
source funcoes.sh

#---------------------------------------------------------------

clear

# Tela de boas vindas
echo -e "${S} ${B}Bem vindo a primeira parte da instalação do Arch Linux BIOS/MBR${F}"

# Definir a fonte do ambiente live
echo
echo -e "${S} ${B}Definir a fonte do ambiente live${F}"
setfont ter-120n

# Definir o idioma do ambiente live
echo
echo -e "${S} ${B}Definir o idioma do ambiente live${F}"
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen
export LANG=pt_BR.UTF-8

# Atualizar o relógio do sistema
echo
echo -e "${S} ${B}Atualizar o relógio do sistema${F}"
timedatectl set-ntp true

# Listando os discos
echo
echo -e "${S} ${B}Listando os discos${F}"
lsblk -l | grep disk

# Informando o nome do seu disco
echo
echo -en "${S} ${B}Informe o nome do seu disco:${F} "
read disco
disco=/dev/${disco}

echo
echo -e "${S} ${B}Iniciando particionamento do disco${F}"
(echo d; echo ""; echo n; echo ""; echo "p"; echo ""; echo ""; echo ""; echo +2G; echo ""; echo "t"; echo ""; echo "82"; echo ""; echo "n"; echo ""; echo "p"; echo ""; echo ""; echo ""; echo ""; echo "w"; echo "") | fdisk ${disco}

# Listando partições
echo
echo -e "${S} ${B}Conferindo as partições${F}"
lsblk ${disco}
echo -e "${S} ${Y}Aperte enter para continuar${F}"
read

# Formatando a partição swap
echo
echo -e "${S} ${B}Formatando a partição swap${F}"
mkswap ${disco}1
swapon ${disco}1

# Formatando partições
echo
echo -e "${S} ${B}Formatando a partição root${F}"
mkfs.ext4 ${disco}2

# Montando partições
echo
echo -e "${S} ${B}Montando as partições${F}"
mount ${disco}2 /mnt

# Listando partições
echo
echo -e "${S} ${B}Conferindo as partições${F}"
lsblk ${disco}
echo -e "${S} ${Y}Aperte enter para continuar${F}"
read

# Instalando os pacotes base
echo
echo -e "${S} ${B}Instalando os pacotes base${F}"
pacstrap /mnt base base-devel linux linux-firmware

# Gerando o arquivo fstab
echo
echo -e "${S} ${B}Gerando o arquivo fstab${F}"
genfstab -U /mnt >> /mnt/etc/fstab

# Conferindo o arquivo fstab
echo
echo -e "${S} ${B}Conferindo o arquivo fstab${F}"
cat /mnt/etc/fstab
echo -e "${S} ${Y}Aperte enter para continuar${F}"
read

# Copiando o script archinstall-02.sh para /mnt
echo
echo -e "${S} ${B}Copiando o script install-02.sh para /mnt${F}"
cp arch-02.sh variaveis.sh funcoes.sh /mnt


# Iniciando arch-chroot
echo
echo -e "${S} ${B}Iniciando arch-chroot${F}"
arch-chroot /mnt ./arch-02.sh

