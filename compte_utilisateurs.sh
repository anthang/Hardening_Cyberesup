while IFS=: read -r user pass uid gid gecos home shell; do
  if [[ "$uid" -eq 0 && "$user" -ne 'root' ]]; then
    echo "Utilisateur autre que root avec uid 0 : $user";
  fi
done < /etc/passwd

echo "Pas utilisateur autre que root avec uid 0"


while IFS=: read -r user pass ; do
  if [[ -z "$pass" ]]; then
    echo "Utilisateur $user n'a pas de mot de passe";
  fi
done < sudo cut -d /etc/shadow

