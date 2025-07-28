#!/bin/bash
echo "Criando usuários de e-mail..."

while IFS=: read -r user pass
do
  # Só cria se não existir
  if ! id "$user" &>/dev/null; then
    useradd -m "$user"
    echo "$user:$pass" | chpasswd
    mkdir -p /home/$user/Maildir/{cur,new,tmp}
    chown -R $user:$user /home/$user/Maildir
    echo "Usuário $user criado."
  else
    echo "Usuário $user já existe. Pulando criação."
  fi
done < /opt/cafeekernel/users.conf

echo "Usuários configurados."

# Corrige os emails exibidos nas identidades
mysql -u root -p"$MYSQL_ROOT_PASSWORD" roundcube <<EOF
UPDATE identities SET email = CONCAT(name, '@cafeekernel') WHERE email LIKE '%@localhost';
EOF


