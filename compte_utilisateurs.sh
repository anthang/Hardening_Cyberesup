#!/usr/bin/env bash

# Root obligatoire 
if [[ $EUID -ne 0 ]]; then
  echo "Erreur: exécute en root (ex: sudo $0)" >&2
  exit 1
fi

printf '{'

# uid 0 autre que root -
printf '"uid0_other_than_root":['
first=1
while IFS=: read -r user _ uid _ _ _ _; do
  if [[ "$uid" -eq 0 && "$user" != "root" ]]; then
    [[ $first -eq 0 ]] && printf ','
    printf '"%s"' "$user"
    first=0
  fi
done < /etc/passwd
printf ']'

# mots de passe vides
printf ',"empty_password_users":['
first=1
while IFS=: read -r user pass _; do
  if [[ -z "$pass" ]]; then
    [[ $first -eq 0 ]] && printf ','
    printf '"%s"' "$user"
    first=0
  fi
done < /etc/shadow
printf ']'

printf '}\n'
