# Roundcube Webmai - Usar senhaSegura está OK para um ambiente didático, mas recomendo evitar senhas em texto claro em ambientes públicos. Pode ser externalizado via: $config['db_dsnw'] = getenv('ROUNDCUBE_DB'); e setar isso como variável de ambiente no docker-compose.yml. 

<?php
$config['db_dsnw'] = 'mysql://roundcube:senhaSegura@dbmail/roundcube';
$config['default_host'] = 'ssl://localhost';
$config['default_port'] = 993;
$config['smtp_server'] = 'tls://localhost';
$config['smtp_port'] = 587;
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';
#$config['plugins'] = ['archive', 'zipdownload', 'managesieve'];
$config['skin'] = 'elastic';
$config['mail_domain'] = 'cafeekernel';
$config['smtp_debug'] = true;
?>