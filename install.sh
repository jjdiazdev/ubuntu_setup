#!/bin/bash

# Script: install.sh
# Propósito: Orquestar la instalación completa del entorno
# Orden: update -> neovim -> ollama -> zsh -> tmux -> update final -> instrucciones finales

# Actualizando el sistema (antes de instalar componentes)
./update.sh

# Instalar y configurar Neovim y herramientas de desarrollo
./neovim.sh

# Instalar Ollama y descargar el modelo base
./ollama.sh

# Instalar Zsh y Oh My Zsh, y establecer Zsh como shell por defecto
./zsh.sh

# Instalar tmux, TPM, tmux-resurrect y su configuración
./tmux.sh

# Actualizar nuevamente tras la instalación de componentes
./update.sh

# Mensajes finales
echo "ENTORNO DE DESARROLLO CONFIGURADO"

echo ""

sleep 3

echo "REINICIANDO TERMINAL EN..."

echo "3"

sleep 0.5

echo "2"

sleep 0.5

echo "1"

sleep 0.5

clear

echo "Iniciar Neovim"

echo "Ejecutar -> :PlugInstall"

echo "Ejecutar -> :CocInstall coc-python coc-phpls coc-tsserver coc-html coc-css coc-sql"

echo "Configurar Git"

# Cambiar a Zsh al finalizar
/bin/zsh
