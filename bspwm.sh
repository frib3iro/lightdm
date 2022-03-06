#!/usr/bin/env bash
# --------------------------------------------------------------------------
# Licença : GNU/GPL v3.0
# Script : [bspwm.sh]
# Descrição :
# Versão : 0.1
# Autor : Fabio Junior Ribeiro <rib3iro@live.com>
# Data : 08/12/2020
# Licença : GNU/GPL v3.0
# --------------------------------------------------------------------------
# Uso :
# --------------------------------------------------------------------------
clear

# variaveis e password
pass_user='2002'
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
C='\033[0;36m'
F='\033[0m'
S='\e[32;1m-->\e[m'
# --------------------------------------------------------------------------
clear

# Tela de boas vindas
echo -e "${S} ${C}Bem vindo a instalação do bspwm${F}"
sleep 1s
clear

# Atualizando os espelhos
echo -e "${S} ${C}Atualizando...${F}"
sleep 1s
echo $pass_user | sudo -S pacman -Syu --noconfirm
clear

# Instalando pacotes ----------------------------------------------------
echo -e "${S} ${C}Instalando pacotes necessários${F}"
sleep 1s
echo $pass_user | sudo -S pacman -S xorg-server xorg-xinit xf86-video-qxl bspwm sxhkd rofi feh compton xfce4-terminal firefox firefox-i18n-pt-br arandr nautilus --noconfirm
clear

echo -e "${S} ${C}Configurando o bspwm${F}"
sleep 1s

mkdir -p ~/.config/{bspwm,sxhkd,polybar}
sleep 1s

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
sleep 1s
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
sleep 1s

cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
sleep 1s

cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
sleep 1s

sed -i 's/urxvt/xfce4-terminal/g' ~/.config/sxhkd/sxhkdrc
sleep 1s

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sleep 1s

echo "setxkbmap br &" >> ~/.xinitrc
echo "picom -f &" >> ~/.xinitrc
echo "exec bspwm" >> ~/.xinitrc

sleep 1s

# sed -i 's/vsync = true/# vsync = true/g' /etc/xdg/picom.conf
# sed -i 's/# vsync = false/vsync = false/g' /etc/xdg/picom.conf

vim .xinitrc
sleep 1s

echo -e "${S} ${C}Iniciando o xdg-update...${F}"
xdg-user-dirs-update
sleep 1s
#------------------------------------------------------------------------------------

echo -e "${S} ${C}Instalação e configuração finalizada...${F}"
