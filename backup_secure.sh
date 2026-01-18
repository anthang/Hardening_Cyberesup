#!/bin/bash
set -euo pipefail
umask 0077

log="backup.log"
readonly log

date=$(date "+%Y-%m-%d_%H-%M-%S")
readonly date

trap 'echo "ERREUR (ligne $LINENO)" >> "$log"' ERR
trap 'echo " FIN" >> "$log"' EXIT
echo " DEBUT" >> "$log"

if [[ "$EUID" -eq 0 ]]; then
  echo "execution root impossible" | tee -a "$log" >&2
  exit 1
fi


nf=$(ls -1 Backup_etc_*.tar.gz 2>/dev/null | wc -l)
readonly nf

if [[ "$nf" -gt 7 ]]; then
  lf=$(ls -1tr Backup_etc_*.tar.gz | head -n 1)
  rm -f "$lf"
  echo "suppression du fichier : $lf" | tee -a "$log"
fi

sudo tar -czf "Backup_etc_${date}.tar.gz" /etc

echo "Creation du .gz : Backup_etc_${date}.tar.gz" | tee -a "$log"
