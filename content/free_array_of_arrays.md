---
title: "Free array of arrays"
date: 2025-02-08T18:44:48-03:00
tags: ['c']
---
No podes "liberar" un arreglo de arreglos. Tenés que liberar todo lo que fue creado con malloc.

### Ejemplo
```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int main(){
  FILE *f = fopen("/tmp/asdf", "r+");
  if ( f == NULL ){
    printf("%s\n",strerror(errno));
    return -1;
  }
  char *palabra = malloc(30*sizeof(char));

  char **texto = malloc(sizeof(char*));
  int cantidad_palabras = 0;
  while ( fscanf(f, "%30s", palabra) == 1 ){
    puts(palabra);
    texto[cantidad_palabras] = malloc(30*sizeof(char));
    strncpy(texto[cantidad_palabras], palabra, 30);
    cantidad_palabras++;
    texto = realloc(texto, (cantidad_palabras+1)*sizeof(char*));
  }

  printf("Palabras cargadas: \n");
  for (int i = 0; i < cantidad_palabras; i++){
    printf("%s\n",texto[i]);
  }
  printf("Cantidad de palabras leídas: %d\n",cantidad_palabras);

  free(palabra);
  for (int i = 0; i < cantidad_palabras; i++){
    free(texto[i]);
  }
  free(texto);

	return 0;
}
```

https://stackoverflow.com/questions/33170802/c-does-freeing-an-array-of-pointers-also-free-what-theyre-pointing-to
