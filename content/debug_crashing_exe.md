---
title: "Debug crashing binary en Windows con WinDbg"
date: 2025-11-02T14:49:49-03:00
tags: ['exe']
---

https://www.youtube.com/embed/wdHLuB4lkgg


### 1️⃣ Preparar el entorno

* **Modo de depuración:** Usa una cuenta con permisos de administrador si es posible.
* **Desactiva antivirus temporalmente** para descartar que esté bloqueando el juego.
* **Modo de compatibilidad:** A veces ejecutar en modo Windows 7/8 ayuda, pero para debug profundo no es crítico.

---

### 2️⃣ Usar un depurador en Windows

#### a) **WinDbg (de Microsoft)**

1. Instala **WinDbg** desde el [Windows SDK](https://learn.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk).
2. Abre WinDbg → `File → Open Executable`.
3. Selecciona el `.exe` del juego.
4. WinDbg lanzará el juego y podrás ver **excepciones**, **fallos de memoria**, o errores de librerías.
5. Usa `!analyze -v` después de un crash para obtener un stack trace detallado.

#### b) **Visual Studio**

Si tienes Visual Studio:

1. Abre **Visual Studio → File → Open → Project/Solution → select EXE**.
2. Ve a **Debug → Start Debugging (F5)**.
3. Cuando el juego falle, Visual Studio mostrará la línea exacta y call stack (si los símbolos están disponibles).

#### c) **Depuración ligera / logs**

* A veces los juegos generan **logs internos** en:

  * `C:\Users\<usuario>\AppData\Local\<Juego>\`
  * Carpeta del juego (`logs`, `crashdumps`)
* Activar **modo ventana** o agregar flags tipo `-debug` puede generar más información.

---

### 3️⃣ Usar herramientas externas

* **Process Monitor (ProcMon)**: rastrea acceso a archivos y registro, útil si el juego falla al cargar algo.
* **Dependency Walker**: identifica DLL faltantes que pueden provocar cierre inmediato.
* **Dr. Memory / AddressSanitizer**: detecta corrupciones de memoria, si el juego es compatible con depuración nativa.

---

### 4️⃣ Símbolos y stack traces

* Para ver **llamadas de función humanas**, necesitas símbolos (`.pdb`) del juego.
* Sin símbolos, aún puedes ver direcciones de memoria y DLLs implicadas.

---

### 5️⃣ Estrategia rápida de prueba

1. Ejecuta en CMD y observa errores impresos:

   ```cmd
   "C:\ruta\al\juego.exe"
   ```

   A veces sale un mensaje en consola antes de cerrar.
2. Habilita **crash dumps automáticos**:

   ```reg
   Windows Registry → HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting
   ```

   Así podrás abrir el dump con WinDbg.

---

💡 **Tip práctico:** Si quieres algo rápido sin WinDbg, puedes usar **x64dbg** (free, open source) para attach al juego, ejecutar y ver exactamente dónde falla.

---

Si quieres, puedo hacer una **guía concreta paso a paso con x64dbg** para abrir el binario del juego y capturar el crash, lista para principiantes en depuración de juegos en Windows.

¿Quieres que haga eso?

