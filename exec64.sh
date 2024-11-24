#!/bin/bash

# parametrer -> path to file
path=$1

# Verifica se o parâmetro foi passado
if [ -z "$path" ]; then
  echo "Por favor, forneça o caminho do arquivo!"
  exit 1;
fi

path_without_ext="${path%.*}"

path_out="${path_without_ext}.o"

as -o "$path_out" "$path"

ld -o $path_without_ext $path_out

echo ""
echo ""


./$path_without_ext


rm $path_without_ext
rm $path_out