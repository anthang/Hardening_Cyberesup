#!/bin/bash
set -euo pipefail
umask 0077



date=$(date "+%Y-%m-%d_%H-%M-%S")
readonly date
nf=$(ls -l | wc -l)
readonly nf
if [[ "$EUID" -eq 0 ]]; then
  echo "execution root impossible"
  exit 0
fi

if [[ "$nf" -gt 7 ]]; then
   lf=$(ls -1tr *.gz | head -n 1)
   rm -f "$lf"
   printf 'suppression du fichier : %s\n'  "$lf"
   trap 'printf "tout s'\''est mal passe\n"' ERR 
fi

tar -czf "Backup_etc_${date}.tar.gz" .
printf 'Creation du .gz : Backup_etc_%s.tar.gz\n' "$date"



trap 'printf "tout s'\''est bien passe\n"' EXIT
