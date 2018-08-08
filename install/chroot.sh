#!/bin/sh

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
sed -i '0,/en_US.UTF-8/! {/en_US.UTF-8/ s/^#//}' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

echo c137 > /etc/hostname
echo "127.0.1.1\tc137.localdomain\tc137" >> /etc/hosts

systemctl enable dhcpcd

pacman -S --noconfirm refind-efi intel-ucode
bootctl --path=/boot install

sed -i '/Color/s/^#//' /etc/pacman.conf
sed -i '/\[multilib\]/,+1 s/^#//' /etc/pacman.conf
pacman -Syy

pacman -S --noconfirm git

passwd

useradd -m -G wheel -s /bin/bash jeff
passwd jeff

echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

exit
