---
title: "Nueva instalación binaria de Gentoo con OpenRC, XFS y Sway (Los binarios de Gentoo no son como los de ArchLinux)" 
date: 2025-06-22T22:25:52-03:00
tags: ['gentoo']
---
![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgHABzk8ar7MZ6s1NvBGSu_y54LtiYr0Igp7Fl9Q21Xniedh6_OT9l7EjHF5E6CCvWOBb-e8f5C4WnfbwhnDDtSmKsBi_vT1YnubrS8zB00axT48yUHrUv09CTyL_LeAQ2RBbSB5juTTqCHydiP-bpJoQmWD5dNnUEoVEVSrNVWWJsFGgmkGm2ef0S4F96w/s1366/reddit.png)


Ya había hecho una guía anteriromente sobre instalar Gentoo: https://imlauera.github.io/post/gentoo_installation/


###### Binarios
Si instalas el binario del grub en Gentoo no es lo mismo que el binario en ArchLinux.   
El binario de GRUB no viene con la bandera `mount (USE Flag)` habilitada por lo tanto si quiero usar `OS-PROBER` estoy obligado a compilar el GRUB porque **el binario de GRUB en Gentoo no tiene la bandera mount activada** entonces tengo que compilarlo para poder usar `OS-PROBER`.   
Es decir los binarios vienen con la mínima cantidad de banderas posibles, a diferencia de ArchLinux que vienen con la máxima cantidad de banderas posibles activadas.   
   
---   
   
###### Handbook AMD64 FULL: https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation   
https://wiki.gentoo.org/wiki/Handbook:AMD64/Full   

**AVISO: Esta guía no incluye la creación del pendrive con Gentoo ni el particionado**. Esta guía comienza después el particionado para adelante.   
**Como hacer crear el pendrive y el particionado están bien descriptos en el handbook**.
   
Instalé gentoo guíandome con el handbook: Usé XFS, OpenRC, Grub y agregué el binary host.   
   
NO instalé pipewire y funcionó el audio sin configurarlo.   
   
##### En el handbook usaba `/efi` como partición yo usé `/boot`(que supuestamente es para Legacy BIOS), funcionó pero no tengo Legacy BIOS tengo UEFI.   
```bash   
mkfs.fat -F 32 /dev/sda2   
mkfs.xfs /dev/sda1   
mkswap /dev/sda6   
mount /dev/sda1 /mnt/gentoo   
mount /dev/sda2 /mnt/gentoo/boot (En la guía sugiere /efi pero no lo usé así)   
swapon /dev/sda6   
cd /mnt/gentoo   
chronyd -q   
links https://gentoo.org/downloads/mirrors/   
releases/amd64/autobuilds/   
Descargué OpenRC: current-stage3-amd64-desktop-openrc/   
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo   
```   
   
   
nano `/mnt/gentoo/etc/portage/make.conf`   
   
```bash   
COMMON_FLAGS="-march=native -O2"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"

# NOTE: This stage was built with the bindist USE flag enabled

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C.utf8
MAKEOPTS="-j2 -l3"

GENTOO_MIRRORS="https://gentoo.zero.com.ar/gentoo/ \
    rsync://gentoo.zero.com.ar/gentoo"

FEATURES="${FEATURES} getbinpkg"
FEATURES="${FEATURES} binpkg-request-signature"
USE=""
ACCEPT_LICENSE="*"
USE="dist-kernel"
```   
   
nano /etc/resolv.conf   

**Borrá todo y poné las DNS de Cloudflare o Quad9**. Las DNS de Personal, Claro, Movistar bloquean sitios como: https://librefutbol.su, https://thepiratebay.org, https://example.com, etc
```   
# Cloudflare   
nameserver 1.1.1.1   
nameserver 1.0.0.1   
# Quad9   
nameserver 9.9.9.9   
```   
   
