---
title: "Gentoo basic installation"
date: 2023-11-29T08:39:16-03:00
tags: ['gentoo','install']
categories: ['linux','installation']
---
Tiene que ser más grande que 5 gb la partición root
Crea una particion de efi de por lo menos 300 megas, otra de swap de 4gb, y el espacio que sobra para ext4

Si no lo quieren hacer con cfdisk lo pueden hacer con fdisk de la siguiente manera:

### Particionamiento
### bios legacy
```console
o (gpt disk label)
n
p
1 (partition number [1/128])
2048 first sector
+1G last sector (boot sector size)
t
swap (EFI System)
n
p
2
default (fill up partition)
default (fill up partition)
w (write)
```


#### uefi (gpt)
```bash
g (gpt disk label)
n
1 (partition number [1/128])
2048 first sector
+300M last sector (boot sector size)
t
1 (EFI System)
n
p
2
default
+4G
t
2
swap
n
p
3
default (fill up partition)
default (fill up partition)
w (write)
```

### Instalación
```console
mkfs.ext4 /dev/sda3 (root partition)
mkswap /dev/sda2 (swap partition)

mount /dev/sda3 /mnt/gentoo (no lo montes en /mnt o se romperá todo tu sistema)
swapon /dev/sda2 (swap_partition)
cd /mnt/gentoo
links gentoo.org/downloads/mirrors/
Public Mirrors -> releases -> amd64 -> autobuils -> stage3-amd64-musl.tar.xz -> download and save
exit links
tar xvf stage3-amd64-musl.tar.xz
mount -t proc none proc
mount --rbind /dev dev
mount --rbind /sys sys
mount --rbind /run run
cp -L /etc/resolv.conf etc/
chroot . /bin/bash -l
nano /etc/portage/make.conf
MAKEOPTS="-j8"

emerge-webrsync
emerge gentoo-kernel-bin grub neofetch
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
passwd
exit
reboot

```
Done


#### Instalacion de Gentoo de DenshiVideo

https://m.youtube.com/watch?v=J7W9MItUSGw

cfdisk /dev/sda

Ya expliqué  la diferencia entre gpt o dos en el tutorial de archlinux.

Creá 3 particiones 100M, la mitad de tu RAM para el swap, y la otra partición con lo que sobra.

Verificá que se hizo bien con: lsblk
```bash
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkdir /mnt/gentoo
mount /dev/sda3 /mnt/gentoo
cd /mnt/gentoo
```

https://www.gentoo.org/downloads/

Elegí stage3 (openrc o systemd)

