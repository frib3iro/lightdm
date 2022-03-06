#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script        : [gnome.sh]
# Descrição     : Script para instalação do gnome e apps nescessários
# Versão        : 1.0
# Autor         : Fabio Junior Ribeiro
# Email         : rib3iro@live.com
# Data          : 11/12/2020
# Licença       : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso           : ./gnome
#----------------------------------------------------------------------
# Cores usadas no script
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
C='\033[0;36m'
F='\033[0m'
S='\e[32;1m[+]\e[m'
#----------------------------------------------------------------------
clear
# Tela de boas vindas
echo -e "${S} ${C}Bem vindo a instalação do gnome!${F}"

# Atualizando os espelhos
echo
echo -e "${S} ${C}Atualizando...${F}"
sudo pacman -Syu --noconfirm

# Lista de pacotes para instalar com o pacman
listapacman=(arc-gtk-theme arch-wiki-docs arch-wiki-lite alsa-utils dconf-editor gnome-passwordsafe gnome-sound-recorder gparted grub-customizer archlinux-keyring archlinux-wallpaper bash-completion bluez bluez-utils chrome-gnome-shell cmatrix cronie cups dialog dosfstools efibootmgr git gedit-plugins gimp gnome-tweaks gnupg gst-libav gufw htop libreoffice libreoffice-fresh-pt-br lolcat man-db man-pages-pt_br mesa-demos mtools neofetch os-prober pass rsync qbittorrent speedtest-cli ufw unrar xclip xcursor-vanilla-dmz-aa xdg-utils youtube-dl pulseaudio pulseaudio-bluetooth lollypop aircrack-ng usbutils tcpdump wifite ttf-fantasque-sans-mono ttf-jetbrains-mono ttf-dejavu ttf-hack gnome-desktop)

# Lista de pacotes para instalar com o yay
listayay=(aic94xx-firmware consolas-font brave-bin wd719x-firmware upd72020x-fw mintstick downgrade timeshift crunch gnome-terminal-transparency cava ventoy-bin mint-y-icons sardi-icons ant-dracula-theme-git debtap spotify ttf-ms-fonts ttf-roboto ttf-ubuntu-font-family onedriver)

# Instalando pacotes do gnome
listagnome=(baobab cheese eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-control-center gnome-disk-utility gnome-documents gnome-font-viewer gnome-getting-started-docs gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-themes-extra gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mutter nautilus networkmanager orca rygel sushi totem tracker tracker-miners tracker3 tracker3-miners vino xdg-user-dirs-gtk yelp simple-scan)

# Instalando o yay
echo
echo -e "${S} ${C}Instalando o yay......${F}"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo
echo -e "${S} ${C}Instalando pacotes com pacman...${F}"
for i in ${listapacman[@]}
do
    echo -e "${S} ${Y}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

echo
echo -e "${S} ${C}Instalando pacotes com yay...${F}"
for i in ${listayay[@]}
do
    echo -e "${S} ${Y}Instalando o pacote $i ${F}"
    yay -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

echo
echo -e "${S} ${C}Instalando pacotes do gnome...${F}"
for i in ${listagnome[@]}
do
    echo -e "${S} ${Y}Instalando o pacote $i ${F}"
    sudo pacman -S $i --noconfirm
    echo -e "${S} ${G}Pacote $i instalado com sucesso!!${F}"
    echo
done

# Tema dracula no gedit
echo
echo -e "${S} ${C}Baixando e instalando o tema Dracula no gedit...${F}"
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
if [ -d "/home/fabio/.local/share/gedit/styles" ]
then
    mv dracula.xml /home/fabio/.local/share/gedit/styles/
else
    mkdir -p /home/fabio/.local/share/gedit/styles
    mv dracula.xml /home/fabio/.local/share/gedit/styles/
fi  
echo
echo -e "${S} ${G}Tema instalado com sucesso!...${F}"

# xdg-user-dirs
echo
echo -e "${S} ${C}Iniciando o xdg-update...${F}"
xdg-user-dirs-update

# Bluez
echo
echo -e "${S} ${C}Iniciando o bluez...${F}"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable org.cups.cupsd

# Gnome Display Manager
echo
echo -e "${S} ${C}Instalando o Gnome Display Manager...${F}"
sudo systemctl enable gdm.service
sudo systemctl start gdm.service

