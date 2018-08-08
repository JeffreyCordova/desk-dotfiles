#!/bin/sh

timedatectl set-ntp true

mount /dev/sda5 /mnt
mount /dev/sda2 /mnt/boot

cd /mnt/boot
rm vmlinuz-linux intel-ucode initramfs-linux.img initramfs-linux-fallback.img
rm -rf loader EFI/refind EFI/systemd
cd ..
umount /mnt/boot
rm -rf *
cd ~
umount /mnt

mkfs.ext4 /dev/sda5
mkswap /dev/sda6
swapon /dev/sda6

mount /dev/sda5 /mnt
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot

pacman -Syy
pacman -S --noconfirm reflector
reflector --verbose --protocol https --latest 200 --sort rate --save /etc/pacman.d/mirrorlist

pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/master/install/chroot.sh
chmod +x chroot.sh

cp chroot.sh /mnt/
arch-chroot /mnt ./chroot.sh
rm chroot.sh /mnt/chroot.sh
