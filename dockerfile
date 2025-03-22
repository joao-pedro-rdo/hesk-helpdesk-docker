# Use a imagem oficial do PHP com Apache
FROM php:7.4.33-apache-bullseye

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install \
       mysqli \
       pdo_mysql \
       mbstring \
       exif \
       pcntl \
       bcmath \
       gd

# Habilitar o módulo rewrite do Apache para URLs amigáveis
RUN a2enmod rewrite

# Copiar os arquivos do HESK para o diretório do Apache
COPY . /var/www/html/

# Definir permissões para o diretório de uploads e outros diretórios necessários
RUN chown -R www-data:www-data /var/www/html/attachments \
    && chown -R www-data:www-data /var/www/html/cache \
    && chown -R www-data:www-data /var/www/html/install 
RUN chmod -R 777 /var/www/html/attachments 
RUN chmod -R 777 /var/www/html/cache 
RUN chmod 666 /var/www/html/hesk_settings.inc.php
WORKDIR /var/www/html/

# Configurar permissões para arquivos e pastas específicos
 
RUN chmod -R 777 /var/www/html/attachments 
RUN chmod -R 777 /var/www/html/cache

# Configurar o Apache para servir o HESK corretamente
RUN echo "<Directory /var/www/html/>" > /etc/apache2/conf-available/hesk.conf && \
    echo "    Options Indexes FollowSymLinks" >> /etc/apache2/conf-available/hesk.conf && \
    echo "    AllowOverride All" >> /etc/apache2/conf-available/hesk.conf && \
    echo "    Require all granted" >> /etc/apache2/conf-available/hesk.conf && \
    echo "</Directory>" >> /etc/apache2/conf-available/hesk.conf

RUN chmod 666 /var/www/html/hesk_settings.inc.php
# Habilitar a configuração do HESK no Apache
RUN a2enconf hesk

# Expor a porta 80
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]