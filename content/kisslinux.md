---
title: "Kiss Linux (compilar kernel manualmente)"
date: 2025-06-25T02:43:44-03:00
tags: ['linux']
---
![](data:image/png;base64,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)

Primero boteá ArchLinux descargá la ISO de acá: https://archlinux.org/download/

Quemá la ISO en un pendrive usando
```bash
dd if=archlinux.iso of=/dev/sdb status=progress bs=4098
```

https://kisslinux.github.io Está obsoleto, el creador desapareció pero la comunidad de KISS decidió forkearlo acá: https://kisscommunity.org/kiss/install/

Al bootear ArchLinux particionemos el disco.
###### legacy boot sin swap
Si estás en una VM podes directamente crear una única partición
```bash
o
n
p
1
Enter
Enter
w
```

###### uefi (gpt) con Swap
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

Descargá el último release **kiss-chroot** de acá: https://codeberg.org/kiss-community/repo/releases
Extraélo como `root`. 

###### Instalación en Legacy Boot en UEFI tendrás que crear una partición EFI con `mkfs.fat -F 32` (explicado en el artículo de ArchLinux)
```bash
mkfs.ext4 /dev/sda1 
mount /dev/sda1 /mnt
cd /mnt
lynx https://kisscommunity.org/kiss/install/
De ahí dale a `latest-release` bajá hasta donde dice `Downloads` y descargá `kiss-chroot-24.12.18.tar.xz`, **Download and Save to Disk**.
tar xvf kiss-chroot-24.12.18.tar.xz # Descomprimí como root
genfstab -U /mnt >> /mnt/etc/fstab
bin/kiss-chroot .
```
En el archivo `/etc/profile.d/kiss_path.sh` 

vi `/etc/profile.d/kiss_path.sh`:
```bash
export REPOS_DIR='/var/db/kiss'
export KISS_PATH=''
KISS_PATH=$KISS_PATH:$REPOS_DIR/repo/core
KISS_PATH=$KISS_PATH:$REPOS_DIR/repo/extra
KISS_PATH=$KISS_PATH:$REPOS_DIR/repo/wayland
KISS_PATH=$KISS_PATH:$REPOS_DIR/community/community

export CFLAGS="-O2 -march=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j2"

export KISS_SU=su
```

Cargamos las variables:
```bash
cp /etc/profile.d/kiss_path.sh .profile
source ~/.profile
echo $KISS_PATH
cd /var/db/kiss
git clone https://codeberg.org/kiss-community/repo
git clone https://codeberg.org/kiss-community/community
cd repo
git config gpg.ssh.allowedSignersFile .allowed_signers
git config merge.verifySignatures true
kiss update
cd /var/db/kiss/installed && kiss build *  
kiss b e2fsprogs dosfsprogs xfsprogs util-linux dhcpcd libelf ncurses perl baseinit
# Quedó obsoleto eudev
mkdir -p /etc/rc.d
echo "dhcpcd 2> /dev/null" > /etc/rc.d/dhcpcd.boot
echo kiss > /etc/hostname
vi /etc/hosts
127.0.0.1   kiss
ping kiss
cd /var/db/kiss
```
Descargá el linux kernel: 
```bash
lynx kernel.org
Latest Release - Download
tar xvf linux-*
cd linux-*
```

Es recomendable bootear con ArchLinux porque carga todo lo que necesitás para que tu sessión sea exitosa, ahora todos los módulos están cargados en la memoria si ejecutás: 
```bash
lspci -k
```
Verás que el ethernet está cargado, etc. Es un buen comienzo pero no es todo.
Ahora podes descargar `linux-firmware` pero en este caso lo omnitiremos.
Primero tenemos que crear la configuración por defecto del kernel
```bash
make defconfig
```
Si ejecutamos:
```bash
make help
```
Encontrarás un argumento llamado `localyesconfig (update current config converting local mods to core)`
```bash
make localyesconfig
```

Sacale una foto o una screenshot a la salida de ese comando para buscar uno por uno más rápido.

Ese comando convierte lo que está en memoria cargado con ArchLinux pero se da cuenta de que no está configurado todavía, así que no puedo convertirlo lo que significa que lo necesito.
Parece mucho pero hay varios `sub-modulos`.
Ejemplo: `pata_acpi` si copiás `CONFIG_PATA_ACPI` (podes copiar si habilitas el mouse systemctl start gpm en otra consola lo pegas con botón derecho).
```bash
make menuconfig
/ (slash)
CONFIG_PATA_ACPI
```
Te dice `[=n]` y abajo en `Depends: ` y en `Selects: [=n]` (esa tenes que seleccionarlo y habilitarlo con `*` para que quede todo en `[=y]`)

Si apretás el número lo podes convertir como `core` si lo pones con `*`(asterisco) - Save - Exit - Exit