```bash   
cp --dereference /etc/resolv.conf /mnt/gentoo/etc` # se usa --dereference para que copie el archivo y no el link simbólico   
arch-chroot /mnt/gentoo` o podes montar uno por uno como está en el Handbook   
source /etc/profile   
export PS1="(chroot) ${PS1}"   
emerge-webrsync # Baja una snapshot de los títulos de los paquetes disponibles, sirve si estás detrás de un firewall (se actualiza cada 24 horas)
emerge --verbose --oneshot app-portage/mirrorselect   
mirrorselect -i -o >> /etc/portage/make.conf   
emerge --sync # Lo mismo que emerge-webrsync pero más actualizado. No hace falta porque emerge-webrsync está bastante actualizado.   
eselect news list   
eselect news read   
eselect profile list   
eselect profile set número (Probablemente ya está seleccionado con asterisco sino: default/linux/amd64/23.0/desktop no usé no-multilib)   
```   
   
###### Agregando el host de paquetes binarios.   
Esta parte la hice igual que como está en el Handbook   
   
   
Este archivo `/etc/portage/binrepos.conf/gentoobinhost.conf` ya está creado pero le cambié la prioridad:   
```console   
[binhost]   
priority = 9999   
sync-uri = https://distfiles.gentoo.org/releases/<arch>/binpackages/<profile>/x86-64/   
```   
   
En el archivo `/etc/portage/make.conf`:    
```bash   
# Appending getbinpkg to the list of values within the FEATURES variable   
FEATURES="${FEATURES} getbinpkg"   
# Require signatures   
FEATURES="${FEATURES} binpkg-request-signature"   
```   
Luego:   
```bash   
getuto   
```   
Para ver las banderas activas: `emerge --info | grep ^USE`   
Luego agregué `USE=""` en /etc/portage/make.conf    
```bash   
emerge --ask --oneshot app-portage/cpuid2cpuflags   
cpuid2cpuflags   
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags   
```   
   
En el archivo: `/etc/portage/package.use/00video_cards`   
```bash   
*/* VIDEO_CARDS: intel   
```   
   
##### Aceptá la licencia (ya lo hice antes en el `make.conf`)   
Para ver la licencia actual: `portageq envvar ACCEPT_LICENSE`   
Yo usé `ACCEPT_LICENCE="*"` se puede aceptar licencia por cada paquete usando el archivo `/etc/portage/package.license/kernel`.   
Para actualizar: `emerge --ask --verbose --update --deep --newuse --getbinpkg @world`   
   
Eliminar paquetes obsoletos te muestra una lista: `emerge --ask --pretend --depclean` # Si le sacas `--pretend` los borra.   
   
Configurar fecha y hora:    
```bash   
echo "America/Buenos_Aires" > /etc/timezone   
emerge --config sys-libs/timezone-data   
```   
   
En el archivo `nano /etc/locale.gen` habilitá US locales (es el idioma del sitema operativo).   
```bash   
en_US ISO-8859-1   
en_US.UTF-8 UTF-8   
```   
   
Ejecutá:   
```bash   
locale-gen   
eselect locale list   
eselect locale set 5 (en_US.utf8)   
```   
   
Ahora: `env-update && source /etc/profile && export PS1="(chroot) ${PS1}"`   
   
Ahora instalamos `linux-firmware` (sin esto probablemente no funcionará tu WiFi son los drivers).   
```bash   
emerge -G sys-kernel/linux-firmware   
emerge -G sys-firmware/sof-firmware   
emerge -G sys-firmware/intel-microcode   
```   
   
##### Instalando el GRUB:   
**Para mi esto no lo necesito pero igual lo hice así**:   
En el archivo `/etc/portage/package.use/installkernel` agregá:   
`sys-kernel/installkernel grub dracut`   
   
En el archivo `/etc/portage/package.use/uki` **(Creo que no necesito hacer esto si vas a usar gentoo-kernel-bin)**:   
```bash   
sys-kernel/installkernel dracut uki   
sys-apps/systemd-utils boot kernel-install   
```   
`emerge --ask sys-kernel/installkernel`   
   
Ahora instalamos un "distribution kernel": `emerge -G sys-kernel/gentoo-kernel` o `emerge sys-kernel/gentoo-kernel-bin`   
   
Actualizando y limpiando: `emerge --depclean`   
   
Agregá `USE="dist-kernel"` para reconstruir automáticamente módulos externos instalados por otros paquetes.   
   
