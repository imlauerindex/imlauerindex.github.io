---
title: "Ejecutar un LLM con archivos Kiwix"
date: 2025-11-22T19:44:13-03:00
---
Below is a practical “menu” of the three most common ways people are combining local LLMs and Kiwix ZIM files today.  Pick the style that matches your hardware, patience, and privacy needs.

-------------------------------------------------
1.  One-command plug-in (lightweight, no RAG)
-------------------------------------------------
Install the official “llm-tools-kiwix” plug-in inside the same Python environment as the `llm` CLI tool (works with any local model that `llm` can see, e.g. Llamafile, Ollama, LM-Studio, etc.).

```bash
# 1. Install the plug-in
pip install llm-tools-kiwix      # or: llm install llm-tools-kiwix

# 2. Drop your .zim files in the folder where you will run commands
#    (or export KIWIX_HOME=/path/to/zim/folder)

# 3. Ask anything – the LLM automatically searches the ZIMs for you
llm -m deepseek-r1:7b --tool kiwix_search_and_collect \
  "Explain how a transistor works" --tools-debug
```

-  No vector DB, no GPU needed, instant start-up.  
-  The LLM receives the raw article text as context, so keep prompts concise or choose a model with a big context window.  
-  Works completely offline once the ZIMs are on disk .

-------------------------------------------------
2.  Full RAG pipeline (best answers, needs RAM/CPU)
-------------------------------------------------
Clone the “zim-llm” project.  It extracts every article from the ZIMs, chunks them, creates embeddings, and stores them in Chroma/FAISS so a local LLM can do retrieval-augmented generation.

```bash
# 1. Clone & install
git clone https://github.com/rouralberto/zim-llm.git
cd zim-llm && ./setup.sh          # creates venv + installs libzim, sentence-transformers, langchain, etc.

# 2. Drop ZIM files into zim_library/
curl -L -o zim_library/en_wiki.zim "https://download.kiwix.org/zim/wikipedia_en_all_maxi.zim"

# 3. Build the vector index (one-time, hours for big ZIMs)
source zim_rag_env/bin/activate
python zim_rag.py build

# 4. Chat with your offline archive
python zim_rag.py rag-query "Compare Newton’s and Leibniz’s notation for calculus"
```

-  First build is CPU-heavy; afterwards queries are ~1 s.  
-  Works with any LLM LangChain can call (Ollama, Llama-cpp, Transformers, etc.).  
-  Keeps every answer grounded in the exact articles it retrieved .

-------------------------------------------------
3.  MCP server route (nice GUI, LM-Studio / OpenWebUI)
-------------------------------------------------
If you prefer point-and-click, run an MCP (Model-Context-Protocol) server that exposes the ZIMs as tools your chat GUI can call.

```bash
pip install openzim-mcp
mkdir ~/zim-files && cd ~/zim-files
# (download a small .zim first, e.g. wikipedia_en_simple)

# start the server
openzim-mcp --mode simple ~/zim-files
```

Then in LM-Studio (or any MCP client) add a new MCP server pointing to `http://localhost:8000` and tick the “search_with_filters” tool.  From now on you can simply ask questions in the chat and the LLM will transparently pull the relevant Wikipedia articles from your local ZIM file .

-------------------------------------------------
Quick checklist of ingredients
-------------------------------------------------
-  Kiwix ZIM files – get them from https://library.kiwix.org or the torrent feeds.  
-  Local LLM – easiest via Ollama (`ollama pull llama3.1:8b`) or LM-Studio.  
-  (Optional but handy) GPU with 8 GB+ VRAM if you want >10 tokens/s on 7–13 B models.  
-  Disk: 100 GB+ if you plan to store Wikipedia + Stack-Exchange + LibreTexts, etc.

Pick one of the three recipes, keep everything on localhost, and you have a completely private, off-grid “AI Internet” running on your own hardware.