Ahora ejecutá:
```bash
make localyesconfig
```
Si lo hiciste bien debería haber desaparecido el mensaje.
###### Lo mismo con todos los demás siempre guardá, salí y mirá si el mensaje desapareció ejecutando `make localyesconfig`...
Con bluetooth hay un problema BT es una subsección no es algo... `BT [=n]` dice no para habilitar esas cosas, cuando ves eso posponelo.
Dice `[=n]` pero si mirás abajo en `Selects:` dice: `CRC16[=y] && CRYPTO[=y]...` tiene varias habilitadas pero para que quede habilitado `BT [=n]` todo debería estar en `[=y]`.
Pero si copias el que dice `[=n] (CRYPTO_ECB)` haces una búsqueda no lo encontrarás porque no es un módulo, es una opción.
###### Por eso es mejor omnitirlo el `bluetooth`
Si es una sección es mejor no tocarla y mientras hacés las demás esa sección desaparecerá.
Si no ves un número al buscar, no podes hacer nada ignoralo y habilitando los demás desaparecerá el mensaje.

VMware usa `CONFIG_SND_EN5171` 

Hacé lo mismo para cada `CONFIG_`

#### A veces si haces una búsqueda y ponés el nombre completo: `CONFIG_...` no lo encuentra pero si pones la mitad del nombre si lo encuentra.

Al final cuando ejecutás `make localyesconfig` no te debería salir ningun mensaje solo:
```bash
using config: .config
```

Ahora que hicimos todo los modulos:
```bash
make menuconfig
``` 
Si vez `Kernel .config support` con un `<M>` 

Deshabilitá en `General Setup - Initial RAM filesystem and RAM disk (initramfs/initrd) support`  
En `Processor type and features - Processor family` seleccioná `Core 2/newer Xeon`.
En `General setup - Default hostname - kiss` 
En `device drives - USB support`
En `filesystem` debería estar habilitado `ext4`.

```bash
make -j $(nproc)
# Ignorá el mensaje Cannot find LILO 
make install  
mv /boot/vmlinuz    /boot/vmlinuz-VERSION  
mv /boot/System.map /boot/System.map-VERSION 
# Fijate que esté bien el fstab
cat /etc/fstab
kiss b grub
Legacy BOOT
Desde KISS Linux
sudo grub-install /dev/sda --recheck
grub-mkconfig -o /boot/grub/grub.cfg
Desde ArchLinux
grub-install --boot-directory=/mnt/boot /dev/sda --recheck
```

Descargá el `linux-firwamre`:
```bash
cd /usr/lib
git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
```

Si estás en VirtualBox abrí la configuración en Experto y en Display poné `Graphics Controller` en `VBoxsSVGA`
.
Ahora en el archivo `/etc/default/grub` agregamos en la línea `GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nomodeset"`

```bash
vi /etc/default/grub
+GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nomodeset # (no carga los drivers de video)
grub-mkconfig -o /boot/grub/grub.cfg
passwd
adduser esotericwarfare
addgroup esotericwarfare audio
addgroup esotericwarfare video
addgroup esotericwarfare input
exit
exit
reboot
```

Con `lspci -k` podes ver que módulos cargó.

```bash
dhcpcd # Levantar network
cd /var/db/kiss/community/community - Paquetes disponibles en el repositorio
ls 
```

Probamos si podemos instalar un paquete.
```bash
kiss b neofetch
neofetch
```

---

Agregado.


Tecla combinada / bastidor para la cocina
Dos tomas un bastidor con 2 tomas para no usar adaptador.

El built me tardo 10 horas
Desde ArchLinux
```bash
root@archiso ~ # grub-install --efi-directory=/mnt/boot --boot-directory=/mnt/boot --target=x86_64-efi --bootloader-id=grub_uefi  --removable
```
Agrega `kiss b grub lm-sensors elinks` al comienzo

2:42 AM

La compilacion del kernel me tardo 2 horas y 40 minutos

El `linux-firmware` pesa 4g

```bash
mount --mkdir /dev/sda5 /mnt/mnt/mx
```

Habilita todos estos y nodemodeset en el `GRUB_CMDLINE`
```bash
CONFIG_FB 
CONFIG_FRAMEBUFFER_CONSOLE
CONFIG_FB_EFI
CONFIG_FB_VESA
```

Los primeros paquetes que instale despues de iniciar Linux.
##### Es mejor compilar los paquetes uno por uno porque recien los instala luego de compilarlo, si compilas varios paquetes recien los instalara cuando termine de compilar el ultimo paquete.
```
kiss b openssh imagemagick qpdf lm-sensors links vis vim mpv swayfx swagbg firefox-privacy
(root) pip install yt-dlp
```
###### Estuvo 3 dias 12 horas horas compilando LLVM y Clang SPIRV tools para instalar 2 paquetes: mpv y sway!! En una Intel Celeron N2806 Dual Core 1.6GHz
```bash
addgroup esotericwarfare audio
addgroup esotericwarfare video
addgroup esotericwarfare input
```


Clang 04:09 AM - 38%








Estos son los paquetes que estan en el repositorio de `community`:

