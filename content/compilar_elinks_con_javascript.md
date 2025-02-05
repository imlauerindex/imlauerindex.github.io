---
title: "Compilar elinks con JavaScript"
date: 2024-11-24T11:22:20-03:00
tags: ['elinks']
---
Si querés tener un mínimo soporte de javascript en un navegador de consola tenés que tener SpiderMonkey instalado y recompilarlo desde el source.

```bash
w3m http://elinks.or.cz/download/
tar xvf elinks-current-unstable.tar.gz
./configure | grep Spider
```

JavaScript is enabled by default if Spidermonkey is found, according to the config file in the
felinks git repo. Haven't tried it myself, though. More here: http://elinks.or.cz/documentation/manual.html#ecmascript

