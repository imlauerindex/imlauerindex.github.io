#!/usr/bin/fish
sudo systemctl start smb
# https://imlauera.github.io/publicar_audio_como_video/
# thumbnailg "titulo" titulo.png
# ffmpeg -i image.jpg -i audio.mp3 -c:v libx264 -tune stillimage -c:a copy out.mp4
# youtube-upload
### Agregar para detectar tmux
# firefox blogger.com
# firefox vocaroo.com/upload
# firefox archive.org/upload

if test (count $argv) -lt 6
    echo "Usage: script.fish <url_de_blogger> <nombre_archivo(electricidad4)> <tag> <descripcion> <short_description_youtube> <archivo_audio_path>"
    exit 1
end

set URL $argv[1]
set titulo $argv[2]
set tag $argv[3]
set descripcion $argv[4]
set short_description $argv[5]
set archivo_audio_path $argv[6]

echo "✅ URL: $URL"
echo "✅ Título: $titulo"
echo "✅ Tag: $tag"
echo "✅ Descripción: $descripcion"
echo "✅ Descripción thumbnail: $short_description"
echo "✅ Archivo de audio: $archivo_audio_path"

echo -e "\nGenerando el articulo...."

cd $HOME/projects/blog;
hugo new "$titulo.md"
sed -i 's/draft: true/tags: ['$tag']/g' "$HOME/projects/blog/content/$titulo.md"
echo "$descripcion" >> "$HOME/projects/blog/content/$titulo.md"
#chromium --headless=new "$URL" --disable-gpu --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | grep -oP 'img[^>]*src="\K[^"]+' > "/tmp/$titulo_images.md"

#chromium --headless "$URL" --disable-gpu --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 --window-size=800,600 | grep -oP 'img[^>]*src="\K[^"]+' > "/tmp/$titulo.md"
curl -s "$URL" | grep -oP 'img[^>]*src="\K[^"]+' > "/tmp/$titulo.md"


sed -i 's/^/![](/' /tmp/$titulo.md
sed -i 's/$/)/' /tmp/$titulo.md

# chromium --headless=new "$URL" --disable-gpu --run-all-compositor-stages-before-draw --dump-dom --virtual-time-budget=10000 | grep -oP 'img[^>]*src="\K[^"]+' >> "$HOME/projects/blog/content/$titulo.md"
# cat /tmp/$titulo_images.md >> "$HOME/projects/blog/content/$titulo.md"

#tail -n +3 /tmp/$titulo.md >> "$HOME/projects/blog/content/$titulo.md"
cat /tmp/$titulo.md >> "$HOME/projects/blog/content/$titulo.md"

#### Imágenes de alta calidad
sed -i 's/s320/s4160/g' "$HOME/projects/blog/content/$titulo.md"


echo "Generamos thumbnail para youtube"
echo "Gerando thumbnail..."
thumbnailg $short_description /tmp/$titulo.png
echo "Ingresa ubicación completa de archivo de audio m4a de la clase"
echo "Creando un video a partir del audio..."
ffmpeg -i /tmp/$titulo.png -i $archivo_audio_path -c:v libx264 -tune stillimage -c:a copy /tmp/$titulo.mp4

source $HOME/youtube-upload/bin/activate.fish 
$HOME/youtube-upload/youtube-upload/bin/youtube-upload \
  --title="$titulo" \
  --description="$descripcion" \
  #--category="Science" \
  --tags="$tags" \
  --recording-date="2011-03-10T15:32:17.0Z" \
  --default-language="es" \
  --default-audio-language="es" \
  #--client-secrets="my_client_secrets.json" \
  #--credentials-file="my_credentials.json" \
  #--playlist="My favorite music" \
  --privacy="unlisted" \
  --embeddable=True \
  /tmp/$titulo.mp4


rm /tmp/$titulo.png
rm /tmp/$titulo.mp4
