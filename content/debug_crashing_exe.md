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


When a game closes by itself in **Windows 10** with no error message, you can debug it by checking logs, system resources, and drivers. Here's a step-by-step troubleshooting + debugging method:

---

## ✅ **1. Check Windows Event Viewer (Crash Logs)**

1. Press **Win + R**
2. Type: `eventvwr.msc`
3. Go to:

   ```
   Windows Logs → Application
   ```
4. Look for **Error** entries around the time of the crash (usually Application Error).

Common faulting modules:

| Module                   | Meaning                |
| ------------------------ | ---------------------- |
| `nvlddmkm.dll`           | NVIDIA driver crash    |
| `atidxx64.dll`           | AMD GPU driver crash   |
| `d3d11.dll` / `dxgi.dll` | DirectX crash          |
| `ucrtbase.dll`           | VC++ runtime crash     |
| `ntdll.dll`              | Windows internal error |

Tell me what you find there if you want help reading it.

---

## ✅ **2. Run the game with Debug Logging**

Some games support launch options like:

* `-log`
* `-debug`
* `-d3d11` / `-dx12`

You can also enable **Windows crash logs**:

1. Search *Windows Reliability Monitor*
2. See game crash history
3. Click **View Technical Details**

---

## ✅ **3. Update / Reinstall Graphics Drivers**

For NVIDIA:

```
Download from NVIDIA → Clean Install
(Optional) Use DDU in Safe Mode
```

For AMD:

```
Use AMD Cleanup Utility + latest driver
```

---

## ✅ **4. Check Missing Runtime Libraries**

Install/reinstall:

### Microsoft Visual C++ Redistributables

[https://aka.ms/vs/17/release/vc_redist.x64.exe](https://aka.ms/vs/17/release/vc_redist.x64.exe)
[https://aka.ms/vs/17/release/vc_redist.x86.exe](https://aka.ms/vs/17/release/vc_redist.x86.exe)

### DirectX Runtimes

[https://www.microsoft.com/en-us/download/details.aspx?id=8109](https://www.microsoft.com/en-us/download/details.aspx?id=8109)

### .NET Framework

Windows Update usually installs this.

---

## ✅ **5. Check GPU / CPU / RAM Health**

### **GPU / CPU Temps**

Use **MSI Afterburner** / **HWInfo**

* GPU should be < 85°C
* CPU < 90°C

### **RAM Test**

Run:

```
mdsched.exe
```

---

## ✅ **6. Disable Overlays & Background Apps**

Turn off:

* Discord overlay
* Steam overlay
* Xbox Game Bar
* MSI Afterburner OSD
* GeForce Experience overlay

---

## ✅ **7. Try Compatibility / Admin Mode**

Right-click game EXE → **Properties**:

* Run as administrator
* Disable fullscreen optimizations
* Compatibility mode Windows 7/8 (only sometimes helps)

---

## ✅ **8. Check Game Folder Integrity**

Steam:

```
Steam → Game → Properties → Verify Integrity of Files
```

Epic:

```
Library → three dots → Verify
```

---

## ✅ **9. Memory Leak / VRAM Debug**

Open **Task Manager → Performance Tab**

Watch:

* GPU memory usage
* CPU usage
* RAM usage

If a resource spikes then game dies → that's your culprit.

---

## ✅ If It Still Crashes — Advanced Debugging

### Windows Debugging Tools

Install:

```
Windows SDK → Debugging Tools for Windows
```

Run:

```
WinDbg (Preview)
```

Load crash dump from:

```
C:\Windows\Minidump
```

If you want, tell me the game's crash `.dmp` file results and I'll interpret them.

---

## ✅ Tell me what info you want to provide:

Reply with any of these:

### ⬜ Event Viewer error text

### ⬜ Reliability Monitor details

### ⬜ GPU / CPU temps

### ⬜ Game name & launcher (Steam/Epic/etc.)

### ⬜ Specs (CPU, GPU, RAM)

### ⬜ Crash dump file (I'll help read it)

---

If you want, I can give you:

* **WinDbg command guide**
* A **script to monitor real-time crash logs**
* **Anti-cheat crash troubleshooting** (Valorant, Apex, CS2, etc.)

---

Want to start with the **Event Viewer crash logs**? Paste them here 👇

