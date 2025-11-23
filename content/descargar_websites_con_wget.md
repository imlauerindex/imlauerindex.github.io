---
title: "Descargar paginas enteras con Wget"
date: 2025-11-23T04:34:21-03:00
tags: ['cli']
---

Nunca mires nada online. Siempre descargatelo y si es mejor usa Tor.

```
Puedo explicarte **cómo usar `wget` para descargar un sitio MediaWiki**, pero **sin apoyar ni promover el contenido** del sitio que mencionas.
Te doy únicamente **instrucciones técnicas y neutrales**, válidas para *cualquier* wiki.

---

# ✅ Descargar una wiki con `wget` (método general)

`wget` puede hacer una “copia navegable” del sitio, pero **NO** obtendrás:

* el historial de ediciones
* la base de datos real
* algunos recursos protegidos

Aun así, sirve para copia *offline de lectura*.

---

# 📌 **Comando básico recomendado**

```bash
wget \
  --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --no-parent \
  https://incels.wiki/
```

### 🔍 ¿Qué hace cada opción?

| Opción               | Función                                                                                       |
| -------------------- | --------------------------------------------------------------------------------------------- |
| `--mirror`           | Activa recursividad, respeta tiempos, etc. (equivalente a `-r -N -l inf --no-remove-listing`) |
| `--convert-links`    | Convierte los enlaces para que funcionen offline                                              |
| `--adjust-extension` | Asigna extensiones correctas (.html)                                                          |
| `--page-requisites`  | Descarga CSS, imágenes y JS necesarios                                                        |
| `--no-parent`        | Evita subir a directorios superiores                                                          |
| URL                  | Página inicial del sitio a copiar                                                             |

---

# 📌 Aumentar profundidad (descargar más páginas)

MediaWiki usa muchos enlaces internos; a veces conviene añadir recursividad explícita:

```bash
wget \
  -r -l 5 \
  --convert-links \
  --page-requisites \
  --adjust-extension \
  --no-parent \
  https://incels.wiki/
```

`-l 5` significa “cinco niveles de recursión”. Puedes aumentar, pero es más lento.

---

# 📌 Si el sitio bloquea `wget`

Algunas wikis bloquean agentes automáticos. Puedes intentar:

```bash
wget \
  --mirror \
  --convert-links \
  --page-requisites \
  --adjust-extension \
  --no-parent \
  --user-agent="Mozilla/5.0" \
  https://incels.wiki/
```

---

# ⚠️ Advertencias importantes

* **Respeta la licencia del contenido** (muchas wikis usan CC-BY-SA).
* **No generes carga excesiva**: usa wget con moderación.
* **No uses las copias para hospedar, republicar ni promover contenido dañino**.

---

# 📌 ¿Quieres algo más completo?

Si necesitas una forma **mejor que wget** (por ejemplo, un dump XML de toda la wiki), puedo explicarte cómo usar **WikiTeam3**, que está hecho específicamente para descargar wikis completas.

¿Quieres usar `wget` solamente o prefieres una copia tipo “dump” como las de MediaWiki?


---

Muy buena pregunta. Si querés un **dump XML** de incels.wiki (o “incel.wiki”), hay algunas limitaciones importantes, más que nada si no sos administrador del sitio. No encontré evidencia pública de que incels.wiki tenga dumps oficiales disponibles para descarga libre, por lo que las opciones son más bien “hacer tu propio dump” mediante herramientas o pedirlo a los dueños del wiki.

Te explico las opciones + cómo hacerlo:

---

## ⚙️ Opciones para hacer un dump XML

1. **Usar WikiTeam3**

   * WikiTeam tiene una herramienta llamada **WikiTeam3 / MediaWiki Dump Generator**, que permite generar un dump XML de la wiki, usando la API o el scraping. ([Archive Team][1])
   * Esta herramienta puede guardar **el historial completo** o solo las revisiones más recientes. ([Archive Team][1])
   * Ejemplo de comando (suponiendo que usás Python 3):

     ```
     wikiteam3dumpgenerator https://incels.wiki --xml --xmlrevisions
     ```
   * Esto va a hacer llamadas a la API de MediaWiki para bajar los artículos y sus revisiones (no es exactamente igual a usar `dumpBackup.php`, pero es lo más cercano si no tenés acceso al servidor).

2. **Usar `Special:Export` de MediaWiki**

   * Si accedés a la wiki como usuario, podés ir a `Special:Export`:
     `https://incels.wiki/index.php?title=Special:Export`
   * Ahí podés poner los nombres de las páginas que querés exportar y bajar un XML con su contenido.
   * Limitación: con esta herramienta no es fácil exportar *todas* las páginas si son muchas, y podría haber límites en cantidad de páginas.

3. **Si tuvieras acceso al servidor**

   * Si vos o alguien que conozcas administra esa instancia de MediaWiki, podés usar el script `dumpBackup.php` que viene con MediaWiki para volcar toda la wiki en XML. ([MediaWiki][2])
   * Ejemplo:

     ```bash
     php maintenance/run.php dumpBackup --full > dump_completo.xml
     ```
   * Opcionalmente, incluir archivos subidos con `--include-files --uploads`. ([MediaWiki][2])
   * Este método es el más “limpio”, porque genera un volcado estructurado con todas las páginas y sus revisiones.

---

## ✅ Qué hacer si no hay un dump público

* Podés **preguntar a los administradores** de incels.wiki si tienen un dump XML para compartir.
* Si no te responden, la opción con WikiTeam3 es probablemente la más “respetuosa” y técnica para generar un dump por tu cuenta, usando la API pública.
* Tené en cuenta las **cuestiones legales y de licencia**: asegurate de que la licencia del contenido permita que hagas un dump y lo uses para lo que querés hacer.

---

Si querés, puedo chequear **en Internet Archive** o en otros repositorios para ver si hay ya un dump de incels.wiki disponible públicamente, y te comparto el enlace si existe. ¿Te parece bien hacer eso?

[1]: https://wiki.archiveteam.org/index.php/WikiTeam?utm_source=chatgpt.com "WikiTeam - Archiveteam"
[2]: https://www.mediawiki.org/wiki/Manual%3ADumpBackup.php/es?utm_source=chatgpt.com "Manual:dumpBackup.php - MediaWiki"


