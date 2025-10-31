---
title: "Web 1.0: Centralizar texto sin CSS con tablas"
date: 2025-10-31T15:52:14-03:00
---
Te enseño como crear una Web 1.0.

El texto aparece centrado hasta en navegadores de consola como w3m, chawan, elinks.

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
<link rel="stylesheet" href="style.css" />
  <title>Andres Imlauer</title>
</head>
<body style="margin:0; padding:0;">


  <!-- Outer table for screen-level centering -->
  <table width="100%" height="100%" border="0">
    <tr>
      <td align="center" valign="middle">
        <!-- Inner table for the 50% width content -->
        <table width="50%" border="1">
          <tr>
            <td align="center">
              <header>
              <h1 class="title">Andres Imlauer’s Personal Page</h1>
              </header>
              <p>I was born in Argentina. I studied Computer Science from <a
              href="https://dcc.fceia.unr.edu.ar/es/lcc/materias">Universidad Nacional
              de Rosario(Spanish)</a>. I once found a SQL Injection vulnerability on
              the old website. Now I’m studying electricity.</p>
              <p>My online nicknames are esotericwarfare, atavistic11.</p>
              <p>This site works best without JavaScript. Please consider downgrading
              to a less modern browser. I shit on your privacy.</p>
              <p>Here is a photo of <strong><a href="https://ibb.co/d4zGhCTT">me</a></strong>.</p>
              <hr />
              <h2>Some facts:</h2>
              <ul>
              <li>I used to study computer science but dropped it.<br />
              </li>
              </ul>
              <hr />
              <p>Andres Imlauer / <a href="mailto:necro@tfwno.gf">necro@tfwno.gf</a>.</p>
              <p>This website was inspired by <a href="http://www.tastyfish.cz">TastyFish</a>.<br />
              <hr />
              <p>No rights reserved - <a href="https://denshi.org/blog/copying-is-cool/">Copying is cool</a>.
              2025.</p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
```

Ahora si queres fondo negro y letras verdes necesitaras CSS:

```css
body {
  line-height: 1.6;
  color: #04ff04;
  background: #000;
  font-family: monospace;
  text-align: justify;
  font-size: 18px;
}

h1, h2, h3, h4 {
  color: #04ff04;
  margin-top: 1.5em;
}

a {
  color: yellow;
  text-decoration: underline;
}

a:hover {
  text-decoration: underline;
}

hr { border-color: green; }
```
