#!/usr/bin/env bash

# variaveis e password
pass_user='123'
vermelho='\033[0;31m'
verde='\033[0;32m'
amarelo='\033[0;33m'
ciano='\033[0;36m'
fim='\033[0m'
seta='\e[32;1m-->\e[m'

# Tela de boas vindas
clear
echo -e "${seta} ${ciano}Bem vindo a instalação do gnome${fim}"
sleep 2s
clear

# Atualizando os pacotes
echo -e "${seta} ${ciano}Atualizando...${fim}"
sleep 2s
echo $pass_user | sudo -S apt -y update
echo $pass_user | sudo -S apt -y upgrade
clear

# Instalando pacotes ----------------------------------------------------
echo -e "${seta} ${ciano}Instalando pacotes necessários${fim}"
sleep 2s
echo $pass_user | sudo -S apt install timeshift grub-customizer cmatrix dialog dosfstools efibootmgr git gedit gimp gnome gnupg gufw htop lolcat mtools neofetch os-prober pass rsync speedtest-cli totem ufw unrar xclip xcursor-vanilla-dmz-aa xdg-user-dirs xdg-utils xf86-input-synaptics youtube-dl pulseaudio pulseaudio-bluetooth vim xfce4-terminal wget -y
clear

# Desinstalando pacotes -------------------------------------------------
echo -e "${seta} ${vermelho}Desinstalando pacotes desnecessários${fim}"
sleep 2s
echo $pass_user | sudo -S apt remove epiphany malcontent gnome-books gnome-maps gnome-boxes gnome-contacts gnome-music gnome-software gnome-terminal -y
clear

# Virt-manager ----------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o virt-manager${fim}"
sleep 2s
echo $pass_user | sudo -S apt install qemu virt-manager dnsmasq libvirt ebtables bridge-utils ovmf spice-vdagent -y
clear

echo -e "${seta} ${ciano}Iniciando o daemon libvirt${fim}"
sleep 2s
echo $pass_user | sudo -S systemctl enable libvirtd.service
echo $pass_user | sudo -S systemctl start libvirtd.service
clear

echo -e "${seta} ${ciano}Inserindo o usuário no grupo libvirt${fim}"
sleep 2s
echo $pass_user | sudo -S usermod -aG libvirt $user
clear

echo -e "${seta} ${ciano}Configurando a network do virt-manager para iniciar automáticamente${fim}"
sleep 2s
echo $pass_user | sudo -S virsh net-autostart --network default
clear

# lollypop-stable-git --------------------------------------------------
echo -e "${seta} ${ciano}Instalando o lollypop-stable-git${fim}"
sleep 2s
apt install lollypop-stable-git kid3-cli -y
clear

# Hackerman ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando aircrack-ng e usbutils${fim}"
sleep 2s
echo $pass_user | sudo -S apt install aircrack-ng usbutils tcpdump -y
clear

echo -e "${seta} ${ciano}Instalando o crunch${fim}"
sleep 2s
apt install crunch -y
clear

# Gnome-terminal-transparency -------------------------------------------
echo -e "${seta} ${ciano}Instalando o gnome-terminal-transparency${fim}"
sleep 2s
apt install gnome-terminal-transparency -y
clear

# Mint-icons ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o mint-icons${fim}"
sleep 2s
apt install mint-y-icons -y
clear

# Sardi-icons ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o sardi-icons${fim}"
sleep 2s
apt install sardi-icons -y
clear

# Ant-dracula-theme-git ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o ant-dracula-theme-git${fim}"
sleep 2s
apt install ant-dracula-theme-git -y
clear

# Glxinfo ----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o glxinfo${fim}"
sleep 2s
apt install glxinfo -y
clear

# Google-chrome ---------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o google-chrome${fim}"
sleep 2s
apt install google-chrome -y
clear

# Spotify ---------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando spotify${fim}"
sleep 2s
apt install spotify -y
clear

# Fontes ----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando as fontes${fim}"
sleep 2s
apt install ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family -y
clear

# xdg-user-dirs ---------------------------------------------------------
echo -e "${seta} ${ciano}Iniciando o xdg-update${fim}"
sleep 2s
xdg-user-dirs-update
clear

# Nvidia -----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o driver da nvidia${fim}"
sleep 2s
echo $pass_user | sudo -S apt install nvidia-driver mesa-utils -y
clear

# Bluez -----------------------------------------------------------------
echo -e "${seta} ${ciano}Iniciando o bluez${fim}"
sleep 2s
echo $pass_user | sudo -S apt install bluez -y
echo $pass_user | sudo -S systemctl enable bluetooth
echo $pass_user | sudo -S systemctl start bluetooth
clear

# GDM -------------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o gdm${fim}"
sleep 2s
echo $pass_user | sudo -S apt install gdm -y
echo $pass_user | sudo -S systemctl enable gdm
echo $pass_user | sudo -S systemctl start gdm
clear

