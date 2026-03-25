#!/bin/bash

export FILENAME="documento"
repetir=true

while $repetir
do

echo ""
echo "=================EJERCICIO PRACTICO 1================="
echo "Elija una de las opciones:"
echo "1) Crea el entorno"
echo "2) Corre el proceso"
echo "3) Lista por numero de padron"
echo "4) Muestra las 10 notas mas altas"
echo "5) Muestra los datos del alumno segun padron ingresado"
echo "6) Eliminar el entorno creado"
echo "7) Salir"
echo ""
read op

case $op in
1)
echo "Elegiste la opcion 1. Se va a verificar si ya existe el entorno; Si existe, lo elimina. Si no, lo crea."
echo ""

if [ -d "$HOME/EPNro1" ]; then
echo "El directorio ya existe. Eliminando."
rm -rf "$HOME/EPNro1"
else
echo "El directorio no existe."
fi

echo "Creando el entorno."
mkdir -p "$HOME/EPNro1"
mkdir -p "$HOME/EPNro1/entrada"
mkdir -p "$HOME/EPNro1/salida"
mkdir -p "$HOME/EPNro1/procesado"
touch "$HOME/EPNro1/salida/${FILENAME}.txt"
cp "$HOME/Desktop/TP-Bash/alumnos.txt" "$HOME/EPNro1/entrada"

echo "Entorno creado."
echo ""
;;

2)
echo "Elegiste la opcion 2"
if [ -d "$HOME/EPNro1" ]; then
cp "$HOME/Desktop/TP-Bash/consolidar.sh" "$HOME/EPNro1"
bash "$HOME/EPNro1/consolidar.sh" &
echo "Se esta corrienndo el proceso en background."
else
echo "Primero presione la opcion 1. "
fi
;;

3)

if [ -f "$HOME/EPNro1/salida/${FILENAME}.txt" ]; then
echo "Elegiste la opcion 3. Se va a mostrar por pantalla el listado de alumnos ordenado por numero de padron:"
echo "El archivo ${FILENAME}.txt existe. La lista: "
sort -n "$HOME/EPNro1/salida/${FILENAME}.txt"
else
echo "Selecciona la opcion 1 primero."
fi
echo ""
;;

4)

if [ -f "$HOME/EPNro1/salida/${FILENAME}.txt" ]; then
echo "Elegiste la opcion 4. Se va a mostrar las 10 notas mas altas:"
sort -k5 -nr "$HOME/EPNro1/salida/${FILENAME}.txt" | head -10
echo ""
else
echo "Selecciona la opcion 1 primero"
fi
;;

5)
if [ -d "$HOME/EPNro1" ]; then
echo "Elegiste la opcion 5. Se va a mostrar los datos del alumno segun el padron ingresado:"
echo "Ingrese el padron: "
read padron
resultado=$( grep "$padron" "$HOME/EPNro1/salida/${FILENAME}.txt" )

if [ -n "$resultado" ]; then
echo "$resultado"
else
echo "El padron no existe"
fi

echo ""

else
echo "Primero seleccione la opcion 1."
fi

;;

6)
if [ -d "$HOME/EPNro1" ]; then
echo "El directorio existe. Eliminando."
pkill -f consolidar.sh
rm -rf "$HOME/EPNro1"
else
echo "El directorio no existe."
fi
;;

7)
echo "Elegiste la opcion 7"
echo "Saliendo"
echo ""
repetir=false
;;

esac


done
