#!/bin/bash
# Script: neovim.sh
# Propósito: Instalar y configurar Neovim y dependencias para LSP/autocompletado
# Requiere: sudo, conexión a Internet
# Nota: Si Snap no está disponible, instalar snapd

echo "INSTALANDO NEOVIM"

sleep 1

# Instalando Snap (si ya está presente, se omitirá)
# En algunas instalaciones puede requerir snapd: sudo apt install snapd -y
sudo apt install snap -y

# Instalar Neovim como editor de código
sudo snap install nvim --classic

# Copiar configuraciones de Vim/Neovim al home del usuario
cp -r neovim_files/.vim ~/.vim ; cp neovim_files/.vimrc ~/.vimrc ; cp -r neovim_files/.config/nvim/ ~/.config/nvim/

# Instalar Node.js y npm para soporte de plugins (CoC, LSP)
sudo apt install nodejs -y

# Instalar npm, gestor de paquetes de Node.js
sudo apt install npm -y

# Actualizar npm a la última versión estable (corregido)
sudo npm install -g npm@latest

# Instalar gestor de versiones de Node y actualizar a estable
sudo npm install -g n
sudo n stable

# Instalar servidores de lenguaje básicos (global)
sudo npm i -g pyright
sudo npm i -g sql-language-server
sudo npm i -g html
sudo npm i -g css
sudo npm i -g javascript-typescript-langserver

# Instalar PHP, Composer y servidor de lenguaje para PHP (felixfbecker)
# Dependencias PHP/Composer
sudo apt install curl php-cli php-mbstring git unzip -y
# Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# PHP y módulo de Apache (opcional)
sudo apt install php libapache2-mod-php -y

## Servidor de lenguaje PHP
#composer global require "felixfbecker/language-server"

# Instalar pip y pylint para Python
sudo apt install python3-pip -y
sudo apt-get install pylint -y

# Dependencia para clipboard
sudo apt install xclip

echo "NEOVIM Y SERVIDORES DE LENGUAJES INSTALADOS"

echo ""

sleep 3
