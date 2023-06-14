#!/bin/bash


ARQ="alunos.txt"
COUNT=1

> $ARQ
while true; do 
   read -p "Informe o nome do aluno $COUNT ou ENTER para encerrar: " ALUNO
   [ "$ALUNO" == "" ] && break
   echo "$ALUNO" >> $ARQ
   COUNT=$((COUNT+1))


done