```bash   
emerge --config sys-kernel/gentoo-kernel-bin   
```   
   
Podes usar `sys-kernel/modprobed-db` para recolectar información acerca de lo que el sistema requiere: si un control de Xbox es agregado a la instalación `modprobed-db` va a agregar módulos para ser compilados la próxima vez que el kernel es compilado.   
   
Usá `sys-apps/pciutils` que contiene el comando `lspci` para obtener más información del sistema y `lsmod`.   
   
En el handbook explica como compilar el kernel cosa que no lo vamos a hacer.   
   
**Información sobre sistema de archivos**:   
Ejecutá `blkid` para obtener el UUID para construir el `/etc/fstab` o simplemente ejecutá en otra TTY:
```bash
genfstab /mnt/gentoo >> /mnt/gentoo/etc/fstab
```   
En el handbook explica que es cada propiedad del archivo `/etc/fstab`.   
   
Podes agregar `noatime` para mejorar el rendimiento en la partición de raiz (XFS): `defaults,noatime` en `/etc/fstab`.   
   
Agregá el **hostname**: `echo tux > /etc/hostname`   
   
Instalá NetworkManager:    
```bash   
emerge -G NetworkManager   
rc-update add NetworkManager default   
```   
Ahora podes conectarte a una WiFi usando el comando: `nmtui`.   
   
Si no queres usar `NetworkManager` podes usar `netifrc` con `wpa_supplicant`.   
Explicado en el handbook: https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation#netifrc_.28OpenRC.29   
   
###### En el archivo `/etc/hosts`:   
```bash   
127.0.0.1	tux.homenetwork	tux	localhost   
::1		tux.homenetwork	tux	localhost   
```   
   
###### Cambiá la contraseña de `root`:    
```bash   
passwd   
```   
   
Cuando usas OpenRC con Gentoo el archivo `/etc/rc.conf` configura los servicios, inicio y apagado de un sistema. Abrí el archivo `/etc/rc.conf` y disfrutá de todos los comentarios en el archivo. Observá las configuraciones y cambia lo que necesitás.   
   
###### Configurá el teclado en el archivo `/etc/conf.d/keymaps`   
Ahí usé `"es"` (teclado Español)   
   
###### En el archivo `/etc/conf.d/hwclock` configurá el reloj:   
Si el reloj de hardware no está usando UTC, entonces es necesario usar `clock="local"` en el archivo. De lo contrario el sistema mostrará un mal comportamiento de reloj.   
   
###### System logger.   
Sysklogd es recomendado para principiantes.   
```bash   
emerge -G app-admin/sysklogd   
rc-update add sysklogd default   
```   
###### Cron daemon.   
```bash   
emerge sys-process/cronie   
rc-update add cronie default   
```   
   
###### File indexing (para búsqueda rápida)   
```bash   
emerge -G --ask sys-apps/mlocate   
```   
   
###### Opcional: Shell para acceso remoto.   
La configuración por defecto de `openssh` no permite ingresar como `root`. Por favor cree un usuario `no-root` y configuralo apropiadamente para permitir el acceso luego de la instalación si es requerido, o ajustá `/etc/ssh/sshd_config` para permitir acceso `root`.   
   
```bash   
rc-update add sshd default   
```   
   
##### Shell completion   
```bash   
emerge app-shells/bash-completion   
```   
   
##### Sincronicación horaria   
```bash   
emerge -G net-misc/chrony # Con -G fijate si está el binario   
rc-update add chronyq default   
```   
   
Es recomendable que `sys-block/io-scheduler-udev-rules` esté instalado para el correcto comportamiento horario (correct scheduler behavior) por ejemplo con dispositivos `nvme`.   
   
```bash   
emerge sys-block/io-scheduler-udev-rules   
```   
   
##### Herramientas de red   
   
