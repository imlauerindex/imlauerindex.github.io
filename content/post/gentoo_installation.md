---
title: "Gentoo basic installation"
date: 2023-11-29T08:39:16-03:00
tags: ['gentoo','install']
categories: ['linux','installation']
---
Esto son los paquetes que instalé por el momento, sin Xorg solo wayland. Sí uso fish y qué?
La verdad es que Gentoo es un meme pero a mi me divierte.

Recién me estoy iniciando lejos de ser un experto. Use systemd con ext4, la mayoría de usuarios de gentoo no usan systemd ni ext4, usan xfs con openrc creo. 

Aca estan los pasos que segui:

De acá me bajé minimal installation CD: https://www.gentoo.org/downloads/ lo puse en un pendrive ejecutando `dd if=...iso of=/dev/sdb status=progress bs=1M` y lo boote pero podés instalar gentoo desde cualquier distro de linux siempre y cuando no sea esa partición en donde quieras instalarlo.


```bash
loadkeys es # Teclado en español de españa (no uso el de argentina)
fdisk -l
```
Hacemos el particionado con `cfdisk /dev/sda` o usando `fdisk /dev/sda`.

Explicación sobre MBR(DOS) y GPT : https://youtube.com/watch?v=Ch9f7i0hj90 Basicamente si tenes un disco duro de mas de 3 gigas usa GPT pero si es de menos usa DOS, para UEFI tenes que usar GPT.

**Crea una particion de efi de por lo menos 300 megas, otra de swap de 4gb, y el espacio que sobra para ext4**

**Si no lo quieren hacer con cfdisk lo pueden hacer con fdisk de la siguiente manera:**                          

##### uefi (gpt)
```bash
g (gpt disk label)
n
1 (partition number [1/128])
2048 first sector
+300M last sector (boot sector size)
t
1 (EFI System)
n
2
default
+4G
t
2
swap
n
3
default (fill up partition)
default (fill up partition)
w (write)
```

#### Formateo, montado de particiones e instalación base (usando UEFI)
```bash
mkfs.ext4 /dev/sda3 (root partition)
mkswap /dev/sda2 (swap partition)
mkfs.fat -F 32 /dev/sda1 (efi partition)
mount /dev/sda3 (root_partition) /mnt/gentoo
mount --mkdir /dev/sda1 (efi partition) /mnt/gentoo/boot
swapon /dev/sda2 (swap_partition)
links https://gentoo.org/downloads/mirrors
```

##### Por ahora uso systemd
```bash
South America -> AR ->  [url]https://gentoo.zero.com.ar/gentoo/[/url] -> releases -> amd64 -> autobuils -> current-stage3-amd64-desktop-systemd/ -> stage3-amd64-desktop-systemd-20250406T165023Z.tar.xz -> descargá y guardalo 
```

##### Descomprimí y borralo.
```bash
tar xvf stage*
rm stage* 
genfstab /mnt/gentoo > /mnt/gentoo/etc/fstab
```
#### Configurá las dns (No uses las de personal ni claro porque bloquean todo si me creen tirale un ping a thepiratebay.org o a librefutbol.su)
```bash
cp --dereference /etc/resolv.conf /mnt/gentoo/etc
cd /mnt/gentoo
arch-chroot .
nano /etc/portage/make.conf
ACCEPT_LICENCE="*"
MAKEOPTS="-j3" # Sirve para optimizar el tiempo de compilacion sugieren: numeros de núcleos+1
ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
hwclock --systohc
nano /etc/locale.gen y descomentá en_US.UTF-8 UTF-8 (es el idioma del sistema operativo a mi me gusta en ingles)
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf
```
##### Mirá en el directorio /usr/share/consolefonts/ para ver tus letras disponibles
```bash
echo "FONT=latarcyrheb-sun32" >> /etc/vconsole.conf
echo "arch" > /etc/hostname
```

#### Agregá o reemplazá
`nano /etc/hosts`    
```bash
127.0.0.1       localhost
::1 localhost
127.0.0.1       arch.localdomain        arch
```
#### Cambiamos contraseña root y sincronizamos
```bash
passwd 
emerge-webrsync
echo "America/Buenos_Aires" > /etc/timezone
emerge --config sys-libs/timezone-data
```

#### Esta linea compilara todos estos paquetes
```bash
emerge -va gentoo-kernel-bin grub networkmanager pipewire tmux fastfetch os-prober sudo fish sway wmenu foot alsa-utils firefox-bin mpv php apulse imagemagick sys-kernel/linux-firmware wpa_supplicant translate-shell dev-vcs/git hugo dev-python/pip wl-clipboard grim btop feh yt-dlp neomutt aircrack-ng falkon irssi w3m net-fs/samba vim

Agregá --autounmask-write y luego dispatch-conf
hwclock --systohc
systemctl enable NetworkManager
```

En algunos UEFI frameworks con fallas tenes que instalar el grub usando el parámetro --removable para instalar
el bootloader a la ubicación de respaldo “fallback” porque sino se borra sólo la entrada del efi.

`sudo grub-install --target=x86_64-efi --efi-directory=/boot --removable`

Para que os-prober descubra otra particiones tenés que montarlo y en `/etc/default/grub` escribí `GRUB_DISABLE_OS_PROBER=false`
```bash
grub-mkconfig -o /boot/grub/grub.cfg
echo "KEYMAP=es" > /etc/vconsole.conf
echo "FONT=latarcyrheb-sun32" >> /etc/vconsole.conf
```

Modifica sudoers opcional si queres sudo sin contraseña

```bash
sudo systemctl enable gpm
exit
exit
reboot
```

#### Nos logueamos y creamos un usuario luego de bootear gentoo
```bash
useradd -m -g users -G video,audio,wheel nombre_usuario
passwd nombre_usuario # agregarle una contraseña al usuario
$ nmtui (para conectarse wifi)
vim /etc/sudoers y agregá tu usuario copiando la linea de root y sustituyendo root por tu nombre de usuario debajo de todo.
```

Y abrimos el entorno grafico ejecutando sway desde la TTY y con Tecla Windows+Enter abrimos una terminal llamada foot.

Ahora en `/usr/bin/firefox-bin` a la última línea agregá `apulse` (por el audio).


Listo.

Para actualizar todos los paquetes: `emerge --ask --verbose --update --deep --newuse @world`
Las noticias se leen con `sudo eselect news list` y `sudo eselect news read 1`


Si tu WiFi funciona lento: https://forums.gentoo.org/viewtopic-t-1075252-start-0.html
https://forums.gentoo.org/viewtopic-t-996692.html

https://reyabogado.com/us/what-is-wireless-regulations/

```bash
iw reg set AR # (codigo de tu pais)
```

Para ver cuanto tiempo te tardará compilar un paquete: 
```bash
sudo emerge -av genlop
genlop -tq www-client/falkon
```

O podes conseguir un valor estimado acá:
https://gentoo.linuxhowtos.org/compiletimeestimator/

---

#### Antigua guía.


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

