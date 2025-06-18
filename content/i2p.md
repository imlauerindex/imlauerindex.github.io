---
title: "i2p: free vpn"
date: 2025-06-13T22:37:40-03:00
tags: ['vpn']
---
Para saltear un baneo podes usar Tor, Lokinet o i2p. En otro tutorial de la página expliqué como usar lokinet. Y para bajar un torrent de forma anónima podes usar i2p o freenet.
Tenes que agregar http://notbob.i2p/hosts.txt 
```bash
yay -S i2p-bin # Instala binarios en /opt/i2p
sudo i2prouter start
http://localhost:7657
```


Usar w3m con i2p:
```bash
w3m -o http_proxy=http://127.0.0.1:4444 http://notbob.i2p
```

---

Usar chawan con i2p en ArchLinux:
```bash
sudo pacman -S proxychains-ng
sudo vim /etc/proxychains.conf o sudo vim /etc/proxychains4.conf o 
```
Agregá al final: `socks4 127.0.0.1 4444`


Luego: `proxychains cha http://notbob.i2p`
