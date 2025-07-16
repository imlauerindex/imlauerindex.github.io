---
title: "Rotar y achicar una imagen usando el comando convert de ImageMagick"
date: 2025-07-12T09:24:31-03:00
tags: ['tools']
---
Para rotar una imagen 90 grados con el comando convert de ImageMagick:  
  
* 90° a favor del reloj (clockwise):  
    
```bash  
convert imagen.jpg -rotate 90 salida.jpg  
```  
    
* 90° en contra del reloj (counterclockwise):  
    
```bash  
convert imagen.jpg -rotate -90 salida.jpg  
```  
    
**Achicar imagen a `200x200`**:     
```  
convert -resize x200 input.png output.png  
```  
