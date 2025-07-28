#!/bin/bash

echo "Iniciando serviços no container de e-mail..."

# Evita aviso do Apache sobre ServerName
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Ativa alias para acesso ao Roundcube via /webmail
a2enconf roundcube

# Inicia serviços essenciais e ativa logs
service rsyslog start || true
service postfix start
service dovecot restart
service apache2 restart

# Espera alguns segundos para garantir que serviços subiram
sleep 5

# Executa configuração automática de usuários e Maildir
if [ -x /opt/cafeekernel/init-mail.sh ]; then
  echo "Executando script de criação de usuários..."
  bash /opt/cafeekernel/init-mail.sh
else
  echo "Script de inicialização de usuários não encontrado ou sem permissão de execução."
fi

# Mantém container vivo
tail -f /var/log/mail.log
