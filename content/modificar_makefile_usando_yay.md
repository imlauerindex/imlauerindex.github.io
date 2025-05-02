---
title: "Modificar Makefile usando yay"
date: 2025-05-02T16:22:12-03:00
tags: ['linux']
---
1. **Download the build files without installing**:
   ```bash
   yay -G libgbinder
   ```
2. **Navigate into the package directory**:
   ```bash
   cd libgbinder
   ```
3. **Modify the Makefile**:
   Look for the **Makefile** in the source directory. You'll need to wait until the sources are extracted:

   ```bash
   makepkg -o
   ```
   This will **download and extract** the source files **without building**, so you can modify them.
4. **Edit the Makefile**:
   Now go into the extracted source directory (usually inside `src/`):

   ```bash
   cd src/libgbinder-<version>
   ```

   ```bash
   vim Makefile
   ```
   Make your changes and save.

5. **Build the package**:
   Go back to the main package directory:

   ```bash
   cd ../../
   makepkg -si
   ```
