#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script    : [install-02.sh]
# Descrição : Script para instalação do arch linux no modo UEFI
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro
# Email     : rib3iro@live.com
# Data      : 11/12/2020
# Licença   : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso       : Instala automático após instalar o script ./install-01.sh
#----------------------------------------------------------------------
# variaveis 
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
C='\033[0;36m'
F='\033[0m'
S='\e[32;1m[+]\e[m'

# Funções --------------------------------------------------------
# Adicionando a senha de root
senharoot(){
    echo -en "${S} ${C}Digite uma senha para o root: ${F}"
    read -s passroot1; echo
    echo -en "${S} ${C}Repita a senha: ${F}"
    read -s passroot2; echo
    if [[ $passroot1 -eq $passroot2 ]]
    then
        echo "root:$passroot1" | chpasswd
    else
        clear
        echo -e "${S} ${R}As senhas nao correspondem!${F}"
        senharoot
    fi
}

# Adicionando um usuario
usuario(){
    echo -en "${S} ${C}Adicionando um usuário${F}"
    echo
    echo -en "${S} ${C}Digite um nome para o usuário: ${F}"
    read usuario
    useradd -m -G wheel $usuario
}

# Criando a senha de usuario
senhauser(){
    echo -en "${S} ${C}Digite uma senha: ${F}"
    read -s passuser1; echo
    echo -en "${S} ${C}Repita a senha: ${F}"
    read -s passuser2; echo
    if [[ $passuser1 -eq $passuser2 ]]
    then
        echo "$usuario:$passuser1" | chpasswd
    else
        clear
        echo -e "${S} ${R}As senhas nao correspondem!${F}"
        senhauser
    fi   
}
#----------------------------------------------------------------------

clear
echo -e "${S} ${C}Bem vindo a segunda parte da instalação do Arch Linux UEFI${F}"
sleep 3s

# Ajustando o fuso horário
echo
echo -e "${S} ${C}Ajustando o fuso horário${F}"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Executando hwclock
echo
echo -e "${S} ${C}Executando o hwclock${F}"
hwclock --systohc

# Definindo o idioma
echo
echo -e "${S} ${C}Definindo o idioma${F}"
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
locale-gen

# Criando o arquivo locale.conf
echo
echo -e "${S} ${C}Criando o arquivo locale.conf${F}"
echo LANG=pt_BR.UTF-8 > /etc/locale.conf

# Exportando a variável LANG
echo
echo -e "${S} ${C}Exportando a variável LANG${F}"
export LANG=pt_BR.UTF-8

# Atualizando o relógio do sistema
echo
echo -e "${S} ${C}Atualizando o relógio do sistema${F}"
timedatectl set-ntp true

# Criando o arquivo vconsole.conf
echo
echo -e "${S} ${C}Criando o arquivo vconsole.conf${F}"
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
echo FONT=ter-120n >> /etc/vconsole.conf

# Criando o hostname
echo
echo -e "${S} ${C}Criando o hostname${F}"
echo archlinux > /etc/hostname

# Configurando o hosts
echo
echo -e "${S} ${C}Configurando o arquivo hosts${F}"
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain localhost
::1         localhost.localdomain localhost
127.0.1.1   archlinux.localdomain archlinux
EOF

# Initramfs
echo
echo -e "${S} ${C}Criando um novo initramfs${F}"
mkinitcpio -P

# Criando senha de root
echo
echo -e "${S} ${C}Criando a senha do root${F}"
echo
senharoot

# Baixando o Gerenciador de boot
echo
echo -e "${S} ${C}Baixando o Gerenciador de boot e mais alguns pacotes${F}"
pacman -S dialog dosfstools efibootmgr git grub linux-headers mtools networkmanager nm-connection-editor pulseaudio pavucontrol terminus-font vim wget os-prober --noconfirm

# Instalando o grub
echo
echo -e "${S} ${C}Instalando o grub${F}"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

# Configurando o grub
echo                                                    
echo -e "${S} ${C}Configurando o grub${F}"
grub-mkconfig -o /boot/grub/grub.cfg

# Iniciando o NetworkManager
echo
echo -e "${S} ${C}Iniciando os Serviços NetworkManager${F}"
systemctl enable NetworkManager
systemctl start NetworkManager

# Criando usuario e senha
echo
echo -e "${S} ${C}Criando usuário e senha${F}"
echo
usuario
senhauser

# Adicionando user no grupo sudoers
echo
echo -e "${S} ${C}Adicionando o $usuario no grupo sudoers${F}"
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Colorindo a sída do pacman
echo
echo -e "${S} ${C}Colorindo a saída do pacman${F}"
sed -i 's/#Color/Color/' /etc/pacman.conf

echo -e "${S} ${C}Baixando o drive de vídeo${F}"
pacman -S xf86-video-qxl --noconfirm

# Reiniciando
echo
echo -e "${S} ${R}Instalação finalizada!${F}"
exit

