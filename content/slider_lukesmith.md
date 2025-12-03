---
title: "Generate videos cli"
date: 2025-12-02T02:03:33-03:00
---
Sacá las fotos horizontales, grabá el audio (despues de grabar el audio subi el volumen con ffmpeg 4 veces mas el comando esta en la publicacion interesantes-comandos), disponé de espacio disponible.

Subí el audio a youtube esto lo hago usando un script para agregar una imagen al audio porque no se puede subir audios a youtube y descargá los subtítulos usando esto: [https://imlauera.github.io/srt_to_txt/](https://imlauera.github.io/srt_to_txt/)

El archivo para subir audios a youtube está en este blog (crear blog post) se llama.

```bash
yt-dlp --ignore-config --write-subs --write-auto-sub --sub-lang es --sub-format "srt" --skip-download https://www.youtube.com/watch?v=VIDEO_ID
sed -E '/^[0-9]+$|^$/d; /^[0-9]{2}:/d' video.en.srt > subtitles.txt
```

Ahora copiá y pegá los subtitulos por partes a ChatGPT y pedile que haga un resumen luego guardalos en un archivo llamado `chatgpt.txt`.

Ahora generamos el audio, podes usar piper-tts.

```bash
cat chatgpt.txt | espeak-ng -v es -w rock.wav
ls *.jpg | sort | ./slider_gen_timestamps.sh > video
./slider -i video -a rock.wav
```

**Lo haremos usando el script de LukeSmith: `slider`.**


### Agarré la transcripción del audio lo tire a chatgpt y lo pasé a `cat chatgpt.txt | espeak-ng -v es -w rock.wav` que me generó un archivo de audio y luego se lo pasé a `slider`.

Primero grabá el audio y después ajustá los timestamp para la longitud de ese audio.

#### Tenes que pasar el archivo de audio con `-a` de lo contrario tirará un error, más abajo explico como solucionarlo.

```bash
$ ./slider
Give an input file with -i.
The file should look as this example:

00:00:00        first_image.jpg
00:00:03        otherdirectory/next_image.jpg
00:00:09        this_image_starts_at_9_seconds.jpg
etc...

Timecodes and filenames must be separated by Tabs.
```

Tuve que cambiar

```bash
case "$(file --dereference --brief --mime-type -- "$audio")" in
	audio/*) ;;

```

a

```bash
case "$(file --dereference --brief --mime-type -- "$audio")" in
	video/*) ;;

```

Porque no me tomaba m4a como un archivo de audio.


El script tiene un problema y no me permite generar videos **sin audio** porque el `video.prep` generaba un valor negativo entonces hice lo siguiente

```bash
cd .cache/slider/mi_video
```

Y acá están las imágenes generadas por magick con la resolución corregida.

Entonces edito el archivo video.prep arreglo el tiempo negativo del último archivo y ejecuté:

```bash
ffmpeg -hide_banner -y -f concat -safe 0 -i "video.prep" -fps_mode vfr -c:v libx264 -pix_fmt yuv420p "video.mp4"
```
Y dejo el ultimo nombre archivo sin nada abajo


##### Lo podes conseguir clonando su repo (mas abajo pegue el codigo del script)

```
git clone https://github.com/lukesmithxyz/voidrice
cd .local/bin/
./slider
```

Cambie esto en el codigo: `-vsync vfr` lo reemplace por `-fps_mode vfr`.

---

#### Esto te sirve para generar los timestamps (una imagen cada 20 segundos) lo guarde como `slider_gen_timestamps.sh`.

```bash
#!/bin/bash

# Usage: ./gen_timestamps.sh *.jpg
# or:    ls *.jpg | sort | ./gen_timestamps.sh

sec=0

while read -r file; do
    # Format seconds → HH:MM:SS
    timestamp=$(printf "%02d:%02d:%02d" $((sec/3600)) $(((sec/60)%60)) $((sec%60)))

    printf "%s\t%s\n" "$timestamp" "$file"

    # Add 20 seconds for next file
    sec=$((sec + 3))
done
```

#### Ahora en la carpeta en donde tengas todas las imagenes ejecuta:

```bash
ls *.jpg | sort | ./slider_gen_timestamps.sh > video
```

#### Ahora creamos el video:

```bash
./slider -i video -a audio.mp3
```

Si el audio es m4a tendras que hacer una ligera modificacion en el codigo que expliqué en este mismo articulo más arriba.

#### Slider

```bash
#!/bin/sh

# Give a file with images and timecodes and creates a video slideshow of them.
#
# Timecodes must be in format 00:00:00.
#
# Imagemagick and ffmpeg required.

# Application cache if not stated elsewhere.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/slider"

while getopts "hvrpi:c:a:o:d:f:t:e:x:s:" o; do case "${o}" in
	c) bgc="$OPTARG" ;;
	t) fgc="$OPTARG" ;;
	f) font="$OPTARG" ;;
	i) file="$OPTARG" ;;
	a) audio="$OPTARG" ;;
	o) outfile="$OPTARG" ;;
	d) prepdir="$OPTARG" ;;
	r) redo="$OPTARG" ;;
	s) ppt="$OPTARG" ;;
	e) endtime="$OPTARG" ;;
	x) res="$OPTARG"
		echo "$res" | grep -qv "^[0-9]\+x[0-9]\+$" &&
			echo "Resolution must be dimensions separated by a 'x': 1280x720, etc." &&
			exit 1 ;;
	p) echo "Purge old build files in $cache? [y/N]"
		read -r confirm
		echo "$confirm" | grep -iq "^y$" && rm -rf "$cache" && echo "Done."
		exit ;;
	v) verbose=True ;;
	*) echo "$(basename "$0") usage:
  -i  input timecode list (required)
  -a  audio file
  -c  color of background (use html names, black is default)
  -t  text color for text slides (white is default)
  -s  text font size for text slides (150 is default)
  -f  text font for text slides (sans serif is default)
  -o  output video file
  -e  if no audio given, the time in seconds that the last slide will be shown (5 is default)
  -x  resolution (1920x1080 is default)
  -d  tmp directory
  -r  rerun imagemagick commands even if done previously (in case files or background has changed)
  -p  purge old build files instead of running
  -v  be verbose" && exit 1

esac done

# Check that the input file looks like it should.
{ head -n 1 "$file" 2>/dev/null | grep -q "^00:00:00	" ;} || {
	echo "Give an input file with -i." &&
	echo "The file should look as this example:

00:00:00	first_image.jpg
00:00:03	otherdirectory/next_image.jpg
00:00:09	this_image_starts_at_9_seconds.jpg
etc...

Timecodes and filenames must be separated by Tabs." &&
	exit 1
	}

if [ -n "${audio+x}" ]; then
	# Check that the audio file looks like an actual audio file.
	case "$(file --dereference --brief --mime-type -- "$audio")" in
		audio/*) ;;
		*) echo "That doesn't look like an audio file."; exit 1 ;;
	esac
	totseconds="$(date '+%s' -d $(ffmpeg -i "$audio" 2>&1 | awk '/Duration/ {print $2}' | sed s/,//))"
fi

prepdir="${prepdir:-$cache/$file}"
outfile="${outfile:-$file.mp4}"
prepfile="$prepdir/$file.prep"

[ -n "${verbose+x}" ] && echo "Preparing images... May take a while depending on the number of files."
mkdir -p "$prepdir"

{
while read -r x;
do
	# Get the time from the first column.
	time="${x%%	*}"
	seconds="$(date '+%s' -d "$time")"
	# Duration is not used on the first looped item.
	duration="$((seconds - prevseconds))"

	# Get the filename/text content from the rest.
	content="${x#*	}"
	base="$(basename "$content")"
	base="${base%.*}.jpg"

	if [ -f "$content" ]; then
		# If images have already been made in a previous run, do not recreate
		# them unless -r was given.
		{ [ ! -f "$prepdir/$base" ] || [ -n "${redo+x}" ] ;} &&
			magick -size "${res:-1920x1080}" canvas:"${bgc:-black}" -gravity center "$content" -resize 1920x1080 -composite "$prepdir/$base"
	else
		{ [ ! -f "$prepdir/$base" ] || [ -n "${redo+x}" ] ;} &&
			magick -size "${res:-1920x1080}" -background "${bgc:-black}" -fill "${fgc:-white}" -font "${font:-Sans}" -pointsize "${ppt:-150}" -gravity center label:"$content" "$prepdir/$base"
	fi

	# If the first line, do not write yet.
	[ "$time" = "00:00:00" ] || echo "file '$prevbase'
duration $duration"

	# Keep the information required for the next file.
	prevbase="$base"
	prevtime="$time"
	prevseconds="$(date '+%s' -d "$prevtime")"
done < "$file"
# Do last file which must be given twice as follows
endtime="$((totseconds-seconds))"
echo "file '$base'
duration ${endtime:-5}
file '$base'"
} > "$prepfile"
if [ -n "${audio+x}" ]; then
	ffmpeg -hide_banner -y -f concat -safe 0 -i "$prepfile" -i "$audio" -c:a aac -vsync vfr -c:v libx264 -pix_fmt yuv420p "$outfile"
else
	ffmpeg -hide_banner -y -f concat -safe 0 -i "$prepfile" -vsync vfr -c:v libx264 -pix_fmt yuv420p "$outfile"
fi

# Might also try:
# -vf "fps=${fps:-24},format=yuv420p" "$outfile"
# but has given some problems.
```
