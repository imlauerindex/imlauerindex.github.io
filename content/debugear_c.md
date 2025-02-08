---
title: "Debuggear c con GDB"
date: 2025-02-08T02:22:43-03:00
tags: ['c']
---
```bash
gcc -ggdb find_length_string.c -o  find_length_string
gdb -q ./find_length_string
break main
run
n
n
n
...
```
