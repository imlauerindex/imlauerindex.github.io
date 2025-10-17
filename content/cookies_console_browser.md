---
title: "Loading cookies from Falkon into a console web-browser"
date: 2025-10-17T15:24:32-03:00
tags: ['console']
---

```bash
cp ~/.config/falkon/profiles/default/Cookies /tmp/falkon_cookies.sqlite
```

```bash
sqlite3 -separator $'\t' -noheader /tmp/falkon_cookies.sqlite "SELECT host_key,
 CASE WHEN host_key LIKE '.%' THEN 'TRUE' ELSE 'FALSE' END,
 path,
 CASE WHEN is_secure=1 THEN 'TRUE' ELSE 'FALSE' END,
 CAST((expires_utc/1000000.0 - 11644473600) AS INTEGER),
 name,
 value
FROM cookies;" > ~/cookies_netscape.txt
```

```bash
curl -v -L -b ~/cookies_out.txt -c ~/cookies_out.txt "https://asdf.com.ar/" -o /tmp/forum.html && w3m /tmp/forum.html
curl -v -L -b ~/cookies_out.txt  "https://asdf.com.ar/" -o /tmp/forum.html && w3m /tmp/forum.html
```

