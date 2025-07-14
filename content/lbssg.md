---
title: "Libreboot Static Site Generator(Lbssg) con pandoc."
date: 2025-07-14T09:43:10-03:00
tags: ['static','website','generator']
---
Usa pandoc como dependencia.

Reposotorio: https://codeberg.org/libreboot/lbssg
Documentación: https://libreboot.org/docs/sitegen/

Yo uso el sistema de blog de noticias al inicio de la página, borro el index.md
```bash
cp www-example/bunnies www # Tenes que copiar con el nombre la carpeta a www
cd www/bunnies/site
rm index.md
cd news
mv * ..
cd ..
```

Editá el archivo `news.cfg` y agrega una descripción a tu blog, en mi caso hice un blog de electricidad.
```bash
BLOGTITLE="cursos"
BLOGDESCRIPTION="Electricista"
```

Borré la publicación `bunny` que tiene por defecto y renombré `resignations.md` para usarla como bienvenido.
```bash
rm bunny202104xx.md
mv resignations.md bienvenido.md
```

Ahora editá el archivo bienvenido.md con vim, nano, emacs tu editor de preferencia.

En el archivo `MANIFEST` borrá todo y agregá tu primera publicación: `bienvenido.md`
En el archivo `sitemap.md` borrá las entradas que hacían referencia a `bunny` y a `resignations`, renombré la primera por `bienvenido.md` y borré todas las entradas que no necesitaba.

El `site.cfg` lo dejé así:
```bash
TITLE="Curso Electricidad"
CSS="/global.css"
DOMAIN="https://cursoelectricidad.github.io/"
BLOGDIR="" # leave as empty string if you want the blog to be the homepage
DEFAULTLANG="es"
```

Ahora construímos el sitio desde la raíz del proyecto 
```bash
cd ../../../
./build
```

El binario `./clean` borra los `html`

##### Importante:
Debemos crear un repositorio para el directorio `www` (se crea usando `git init && git add origin git@github.com... && git add . && git commit -m first && git push`) que debe tener de nombre `tudominio.github.io` y tenes que crear una nueva organización en GitHub para poder tener ese dominio.
Todo lo que está anterior a ese directorio será ignorado y la configuración `site.cfg` no estará en el repositorio.
```bash
cd www/bunnies/site
git init 
git add ... 
git commit -m first
git push ..... # etc, etc, etc
```

