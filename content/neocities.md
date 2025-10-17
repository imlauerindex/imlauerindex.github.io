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

