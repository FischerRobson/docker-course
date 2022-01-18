#!/bin/bash
# echo "Iniciando o container"
if [ -z $1 ]
then
    echo "Iniciando o container sem parametros"
else
    echo "Iniciando com $1"
fi