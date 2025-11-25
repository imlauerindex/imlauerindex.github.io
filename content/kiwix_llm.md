---
title: "Ejecutar un LLM con archivos Kiwix offline gratis sin ChatGPT."
date: 2025-11-22T19:44:13-03:00
---

# ✅ What to do after running the script

1. Put your `.zim` files somewhere, for example:

```
~/zimfiles/
```

Or set:

```bash
export KIWIX_HOME=~/zimfiles
```

2. Run a query:

```bash
llm -m llama3.2 --tool kiwix_search_and_collect "How do I install Gentoo?"
```

The LLM will:

* Search inside your ZIM file
* Extract relevant article content
* Use **Llama 3.2 locally** to answer

No API keys needed.
No LangChain.
No internet.

Completely **offline**.

---

# 🔥 Want an even better version?

I can also generate:

* A TUI (terminal UI) browser
* A web UI
* A local RAG server
* A fully packaged Arch `PKGBUILD`

Just tell me what you want.


You want to **know how to use `llm-tools-kiwix`**, right? I’ll break it down step by step so you can get a fully working setup **without OpenAI**, using a free local model.

---

# 1️⃣ Install `llm` CLI

If you haven’t already:

```bash
python -m venv llm-tools-kiwix
pip install llm
```

or follow their [official instructions](https://github.com/rschmukler/llm).

Check it works:

```bash
llm --version
```

---

# 2️⃣ Install `llm-tools-kiwix`

```bash
llm install llm-tools-kiwix
```

Check installed tools:

```bash
llm tools list
```

You should see:

* `kiwix_search`
* `kiwix_search_and_collect`
* `kiwix_read`

---

# 3️⃣ Install a **free local LLM** (Ollama recommended)

### Step A — Install Ollama

Follow instructions for your OS: [https://ollama.com/download](https://ollama.com/download)

### Step B — Pull a free model

```bash
ollama pull llama3.2
```

### Step C — Install `llm-ollama` plugin

```bash
llm install llm-ollama
```

### Step D — Set default model

```bash
llm models set-default ollama/llama3.2
llm -m llama3.2

```

Now `llm` will use your **local LLM** instead of OpenAI.

---

# 4️⃣ Use `llm-tools-kiwix`

Make sure you have **at least one ZIM file** (e.g., Wikipedia):

```bash
llm --tool kiwix_search "Gentoo installation"
```

Or to **retrieve and read articles**:

```bash
llm --tool kiwix_search_and_collect "How do I install Gentoo"
```

You can also directly read a specific article:

```bash
llm --tool kiwix_read "Gentoo/Installation"
```

---

# 5️⃣ Notes / Tips

* By default, `kiwix_search` searches **titles only**.
* `kiwix_search_and_collect` fetches the **full article text**.
* You **don’t need any API key** if you’re using Ollama.

---

If you want, I can make a **single “copy-paste” script** that:

1. Installs `llm`
2. Installs `llm-tools-kiwix`
3. Installs Ollama and pulls a free model
4. Lets you query a ZIM file immediately

This way, you can run **one command and have it working fully offline**.

Do you want me to do that?


---



Below is a **single copy-paste script** that sets up everything you need:

✅ `llm` CLI
✅ `llm-tools-kiwix`
✅ `llm-ollama`
✅ Ollama + free model
✅ Fully offline ZIM search + LLM answering

Works on **Arch Linux** (since you’re on Arch).

---

# 🚀 **ONE-COMMAND FULL SETUP SCRIPT (ARCH LINUX)**

Copy this entire block and save it as `setup_kiwix_llm.sh`, then run:

```bash
bash setup_kiwix_llm.sh
```

---

### **📌 setup_kiwix_llm.sh**

```bash
#!/usr/bin/env bash
set -e

echo "=== Updating system ==="
sudo pacman -Sy --noconfirm

echo "=== Installing Python + pip ==="
sudo pacman -S --noconfirm python python-pip

echo "=== Installing llm CLI ==="
pip install --upgrade llm

echo "=== Installing llm-tools-kiwix ==="
llm install llm-tools-kiwix

echo "=== Installing llm-ollama backend ==="
llm install llm-ollama

echo "=== Installing Ollama ==="
# Official Arch package
sudo pacman -S --noconfirm ollama

echo "=== Starting Ollama service ==="
sudo systemctl enable --now ollama.service

echo "=== Pulling free local LLM (Llama 3.2) ==="
ollama pull llama3.2

echo "=== Setting Llama 3.2 as default llm model ==="
llm models set-default ollama/llama3.2

echo ""
echo "======================================================"
echo " Setup complete!"
echo " You can now run offline ZIM + LLM commands, for example:"
echo ""
echo '   llm --tool kiwix_search "Gentoo installation"'
echo '   llm --tool kiwix_search_and_collect "How do I install Gentoo?"'
echo ""
echo "Place your ZIM files in the current folder or set KIWIX_HOME."
echo "======================================================"
```

