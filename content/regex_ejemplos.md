---
title: "Regex ejemplos"
date: 2025-02-02T08:15:27-03:00
tags: ['regex']
---
Obtener todas las palabras que contengan una palabra y EXACTAMENTE 4 dígitos al final.

```bash
grep -E '\b([^0-9]*[0-9]){4}$[^0-9]*\b' rockyou.txt
```

```bash
grep -E '^[^0-9]*([0-9]){4}$' dic.txt > filtrado
```

#### Otros ejemplos: 
https://www.baeldung.com/linux/match-lines-n-digits-numbers

Salio la clave. Antes por ataque de WPS pude descubrir que uso una palabra y 4 numeros. Entonces baje el diccionario de latin en weakpass y filtre las palabras que
contengan EXACTAMENTE 4 numeros al final con grep, si alguno sabe una mejor forma de hacer esto diganme. De un diccionario de 11 gigas pase a uno de 1,7 gigas. En 3 dias
salio clave solo con CPU (Intel Celeron 2.0GHz)



```
grep -E '\b([^0-9]*[0-9]){4}$[^0-9]*\b' weakpass_4.latin.txt > sanchez_dicc1
grep -E '^[^0-9]*([0-9]){4}$' sanchez_dicc1 > sanchez_dicc2

aircrack-ng -w sanchez_dicc2 /home/esotericwarfare/Sanchez1/handshake-FE:A0:3F:21:00:91.cap
```

Saludos, que Dios los bendiga.

