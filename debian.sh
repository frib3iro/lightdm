#!/usr/bin/env bash

# variaveis e password
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

echo -e "${seta} ${ciano}Habilitando os repositórios non-free e contrib${fim}"
sleep 2s
sudo sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
clear

# Atualizando os pacotes
echo -e "${seta} ${ciano}Atualizando...${fim}"
sleep 2s
sudo apt update && sudo apt upgrade -y
clear

# Instalando pacotes ----------------------------------------------------
echo -e "${seta} ${ciano}Instalando pacotes necessários${fim}"
sleep 2s
sudo apt install timeshift grub-customizer cmatrix dialog dosfstools efibootmgr git gedit gimp gnome-core gnupg gufw htop lolcat mtools neofetch os-prober pass rsync speedtest-cli totem ufw unrar xclip xdg-user-dirs xdg-utils youtube-dl vim xfce4-terminal wget -y
clear

# Desinstalando pacotes -------------------------------------------------
echo -e "${seta} ${vermelho}Desinstalando pacotes desnecessários${fim}"
sleep 2s
sudo apt remove firefox epiphany malcontent gnome-books gnome-maps gnome-boxes gnome-contacts gnome-music gnome-software gnome-terminal -y
clear

# Virt-manager ----------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o virt-manager${fim}"
sleep 2s
sudo apt install qemu virt-manager dnsmasq libvirt ebtables bridge-utils ovmf spice-vdagent -y
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y
sudo systemctl status libvirtd.service
sudo virsh net-list --all
sudo virsh net-start default
sudo virsh net-autostart default
sudo modprobe vhost_net
sudo adduser $user libvirt
sudo adduser $user libvirt-qemu
newgrp libvirt
newgrp libvirt-qemu
clear

# lollypop --------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o lollypop-stable-git${fim}"
sleep 2s
sudo apt install lollypop -y
clear

# Hackerman ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando aircrack-ng e utilitários${fim}"
sleep 2s
sudo apt install aircrack-ng usbutils tcpdump crunch -y
clear

# Gnome-terminal-transparency -------------------------------------------
echo -e "${seta} ${ciano}Instalando o gnome-terminal-transparency${fim}"
sleep 2s
clear

# Sardi-icons ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o sardi-icons${fim}"
sleep 2s
clear

# Ant-dracula-theme-git ------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o ant-dracula-theme-git${fim}"
sleep 2s
clear

# Google-chrome ---------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o google-chrome${fim}"
sleep 2s
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
clear

# Spotify ---------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando spotify${fim}"
sleep 2s
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
clear

# Fontes ----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando as fontes${fim}"
sleep 2s
sudo apt install ttf-mscorefonts-installer fonts-roboto ttf-ubuntu-font-family -y
clear

# xdg-user-dirs ---------------------------------------------------------
echo -e "${seta} ${ciano}Iniciando o xdg-update${fim}"
sleep 2s
xdg-user-dirs-update
clear

# Nvidia -----------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o driver da nvidia${fim}"
sleep 2s
sudo apt install nvidia-driver mesa-utils -y
clear

# Bluez -----------------------------------------------------------------
echo -e "${seta} ${ciano}Iniciando o bluez${fim}"
sleep 2s
sudo apt install bluez -y
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
clear

# GDM -------------------------------------------------------------------
echo -e "${seta} ${ciano}Instalando o gdm${fim}"
sleep 2s
sudo apt install gdm -y
sudo systemctl enable gdm
sudo systemctl start gdm
clear

