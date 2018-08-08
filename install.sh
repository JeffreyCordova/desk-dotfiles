#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

sudo refind-install
sudo cp -r refind/EFI/* /boot/

sudo pacman -S --noconfirm reflector
sudo reflector --verbose --protocol https \
                         -l 200 \
                         --sort rate \
                         --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

git clone https://aur.archlinux.org/trizen
cd trizen
makepkg -sri
cd ..
rm -rf trizen

gpg --recv-keys 1EB2638FF56C0C53
gpg --recv-keys DBE7D3DD8C81D58D0A13D0E76BC26A17B9B7018A

sudo pacman -S --noconfirm $(cat deps/official.lst)
trizen -S --needed --noconfirm $(cat deps/aur.lst)

chsh -s /usr/bin/zsh

# stow
PKGS=( bspwm compton dunst git gtk julia npm nvim polybar profile resources rofi \
    scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

sudo npm install -g neovim

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/illinoisjackson/even-better-ls/master/install.sh)"
#rm -rf coreutils-8.2
