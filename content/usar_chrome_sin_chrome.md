---
title: "Usar chrome sin chrome: Chrome headless"
date: 2025-03-08T08:02:01-03:00
tags: ['chrome']
---
```bash
chromium --headless https://youtube.com --run-all-compositor-stages-before-draw --screenshot --virtual-time-budget=10000
```

O también se puede usar el parámetro `--print-to-pdf=/tmp/tmp.pdf`

```bash
chromium --headless --dump-dom youtube.com
```

```bash
chromium --headless https://bilibili.com --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | w3m -
```

Usarlo con w3m como navegador externo: Creá un archivo llamado `w3m_chromium.sh` con el siguiente contenido y agregalo como navegador externo en w3m.
```bash
chromium --headless $1 --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | w3m -
```

```bash
chromium --headless $1 --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | monolith - -I -b $1 | w3m -
```

### El comando que estoy actualmente usando: Sin monolith con sed es mas rápido

```bash
chromium --headless $1 --disable-gpu --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | sed "s|<head>|<head><base href=$1>|g" | w3m -T text/html
```

##### Se pude usar puppeteer para scrollear y cargar todo el javascript.
Uso: `node chromium_headless.js URL`

```js
const puppeteer = require('puppeteer');

const sleep = ms => new Promise(res => setTimeout(res, ms));

(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    defaultViewport: null
  });
  const page = await browser.newPage();

  await page.goto(process.argv.slice(2)[0]);

  await scrollToBottom(page);

  (async () => {
      await sleep(3000);
  })();

  const content = await page.content(); // Get the full page content

  console.log(content);  // Log the full HTML (including lazy-loaded content)


  await browser.close();
})();

async function scrollToBottom(page) {
  const distance = 100; // should be less than or equal to window.innerHeight
  const delay = 100;
  while (await page.evaluate(() => document.scrollingElement.scrollTop + window.innerHeight < document.scrollingElement.scrollHeight)) {
    await page.evaluate((y) => { document.scrollingElement.scrollBy(0, y); }, distance);
    (async () => {
        await sleep(delay);
    })();
  }
}
```

Con `alias dgg = "w3m dgg.gg"` mpv como navegador externo ya estás hecho para navegar casi toda la web.
