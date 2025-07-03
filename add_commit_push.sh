#!/bin/sh
if [ $# -eq 0 ]
  then
    echo "Poné el mensaje del commit como primer argumento"
    exit;
fi

hugo &&
cp -R the-files/* public/ &&
git add . &&
git commit -m "$1" &&
git push &&
cd public &&
git add . &&
git commit -m "$1" &&
git push
