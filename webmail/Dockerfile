FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Instala repositórios auxiliares
RUN apt update && apt install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php -y \
    && apt update

# Instala PHP moderno e serviços essenciais
RUN apt install -y \
    postfix dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd \
    apache2 php8.2 php8.2-mysql php8.2-intl php8.2-mbstring php8.2-xml php8.2-common php8.2-curl \
    mariadb-server nano openssl rsyslog wget tar unzip

# Corrige problema do rsyslog com imklog (containers)
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# Ativa log de e-mails
RUN echo 'mail.* -/var/log/mail.log' > /etc/rsyslog.d/mail.conf \
    && touch /var/log/mail.log

# Instala Roundcube versão estável manualmente
WORKDIR /opt
RUN wget https://github.com/roundcube/roundcubemail/releases/download/1.6.5/roundcubemail-1.6.5-complete.tar.gz \
    && tar -xzf roundcubemail-1.6.5-complete.tar.gz \
    && mv roundcubemail-1.6.5 /var/www/html/roundcube \
    && chown -R www-data:www-data /var/www/html/roundcube

# Configura acesso via /webmail no Apache
RUN echo 'Alias /webmail /var/www/html/roundcube' > /etc/apache2/conf-available/roundcube.conf \
    && a2enconf roundcube

# Copia arquivos personalizados
COPY config/ /etc/
COPY start.sh /start.sh
COPY init-mail.sh /opt/cafeekernel/init-mail.sh
COPY users.conf /opt/cafeekernel/users.conf
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/config.inc.php /var/www/html/roundcube/config/config.inc.php

# Permissões de execução
RUN chmod +x /opt/cafeekernel/init-mail.sh /start.sh

# Libera portas essenciais
EXPOSE 25 587 993 80

# Inicia script que configura serviços e usuários
CMD ["/start.sh"]
