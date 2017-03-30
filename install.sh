#!/bin/bash
apt-get update
apt-get install -y zip unzip php7.0 php7.0-common php7.0-curl php7.0-json php7.0-xml php7.0-mbstring php7.0-zip apache2 libapache2-mod-php emacs
curl -OL https://getcomposer.org/download/1.4.1/composer.phar && mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

su -c 'composer global require "laravel/installer"' ubuntu
su -c 'echo "PATH=\$PATH:\$HOME/.config/composer/vendor/bin" >> ~/.bashrc' ubuntu
rm -rf /var/www/html
cd /var/www/ && git clone https://github.com/lsulibraries/dsl-print-culture
ln -s /var/www/dsl-print-culture/public /var/www/html
cd /var/www/dsl-print-culture && composer install
cd /var/www/dsl-print-culture  && php artisan storage:link
git -C /var/www/dsl-print-culture submodule init
git -C /var/www/dsl-print-culture submodule update
cd /var/www/dsl-print-culture && mv .env.example .env
cd /var/www/dsl-print-culture && php artisan key:generate
a2enmod rewrite
cp /vagrant/000-default.conf /etc/apache2/sites-enabled/000-default.conf
service apache2 restart
chown -R www-data /var/www/dsl-print-culture

echo "            !!!!!!   To complete the build, be sure to log into the box and update the private git submodule at /var/www/dsl-print-culture/.        git submodule update"