```bash
9base abduco aerc age amfora aml android-tools appstream apulse aria2 asciinema autoconf autoconf-archive automake axel bandwhich bash bat bc bemenu birch
bit-bin boost bottom brlaser brotli btop btrfs-progs bubblewrap cantarell-fonts catgirl cava ccrypt cfm chicken cloc cmark-gfm cmus containerd coreutils
cproc crosstool-ng cryptsetup ctags cups cups-filters curlpp darkhttpd dash dejavu-ttf delta dialog discount diskonaut djvulibre dmidecode docker docker-buildx
docker-compose-bin dogefetch dvtm ecl elinks emacs emacs-compat emacs-kiss-git emacs-tsort entr erlang evremap evtest exa execline exfatprogs exiftool
extra-cmake-modules falkon fdk-aac fdm fff fftw file flac flatpak fmt fnf fortune fossil freeglut fuse fuse2 fzy gawk gc gcompat gdb ghostscript girara github-cli
globe-cli glorytun glow-bin gnu-netcat gnupg1 gnupg2 gnutls go go-bootstrap go-ipfs goimports gopls gperf gpgme gphoto2 groff gron-git gsl gspt gt5 gtar gtest
guile3 guile3-fibers-git gumbo-parser hack hexyl hostapd htop hugo hummingbird-git icu idmap imagemagick imath inih iniparser init-hooks iosevka-nerd-fonts
iperf iproute2 iptables isync iw jbig2dec jo jq json-glib kak-lsp-bin kakoune kexec-tools keyutils kfc kiss-find kmod lcms ldns less libaio libarchive
libassuan libatomic_ops libbpf libburn libcap libconfig libcupsfilters libdvdcss libedit libev libevent libexif libgcrypt libgpg-error libgphoto2 libisoburn
libisofs libjpeg libksba libmupdf libnl libpcap libportaudio2 libppd libpsl libseccomp libsixel libslirp libsndfile libsodium libssh libtermkey libtool libtorrent
libunistring liburing libusb libutemper libuv libvncserver libwebsockets libxdp libxml2 libxmlb libxslt libyaml limine links lm-sensors lpeg lsof lua luajit lux lvm2
lz4 lzo mblaze mdev-usb mediainfo mg minikube mksh mosh msgpack-c msmtp mtools mtpaint mtr nano nawk-git ncdu1 neatvnc neofetch neomutt neovim nettle nmap npth
nq nsd ntfs-3g numactl oksh openjpeg2 openntpd optipng ostree ox pandoc-bin pash patch patchelf pciutils perl pfetch pick pinentry pipewire pkcs11-helper pmount
poppler poppler-data popt pounce powertop pqiv procps-ng protobuf protobuf-c pv pybind11 pystring qbe qemu qpdf qrencode qt5 qt5-declarative qt5-svg qt5-wayland
qt5-webchannel qt5-webengine ranger readline reptyr retrogram-rtlsdr ripgrep rsync rtorrent ruby runc runit rustup-bin s6 s6-linux-init s6-rc sane sbase sbcl sc
sc-im sccache scenefx scrcpy scroll scryer-prolog sdl2 secret sed sed-i senpai sfeed sgt-puzzles shellcheck-bin shepherd shfm shfmt-bin shinit sinit slang slides
slirp4netns smu-karlb spotify-player spotifyd squashfs-tools sudo swappy swaybg swayfx swayidle swaylock swww syncthing sysmgr tcc tdb tea terminus-font tiff tig
tinygo-bin tinyramfs-git tiv tmate tmux tokei totp transmission tre tree ttf-font-awesome ttf-jetbrains-mono ttyd tuitube twemoji-color-font typescript-language-server
uacme ubase ugrep umurmur unbound unzip uthash virglrenderer vis viu vmwh vundle wayvnc wireguard-tools wireless_tools wl-clipboard wl-screenrec wlr-randr
wmenu xxd yajl yarn yash yasm yt-dlp ytfzf zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-pdf-poppler zig-bin zip zls-bin zsh zzz
```

Paquetes que esta en el repo de `repo/extra` (tiene 2 mas: core y wayland)
```
adwaita-icon-theme alsa-lib alsa-utils bkeymaps cairo cbindgen ccache clang cmake cyrus-sasl dhcpcd dosfstools e2fsprogs efibootmgr efivar eiwd expat
ffmpeg firefox firefox-privacy fontconfig freetype-harfbuzz gdk-pixbuf glib gnugrep gtk+3 hicolor-icon-theme hwdata intel-vaapi-driver json-c kirc lame
libass libclc libdisplay-info libelf libepoxy libffi libjpeg-turbo libnl-tiny libogg libplacebo libpng libretls libtheora libudev-zero libva
libva-utils libvorbis libvpx libwebp llvm man-pages mandoc mdevd mesa meson mold mpv mutt nasm ncurses nodejs nspr nss opendoas openresolv openssh opus
pango pcre2 pkgconf python python-docutils python-flit-core python-glad python-gpep517 python-installer python-jinja2 python-mako python-markupsafe
python-packaging python-setuptools python-wheel python-yaml rust samurai scdoc skalibs spirv-headers spirv-llvm-translator spirv-tools sqlite ssu
strace ttf-croscore tzdata util-linux vim wpa_supplicant x264 x265 xvidcore zstd
```
