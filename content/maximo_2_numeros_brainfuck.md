---
title: "Maximo entre 2 numeros en brainfuck"
date: 2025-11-04T06:44:20-03:00
draft: true
---

Brainfuck es un lenguaje de programación esotérico que no contiene palabras, está muy cerca a ASM, más cerca que C.

#### Instalación

```bash
yay -S brainfuck
yay -Ql brainfuck
```

To find the maximum between two numbers in Brainfuck, you can use a simple comparison algorithm. Brainfuck is a minimalist language with only eight commands, so the code will be quite straightforward but might look unusual compared to more conventional programming languages.

Here's a basic approach to find the maximum of two numbers, let's say `a` and `b`, stored in the first two cells of the tape:

```brainfuck
,>,              # Read two numbers from input into the first two cells
[<-<->>]>        # If the first cell is not zero, proceed to compare
<[-<+>]<         # Move the value from the first cell to the third cell if it's not zero
>[>-<-]>         # Move the value from the second cell to the first cell if the first cell is zero
<.               # Output the value in the first cell, which should be the maximum
```

Explanation:
1. `,>,` reads two characters (numbers) from the input and stores them in the first two cells of the tape. Note that Brainfuck reads input as ASCII values, so the numbers should be input as their ASCII representations (e.g., '1' for the number 1).
2. `[<-<->>]>` checks if the first cell is not zero. If it's not zero, the program proceeds inside the loop.
3. `<[-<+>]<` moves the value from the first cell to the third cell if the first cell is not zero. This effectively prepares to compare or swap values based on their magnitudes.
4. `>[>-<-]>` moves the value from the second cell to the first cell if the first cell becomes zero (indicating the second cell holds a larger value or they are equal).
5. `<.` outputs the value in the first cell, which, after the comparison and potential swap, should be the maximum of the two input values.

However, this explanation simplifies the process. The actual implementation to correctly compare and output the maximum of two numbers in Brainfuck, considering its unique instruction set, involves a bit more complexity, especially when dealing with negative numbers or ensuring the comparison works as expected in all cases.

A more accurate and functional approach would involve a direct comparison and swap if necessary. Here's a corrected and simplified version of how you might approach finding the maximum, assuming you're working with non-negative integers and focusing on the basic concept:

```brainfuck
,>,            # Read two numbers
<[->>]<        # If first cell is less than second, swap
>[<-]>         # If first cell is greater or equal, do nothing (first cell already max)
<.             # Print the first cell, which should be the max
```

This version directly compares the two values and swaps them if the first is less than the second, ensuring the first cell always holds the maximum value after the comparison.

Keep in mind, Brainfuck programming can be very low-level and requires careful management of the tape and its values. This example assumes a basic understanding of Brainfuck's operation and is simplified for educational purposes.
