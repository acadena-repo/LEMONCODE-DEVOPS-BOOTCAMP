# MODULO 01 - FUNDAMENTOS LINUX PARA CONTENEDORES

## SOLUCION A EJERCICIOS DEL MODULO

<br>

### _EJERCICIO 01_

### _`1. Crea mediante comandos de bash la siguiente jerarquía de ficheros y directorios:`_

```bash
foo/
├─ dummy/
│  ├─ file1.txt
│  ├─ file2.txt
├─ empty/
```

Donde `file1.txt` debe contener el siguiente texto:

```bash
Me encanta la bash!!
```

Y `file2.txt` debe permanecer vacío.

<hr>

### _SOLUCION 01_

```bash
mkdir foo
mkdir empty
cd foo
mkdir dummy
cd dummy
echo Me encanta la bash!! > file1.txt
touch file2.txt
```

**Screenshot Terminal**

![E1](./Static/01%20EJERCICIO-LINUX-BASH.png)

### _EJERCICIO 02_

### _`2. Mediante comandos de bash, vuelca el contenido de file1.txt a file2.txt y mueve file2.txt a la carpeta empty`_

El resultado de los comandos ejecutados sobre la jerarquía anterior deben dar el siguiente resultado.

```bash
foo/
├─ dummy/
│  ├─ file1.txt
├─ empty/
  ├─ file2.txt
```

Donde `file1.txt` y `file2.txt` deben contener el siguiente texto:

```bash
Me encanta la bash!!
```

<hr>

### _SOLUCION 02_

```bash
cd foo/dummy
cp file1.txt file2.txt
mv file2.txt ../../empty/file2.txt
```

**Screenshot Terminal**

![E2](./Static/02%20EJERCICIO-LINUX-BASH.png)

### _EJERCICIO 03_

### _`3. Crear un script de bash que agrupe los pasos de los ejercicios anteriores y además permita establecer el texto de file1.txt alimentándose como parámetro al invocarlo`_

**_Si se le pasa un texto vacío al invocar el script, el texto de los ficheros, el texto por defecto será:_**

```bash
Que me gusta la bash!!!!
```

<hr>

### _SOLUCION 03_

```bash
#!/bin/bash

# Getting text content for file1
CONTENT="Que me gusta la bash!!!!"
if [[ $# -gt 0 ]]; then
   CONTENT=$1
fi

mkdir foo
mkdir empty
mkdir foo/dummy
cd foo/dummy
echo $CONTENT > file1.txt
cp file1.txt file2.txt
mv file2.txt ../../empty/file2.txt
```

**Screenshot Terminal**

![E3](./Static/03%20EJERCICIO-LINUX-BASH.png)

### _EJERCICIO 04_

### _`4. Crea un script de bash que descargue el contenido de una página web a un fichero y busque en dicho fichero una palabra dada como parámetro al invocar el script`_

La URL de dicha página web será una constante en el script.

Si tras buscar la palabra no aparece en el fichero, se mostrará el siguiente mensaje:

```bash
$ ejercicio4.sh patata
> No se ha encontrado la palabra "patata"
```

Si por el contrario la palabra aparece en la búsqueda, se mostrará el siguiente mensaje:

```bash
$ ejercicio4.sh patata
> La palabra "patata" aparece 3 veces
> Aparece por primera vez en la línea 27
```

<hr>

### _SOLUCION 04_

```bash
#!/bin/bash

if [[ $# -lt 1 ]]; then
   echo No se encontro ningun parametro de busqueda
   exit 0
fi

curl -s -o descarga https://expansion.mx/tendencias/2017/10/20/los-50-mejores-platillos-de-todo-el-mundo

# Busqueda del parametro de entrada
nword=$(grep -i $1 descarga | wc -w)

if [[ $nword -eq 0 ]]; then
   echo No se ha encontrado la palabra $1
else
   nline=$(grep -n -i $1 descarga | head -n 1 | cut -d: -f1)

   echo La palabra $1 aparece $nword veces
   echo Aparece por primera vez en la linea $nline
fi
```

**Screenshot Terminal**

![E4](./Static/04%20EJERCICIO-LINUX-BASH.png)

### _EJERCCIO 05_

### _`5. OPCIONAL - Modifica el ejercicio anterior de forma que la URL de la página web se pase por parámetro y también verifique que la llamada al script sea correcta`_

**Si al invocar el script este no recibe dos parámetros (URL y palabra a buscar), se deberá de mostrar el siguiente mensaje:**

```bash
$ ejercicio5.sh https://lemoncode.net/ patata 27
> Se necesitan únicamente dos parámetros para ejecutar este script
```

**Además, si la palabra sólo se encuentra una vez en el fichero, se mostrará el siguiente mensaje:**

```bash
$ ejercicio5.sh https://lemoncode.net/ patata
> La palabra "patata" aparece 1 vez
> Aparece únicamente en la línea 27
```

<hr>

### _SOLUCION 05_

```bash
#!/bin/bash

# Verificar que el numero de parametros sea correcto
if [[ $# -gt 2 ]]; then
   echo Se necesitan unicamente dos parametros para ejecutar este script
   exit 0
fi

url=$1
word=$2

# Descarga del sitio web a fichero
curl -s -o descarga $url

# Busqueda del parametro de entrada
nword=$(grep -i $word descarga | wc -w)

if [[ $nword -eq 0 ]]; then
   echo No se ha encontrado la palabra "$word"
elif [[ $nword -eq 1 ]]; then
   nline=$(grep -n -i $word descarga | head -n 1 | cut -d: -f1)

   echo La palabra $word aparece $nword veces
   echo Aparece unicamente en la linea $nline
else
   nline=$(grep -n -i $word descarga | head -n 1 | cut -d: -f1)

   echo La palabra $word aparece $nword veces
   echo Aparece por primera vez en la linea $nline
fi
```

**Screenshot Terminal**

![E5](./Static/05%20EJERCICIO-LINUX-BASH.png)