No usé Netirfc (https://wiki.gentoo.org/wiki/Netifrc) ni el cliente dhcp, directamente instalé NetworkManager que tiene soporte WiFi (instalación realizada anteriormente).   
El handbook sugiere para WiFi: `emerge net-wireless/iw net-wireless/wpa_supplicant` **pero yo no lo usé**.   
   
##### Eligiendo el `boot loader`   
Podes elegir: GRUB, systemd-boot(usando OpenRC también sirve), EFI Stub.   
   
#### Importante: Si tenes UEFI directamente podes usar EFI STUB porque UEFI no necesita Grub para bootear. Grub es un bootloader secundario. Grub es cómodo ya que con `os-prober` te permite agregar otros sistemas operativos.   
   
```bash   
emerge -G sys-boot/grub   
```   
   
##### Usando `GRUB` como boot loader   
Uso la opción `--removable` porque en algunas placas madres con pobres implementaciones UEFI parece que solo funcionan con el directorio `/BOOT/BOOT` para el archivo `.EFI`. El instalador GRUB crea el `.EFI` archivo en esa ubicación automáticamente agregando la opción `--removable`.   
```bash   
grub-install --target=x86_64-efi --efi-directory=/boot --removable   
```   
###### Si instalaste el binario de `GRUB` ahora lo tendrás que compilar porque el **binario de GRUB no posee la bandera(USE flag) `mount` habilitada**.   
   
En el archivo `/etc/portage/package.use/os-prober` agregá:    
```bash   
>=sys-boot/grub-2.12-r7 mount   
```   
Instalamos OS-PROBER para detectar otras distros.   
```bash   
sudo emerge os-prober    
```   
En el archivo `/etc/default/grub` agregá:   
```bash   
GRUB_DISABLE_OS_PROBER=false   
```   
   
Y ahora:    
```bash   
grub-mkconfig -o /boot/grub/grub.cfg   
```   
En el handbook sugería usar: `grub-mkconfig -o /efi/EFI/Gentoo/grub.cfg` pero yo usé la partición `/boot` (explicado anteriormente).   

Hay una discusión sobre esto:
> Edit: 2024-04-19 20:09 (UTC) Handbook > GRUB > UEFI systems grub-install --efi-directory=/efi installs all files except grubx64.efi in /boot rather than /efi. Is that not a dangerous configuration, that will break for most? I propose recommending `grub-install --efi-directory=/efi --boot-directory=/efi` instead. `grub-mkconfig -o /efi/grub/grub.cfg` doesn't run without symlinking /boot into /efi. I also had to update that command from the wiki provided version using -o /boot/grub/grub.cfg

#### Agregando un usuario.   
El handbook fue muy puto acá: me recomendó un comando para crear el usuario pero sin el grupo `video` y estuve peleando un poco para iniciar `sway`.   
   
**Acá está el comando con el grupo video agregado.**   
```bash   
useradd -m -G users,wheel,audio -s /bin/bash esotericwarfare   
passwd esotericwarfare   
```   
   
##### Reiniciando el sistema:   
```bash   
(chroot) livecd # exit   
livecd~# cd   
livecd~# umount -l /mnt/gentoo/dev{/shm,/pts,}   
livecd~# umount -R /mnt/gentoo   
livecd~# reboot   
```   
   
Cuando botea Gentoo, instalé `sudo` y cambié la configuración de `/etc/sudoers`.   
Agregá al final:   
```bash   
esotericwarfare ALL=(ALL:ALL) NOPASSWD:ALL   
```     
Y ahora eliminamos la contraseña del usuario `root` por seguridad:   
```bash   
passwd -l root   
passwd -dl root   
```     
##### Eliminamos los artifactos de instalación.   
```bash   
cd /   
rm stage3-*   
```   
   
Podes consultar cualquier duda en el canal de IRC en LiberaChat: `#gentoo` o en los foros: https://forums.gentoo.org   
   
Cualquier bug: https://bugs.gentoo.org   

### Lista de programas que instalé luego 
```bash
### Binarios
sudo emerge -G sys-devel/bc btop evince falkon gimp imagemagick jq neomutt pcmanfm-qt samba translate-shell wget wl-clipboard xhost xwayland libreoffice mpv git nim thunderbird grim

sudo emerge yt-dlp xdg-desktop-portal-wlr xdg-desktop-portal-wlr vim firefox-bin wmenu telegram-desktop-bin qbittorent tor rclone proxychains unrar unzip tor torsocks os-prober
```
