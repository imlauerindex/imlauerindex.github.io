---
title: "Neocities: como buscar y pushear desde GitHub con GitHub Actions"
date: 2025-10-17T04:22:23-03:00
tags: ['tech']
---

Para buscar en Neocities (ya que Google censura y te muestra solo Reddit) podes usar estos 2 buscadores:
* [Wiby](http://wiby.me/)
* [Marginalia](https://marginalia-search.com/)

O directamente buscando por **tags**:

https://neocities.org/browse?tag=tor


#### Como deployar a Neocities desde GitHub yo tengo mi sitio alli tambien: https://imlauer.neocities.org

---

## ⚙️  **Automated deployment using GitHub Actions (recommended)**

You can make GitHub automatically push changes to Neocities when you push to `main`.

#### Step 1: Create an API key

1. Go to your [Neocities settings](https://neocities.org/settings).
2. Scroll to **API Key** → copy it.

#### Step 2: Add the key to your GitHub repo

1. On GitHub, open your repo → **Settings → Secrets → Actions**.
2. Add a new secret:

   * Name: `NEOCITIES_API_KEY`
   * Value: *(paste your key)*

#### Step 3: Add a workflow file

Create `.github/workflows/deploy.yml` in your repo:

```yaml
name: Deploy to Neocities

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Upload to Neocities
        uses: bcomnes/deploy-to-neocities@v1
        with:
          api_token: ${{ secrets.NEOCITIES_API_KEY }}
          dist_dir: .  # change if your built site is in a subfolder
```

This action will upload your repo’s files to Neocities automatically every time you push to `main`.

✅ **Reference:** [bcomnes/deploy-to-neocities](https://github.com/bcomnes/deploy-to-neocities)


Good — that’s actually a very common error when using `bcomnes/deploy-to-neocities`. The `JSONHTTPError: Bad Request` means **Neocities’ API rejected at least one of the files** being uploaded, usually for one of these reasons 👇

---

## 🧩 1. **You’re uploading disallowed files**

Neocities only allows *safe web formats*:

> `.html`, `.css`, `.js`, `.png`, `.jpg`, `.gif`, `.svg`, `.ico`, `.mp4`, `.mp3`, `.txt`, `.pdf`, `.xml`, `.json`, `.woff`, `.woff2`, etc.

❌ **Blocked extensions:** `.zip`, `.map`, `.ts`, `.jsx`, `.md`, `.yml`, `.git`, and all binary or hidden files (`.gitignore`, `.github`, `.git/`, `node_modules/`, etc.)

### ✅ Fix:

In your repo root, create a file called `.neocitiesignore` and add:

```
.git/
.github/
node_modules/
*.map
*.ts
*.tsx
*.jsx
*.yml
*.yaml
*.md
*.zip
*.json5
package*
README*
```

Then push again.
Neocities will now skip these files.

---

## ⚙️ 2. **Your `dist_dir` points to the wrong folder**

If you’re using a static site generator (Astro, Jekyll, Eleventy, etc.), make sure you’re only uploading the built site, not the source or node_modules.

Example for Astro:

```yaml
with:
  api_token: ${{ secrets.NEOCITIES_API_KEY }}
  dist_dir: dist
```

Check that the folder (`dist`, `_site`, `build`, etc.) contains **only web files** like `index.html`.

---

## 🧠 3. **Your API key or site name mismatch**

If your key belongs to a different Neocities account or site, you’ll get “Bad Request.”

### Verify:

Run this (locally or in a test workflow):

```bash
curl -H "Authorization: Bearer YOUR_API_KEY" https://neocities.org/api/info
```

It should return your site info.
If not, regenerate the key at [neocities.org/settings](https://neocities.org/settings).

---

## ✅ Quick fix summary

1. Add a `.neocitiesignore` to filter out unsupported files.
2. Ensure `dist_dir` points to your build output (not your source).
3. Recheck the `NEOCITIES_API_KEY` secret.

---

If you paste your workflow YAML (just the relevant `deploy` section) and tell me what’s inside your repo (e.g. Astro/Jekyll/plain HTML), I can tailor the `.neocitiesignore` and config exactly to your setup.
Want to do that?

