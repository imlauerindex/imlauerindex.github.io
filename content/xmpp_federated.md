---
title: "Federated. ¿Que es?"
date: 2025-10-15T21:55:08-03:00
---

El término federated (federado) se usa en tecnología para describir sistemas distribuidos que cooperan entre sí sin depender de un servidor central.
Cada nodo (servidor, usuario, instancia) mantiene su independencia, pero se comunica con los demás mediante protocolos comunes.

##### Por ejemplo:

* En lugar de un único servidor que maneja todo (como Facebook o Gmail),

* En un sistema federated hay muchos servidores independientes que se entienden entre sí.

## 💬 Qué es *Federated XMPP Chat*

**XMPP** (Extensible Messaging and Presence Protocol) es un protocolo abierto de mensajería instantánea — el **mismo que usaban Google Talk y Jabber**.
Y **“Federated XMPP chat”** significa que:

> Es un sistema de chat en el que **cada servidor es independiente**, pero **todos pueden comunicarse entre sí** mediante el protocolo **XMPP**.

En otras palabras, es como el **correo electrónico**, pero para mensajes instantáneos:

* Vos podés tener tu cuenta `@tuservidor.com`,
* Otra persona tiene la suya en `@otroservidor.net`,
* Y ambos pueden hablar sin depender de una empresa central.

---

### 🏗️ Cómo funciona

* Cada **servidor XMPP** (por ejemplo, ejabberd, Prosody o Openfire) aloja cuentas de usuarios.
* Los servidores se **federan** (interconectan) mediante **federation**, es decir, confían y se comunican entre sí usando el mismo protocolo (XMPP sobre TCP o TLS).
* Los **clientes XMPP** (como Gajim, Dino, Conversations, o Pidgin) se conectan al servidor del usuario.

---

### 🔁 Ejemplo de federación XMPP

1. Alumno tiene una cuenta:

   ```
   alumno@chat.miempresa.com
   ```
2. Otro usuario tiene una cuenta:

   ```
   compañera@xmpp.libre.im
   ```
3. Ambos pueden chatear **aunque estén en servidores diferentes**, igual que con el correo electrónico.

Así, cada servidor mantiene su propia base de datos de usuarios, pero **todos son parte de una red federada global de XMPP**.

---

## 🧩 Ejemplos de tecnologías **federadas**

| Tipo                      | Tecnología                                                      | Descripción                                                                          |
| ------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| 💬 Mensajería instantánea | **XMPP (Jabber)**, **Matrix**                                   | Chats entre servidores distintos, sin control central.                               |
| 📧 Correo electrónico     | **SMTP, IMAP, POP3**                                            | Clásico ejemplo de red federada.                                                     |
| 🐘 Redes sociales         | **Mastodon**, **Pleroma**, **Misskey**, **Lemmy**, **PeerTube** | Usan el protocolo **ActivityPub**, y forman el **Fediverse**.                        |
| 🧾 Autenticación          | **OAuth 2.0**, **SAML**, **OpenID Connect**                     | Federan identidad: un usuario inicia sesión en varios servicios con la misma cuenta. |
| 📚 Documentos y archivos  | **Nextcloud Federation**, **Seafile Federation**                | Permiten compartir archivos entre distintos servidores Nextcloud.                    |
| 🔢 Bases de datos         | **MySQL Federated Engine**, **CockroachDB**, **Cassandra**      | Distribuyen o federan datos entre nodos independientes.                              |

---

## 🧠 En resumen

* **Federated XMPP chat** = red de mensajería descentralizada basada en el protocolo XMPP.
* Cada servidor es independiente, pero todos pueden comunicarse.
* Es la alternativa **libre y federada a sistemas centralizados como WhatsApp o Discord**.


