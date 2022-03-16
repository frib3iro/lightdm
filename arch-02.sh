#!/usr/bin/env bash
# --------------------------------------------------------------
# Script    : [install-02.sh]
# Descrição : Script para instalação do arch linux no modo UEFI
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 11/12/2020
# Licença   : GNU/GPL v3.0
# --------------------------------------------------------------
# Uso       : Instala automático após instalar o script ./install-01.sh
# --------------------------------------------------------------

source variaveis.sh
source funcoes.sh

# --------------------------------------------------------------

clear

echo -e "${S} ${B}Bem vindo a segunda parte da instalação do ArchLinux BIOS/MBR${F}"
sleep 2s

# Ajustando o fuso horário
echo
echo -e "${S} ${B}Ajustando o fuso horário${F}"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Executando hwclock
echo
echo -e "${S} ${B}Executando o hwclock${F}"
hwclock --systohc

# Definindo o idioma
echo
echo -e "${S} ${B}Definindo o idioma${F}"
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen

# Criando o arquivo locale.conf
echo
echo -e "${S} ${B}Criando o arquivo locale.conf${F}"
echo LANG=pt_BR.UTF-8 > /etc/locale.conf

# Exportando a variável LANG
echo
echo -e "${S} ${B}Exportando a variável LANG${F}"
export LANG=pt_BR.UTF-8

# Atualizando o relógio do sistema
echo
echo -e "${S} ${B}Atualizando o relógio do sistema${F}"
timedatectl set-ntp true

# Criando o arquivo vconsole.conf
echo
echo -e "${S} ${B}Criando o arquivo vconsole.conf${F}"
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
echo FONT=ter-120n >> /etc/vconsole.conf

# Criando o hostname
echo
echo -e "${S} ${B}Criando o hostname${F}"
echo archlinux > /etc/hostname

# Configurando o hosts
echo
echo -e "${S} ${B}Configurando o arquivo hosts${F}"
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain localhost
::1         localhost.localdomain localhost
127.0.1.1   archlinux.localdomain archlinux
EOF

# Initramfs
echo
echo -e "${S} ${B}Criando um novo initramfs${F}"
mkinitcpio -P

# Criando senha de root
echo
echo -e "${S} ${B}Criando a senha do root${F}"
echo
senharoot

# Baixando o Gerenciador de boot
echo
echo -e "${S} ${B}Baixando o Gerenciador de boot e mais alguns pacotes${F}"
pacman -S dialog dosfstools efibootmgr git grub linux-headers mtools networkmanager network-manager-applet wireless_tools wpa_supplicant nm-connection-editor pulseaudio pavucontrol terminus-font vim wget os-prober bluez bluez-utils cups xdg-utils xdg-user-dirs --noconfirm

# Instalando o grub
echo
echo -e "${S} ${B}Instalando o grub${F}"
grub-install --target=i386-pc /dev/vda

# Configurando o grub
echo                                                    
echo -e "${S} ${B}Configurando o grub${F}"
grub-mkconfig -o /boot/grub/grub.cfg

# Iniciando o bluez e o cups
echo
echo -e "${S} ${B}Iniciando os Serviços do bluez e do cups${F}"
systemctl enable bluetooth
systemctl enable org.cups.cupsd

# Iniciando o NetworkManager
echo
echo -e "${S} ${B}Iniciando os Serviços NetworkManager${F}"
systemctl enable NetworkManager
systemctl start NetworkManager

# Criando usuario e senha
echo
echo -e "${S} ${B}Criando usuário e senha${F}"
echo
usuario
echo
senhauser

# Adicionando user no grupo sudoers
echo
echo -e "${S} ${B}Adicionando o $usuario no grupo sudoers${F}"
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Colorindo a sída do pacman
echo
echo -e "${S} ${B}Colorindo a saída do pacman${F}"
sed -i 's/#Color/Color/' /etc/pacman.conf

echo -e "${S} ${B}Baixando o drive de vídeo${F}"
pacman -S xf86-video-qxl --noconfirm

# Reiniciando
echo
echo -e "${S} ${G}Instalação finalizada!${F}"
exit

