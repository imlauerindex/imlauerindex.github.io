---
title: "Install_searx"
date: 2025-11-15T17:18:02-03:00
draft: true
---
git clone https://github.com/searxng/searxng.git && cd searxng && make run (Instalará todas las dependencias dentro de un virtualenv)

Podes modificar la configuración con el archivo `settings.yml`

   Clone SearXNG Docker setup
   $ git clone https://github.com/searxng/searxng-docker.git && cd searxng-docker &&
   ls -la
   ↪ 20 lines...


   Configure hostname for localhost
   $ cd searxng-docker && sed -i "s/^\(SEARXNG_HOSTNAME=\).*/\1localhost/" .env &&
   cat .env

 │ │ cd searxng-docker && sed -i "s/^\(SEARXNG_HOSTNAME=\).*/\1localhost/" .env  │ │
 │ │ && cat .env    

 │ │ cd searxng-docker && docker-compose up -d                                   │ │
 │ ╰──────────────────────────────────────────────

### Without DOCKER

  │                                                                                 │
 │ ╭─────────────────────────────────────────────────────────────────────────────╮ │
 │ │ git clone https://github.com/searxng/searxng.git && cd searxng && ls -la    │ │
 │ ╰──────────────────────────────────────

   $ cd searxng && pip3 install --user -e . && echo "Installation complete"


 │ ╭─────────────────────────────────────────────────────────────────────────────╮ │
 │ │ cd searxng && python3 -m venv venv && source venv/bin/activate && pip       │ │
 │ │ install -e . && echo "Installation complete"
 │ ╭─────────────────────────────────────────────────────────────────────────────╮ │

 │ │ cd searxng && source venv/bin/activate && pip install -r requirements.txt   │ │
 │ │ && echo "Dependencies installed"                                            │ │
 │ ╰───────────────────────────────────────────

   $ cd searxng && export SEARXNG_SETTINGS_PATH="$PWD/searx/settings.yml" && source
   venv/bin/activate && python searx/webapp.py

 │ ╭─────────────────────────────────────────────────────────────────────────────╮ │
 │ │ cd searxng && source venv/bin/activate && export                            │ │
 │ │ PYTHONPATH="$PWD:$PYTHONPATH" && export                                     │ │
 │ │ SEARXNG_SETTINGS_PATH="$PWD/searx/settings.yml" && python -m searx.webapp   │ │
 │ ╰──────────────────────────────────────────────────────────────────

    $ cat /tmp/copilot-detached-searxng.log

   Start SearXNG with proper Python path
   $ cd searxng && source venv/bin/activate && export PYTHONPATH="$PWD:$PYTHONPATH" &&
   export SEARXNG_SETTINGS_PATH="$PWD/searx/settings.yml" && python -m searx.webapp
   ↪ 1 line...
   $ cat /tmp/copilot-detached-searxng2.log
   ↪ 2 lines...


 ○ Generate and set secret key
   $ cd searxng && sed -i 's/ultrasecretkey/'"$(openssl rand -hex 32)"'/g'
   searx/settings.yml && grep secret_key searx/settings.yml | head -1


 │ ╭─────────────────────────────────────────────────────────────────────────────╮ │
 │ │ cd searxng && sed -i 's/ultrasecretkey/'"$(openssl rand -hex 32)"'/g'       │ │
 │ │ searx/settings.yml && grep secret_key searx/settings.yml | head -1          │ │
 │ ╰───────────────────────────────────────────────────────────────────────


  │ ╭─────────────────────────────────────────────────────────────────────────────╮ │
 │ │ cd searxng && source venv/bin/activate && export                            │ │
 │ │ PYTHONPATH="$PWD:$PYTHONPATH" && export                                     │ │
 │ │ SEARXNG_SETTINGS_PATH="$PWD/searx/settings.yml" && python -m searx.webapp > │ │
 │ │  /tmp/searxng.log 2>&1 &





   $ sleep 2 && curl -s http://127.0.0.1:8888/ | head -20

   respecting your privacy

   To stop it later:

     pkill -f "python -m searx.webapp"

   To start it again:

     cd ~/tor/searxng
     source venv/bin/activate
     export PYTHONPATH="$PWD:$PYTHONPATH"
     export SEARXNG_SETTINGS_PATH="$PWD/searx/settings.yml"
     python -m searx.webapp

   The search engine is fully functional



#### Gemini

 │ │ git clone https://github.com/searxng/searxng.git && cd searxng && ls -la    │ │
sudo pacman --needed --noconfirm -S git python-babel python-virtualenv uwsgi uwsgi-plugin-python libxslt zlib

python -m venv searxng-venv && source searxng-venv/bin/activate.fish && make install