```bash
wget https://distfiles.gentoo.org/releases/amd64/autobuilds/20240811T170405Z/stage3-amd64-openrc-20240811T170405Z.tar.xz
tar xpvf stage3*.tar.xz --xattrs-include='*.*' --numeric-owner 
vim /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j5"
## Busca los mirrors en Downloads(gentoo)
GENTOO_MIRRORS="https://ftp.linux.org.tr/gentoo/"
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
mount --types proc /proc /mnt/gentoo/proc/
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev/
mount --make-rslave /mnt/gentoo/dev/
### Cuando usas un medio de instalación que no es Gentoo:
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm
ls -l /run/shm
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
emerge-webrsync 
eselect news list
eselect news read 10 | less
eselect profile list
eselect profile set 5
emerge --info
### Flags/banderas.
emerge --info | grep ^USE
vim /etc/portage/make.conf
## La unica forma de sacarte alguna bandera es agregando un - en frente de la palabra.
En este caso dejaremos las flags por defecto
USE="" en el make.conf
### Actualizar todos los paquetes
emerge --ask --verbose --update --deep --newuse @world
ACCEPT_LICENSE="*"
echo "America/Buenos_Aires" > /etc/timezone
emerge --config sys-libs/timezone-data
vim /etc/locale.gen
### Agregá y guardá
es_ES.UTF-8 UTF-8
### Ejecutá
locale-gen
eselect locale list
eselect locale set 4
ln -sf ../usr/share/zoneinfo/America/Buenos_Aires
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
### Ahora configuramos el kernel.
emerge --ask sys-kernel/gentoo-sources
cd /usr/src/linux-6.10..
make menuconfig
### Otra opción es instalar el binario del kernel.
Podés elegir uno que tenga `systemd` o si te bajaste openrc tenés que usar la 2da opoción que sirve para cualquiera.
emerge --ask sys-kernel/installkernel-systemd-boot    
emerge --ask sys-kernel/installkernel-gentoo
emerge --sys-kernel/gentoo-kernel-bin
```
Ahora abrí otra terminal ejecutá:
```bash
sudo -s
cd 
chmod +x genfstab
./genfstab /mnt/gentoo
./genfstab /mnt/gentoo > /mnt/gentoo/etc/fstab
```
Luego seguí de la consola en donde tenías el chroot
```bash
vim /etc/fstab
Borrá todo menos /dev/sda1 /dev/sda2 /dev/sda3 y guardá
vim /etc/conf.d/hostname
hostname="Jentu"
vim /etc/hosts
Agregá tu hostname ahí
127.0.0.1 Jentu
passwd
vim /etc/conf.d/keymaps
es
vim /etc/conf.d/hwclock
emerge dhcpcd sudo screenfetch grub efibootmgr
### Cualquiera de estas dos formas funcionan, pero algunas computadoras tenés que agregar --removable al final.
#grub-install /dev/sda
#sudo grub-install --target=x86_64-efi --efi-directory=/boot --removable
grub-mkconfig -o /boot/grub/grub.cfg
vim /etc/sudoers
Descomentá la linea %wheel ALL=(ALL) ALL
useradd -m -g users -G video,audio,wheel nombre_usuario
useradd -m -G users,video,audio,wheel -s /bin/bash nombre_usuario
passwd nombre_usuario
cd /
rm -rf stage3....tar.xz
exit
exit
### Desmontar todo
sudo umount -a

```



---
### Guía de IMMOLO
Booteá el CD de instalación de gentoo.

cfdisk /dev/sda 

gpt o dos (ya lo expliqué anteriormente en la instalación de archlinux)

Creá una partición de 1G (efi system)  
2G de swap  
y el resto para Linux filesystem  

```bash
mkfs.vfat /dev/sda1 (efi)
mkswap /dev/sda2 
mkfs.xfs /dev/sda3
mount /dev/sda3 /mnt/gentoo
cd /mnt/gentoo
mkdir boot
mount /dev/sda1 boot
swapon /dev/sda2
mount
free -m
links gentoo.org/downloads/mirrors/
Seleccioná el mirror más cercano
releases > amd64 > autobuilds > current-stage3-amd64-desktop-openrc > bajate el *.tar.gz > save
tar xvf stage3*
rm stage*
arch-chroot .
vim /etc/portage/make.conf
en COMMON_FLAGS agregá -march=native

Agregá FEATURES="getbinpkg binpkg-request-signature"

ACCEPT_LICENSES="*"

cp /etc/resolv.conf etc/
arch-chroot .
emerge --sync
emerge -va gentoo-kernel-bin
dispatch-conf
getuto
emerge -va grub
## efi
grub-install --efi-directory=/boot /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
emerge -va sysklogd cronie chrony xfsprogs 
rc-update add sysklogd default 
rc-update add chronyd default 
passwd
qlop -t grub
vim /etc/hostname
poné el que quieras
exit
reboot
emerge -va fastfetch
emerge -va mate-base/mate lightdm xorg-drivers --jobs 8
useradd -m -G audio,wheel,video esotericwarfare
passwd esotericwarfare
rc-update add dbus default
rc-service dbus start
vim /etc/conf.d/display-manager
cambia DISPLAYMANAGER a lightdm

rc-update add display-manager default
rc-service display-manager start
Tenés que crear el .xinitrc y start XD

```
