#!/bin/bash
apt-get update
apt-get install zip unzip php7.0 php7.0-common php7.0-curl php7.0-json php7.0-xml php7.0-mbstring php7.0-zip
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

su -c 'composer global require "laravel/installer"' ubuntu
su -c 'echo "PATH=\$PATH:\$HOME/.config/composer/vendor/bin" >> ~/.bashrc' ubuntu
