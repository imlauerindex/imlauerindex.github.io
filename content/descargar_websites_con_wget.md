---
title: "Como usar wget y WikiTeam3 para descargar un sitio MediaWiki"
date: 2025-11-23T04:34:21-03:00
tags: ['cli']
---

Nunca mires nada online. Siempre descargatelo y si es mejor usa Tor.
Anteriormente a esto me descargué Kiwix, los docs de ArchLinux, Gentoo y la inciclopedia.

```bash
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent https://geohot.github.io/blog/
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

```bash
wget -r -l 5 --convert-links --page-requisites --adjust-extension --no-parent https://incels.wiki/
```

`-l 5` significa “cinco niveles de recursión”. Puedes aumentar, pero es más lento.

---

# 📌 Si el sitio bloquea `wget`

Algunas wikis bloquean agentes automáticos. Puedes intentar:

```bash
wget --mirror --convert-links --page-requisites --adjust-extension --no-parent --user-agent="Mozilla/5.0" https://incels.wiki/
```

* **Respeta la licencia del contenido** (muchas wikis usan CC-BY-SA).

---

### Hacer un dump de XML con WikiTeam3

Muy buena pregunta. Si querés un **dump XML** de incels.wiki (o “incel.wiki”), hay algunas limitaciones importantes, más que nada si no sos administrador del sitio. No encontré evidencia pública de que incels.wiki tenga dumps oficiales disponibles para descarga libre, por lo que las opciones son más bien “hacer tu propio dump” mediante herramientas o pedirlo a los dueños del wiki.

---

## ⚙️ Opciones para hacer un dump XML

1. **Usar WikiTeam3**

   * WikiTeam tiene una herramienta llamada **WikiTeam3 / MediaWiki Dump Generator**, que permite generar un dump XML de la wiki, usando la API o el scraping. ([Archive Team][1])
   * Esta herramienta puede guardar **el historial completo** o solo las revisiones más recientes. ([Archive Team][1])
   * Ejemplo de comando (suponiendo que usás Python 3):

     ```bash
     wikiteam3dumpgenerator https://incels.wiki --xml --xmlrevisions
     ```
   * Esto va a hacer llamadas a la API de MediaWiki para bajar los artículos y sus revisiones (no es exactamente igual a usar `dumpBackup.php`, pero es lo más cercano si no tenés acceso al servidor).

2. **Si tuvieras acceso al servidor**

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

---

Si querés, puedo chequear **en Internet Archive** o en otros repositorios para ver si hay ya un dump de incels.wiki disponible públicamente, y te comparto el enlace si existe. ¿Te parece bien hacer eso?




---

Buena idea. Hice una búsqueda, pero no encontré un **dump público en Internet Archive** para **incels.wiki**: no hay registros obvios en la Wayback Machine ni un archivo completo descargable desde Archive.org con todas las páginas del wiki.

Sin embargo, sí encontré algo relevante:

* En **Hugging Face** hay un dataset llamado *“incelwiki‑20240225‑dump”*, que parece ser un volcado de la wiki hasta el **25 de febrero de 2024**. ([Hugging Face][1])
* En dicho dataset están los textos más recientes (“text”: el contenido de la revisión más reciente) y un historial de revisiones (“revisions”) por página. ([Hugging Face][1])
* También hay un archivo `siteinfo.json` que describe la estructura del sitio original (nombre de la web, base URL, colación de categorías, etc.). ([Hugging Face][2])

https://huggingface.co/api/resolve-cache/datasets/NyxKrage/incelwiki-20240225-dump/6b5514611ff193832ce1d6809b9ff6201f99224d/incelwiki-20240225-dump.py?download=true&utm_source=chatgpt.com&etag=%22cff77a827e280a84ea4e1304bba965836b33328f%22

---


```bash
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent --tries=3  https://stallman.org
```

---

El comando anterior era muy profundo así que usé este:

```bash
wget -r -l 5 --convert-links --adjust-extension --page-requisites --no-parent --tries=3 https://stallman.org
```

