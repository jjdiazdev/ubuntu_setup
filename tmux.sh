#!/bin/bash

# Script: tmux.sh
# Propósito: Instalar tmux, TPM, tmux-resurrect y la herramienta de portapapeles, y aplicar la configuración
# Requiere: sudo, conexión a Internet

echo "INSTALANDO TMUX"

echo ""

sleep 1

# Instalar tmux y git (git es necesario para descargar TPM)
sudo apt install -y tmux git

# Descargar TPM (Tmux Plugin Manager) si no existe
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || echo "AVISO: no se pudo descargar TPM; repite: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
fi

# Herramienta de portapapeles según el tipo de sesión gráfica
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    sudo apt install -y xclip
else
    sudo apt install -y wl-clipboard
fi

# Preparar la configuración (en X11 el portapapeles se maneja con xclip en lugar de wl-copy)
tmp_conf=$(mktemp)
cp tmux_files/.tmux.conf "$tmp_conf"
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    sed -i "s/'wl-copy'/'xclip -selection clipboard'/" "$tmp_conf"
fi

# Respaldar la configuración previa solo si es distinta, para no perder el original al repetir la instalación
if [ -f ~/.tmux.conf ] && ! cmp -s ~/.tmux.conf "$tmp_conf"; then
    cp ~/.tmux.conf ~/.tmux.conf.bak
fi
mv "$tmp_conf" ~/.tmux.conf && chmod 644 ~/.tmux.conf

# Instalar los complementos declarados en ~/.tmux.conf (tmux-resurrect)
~/.tmux/plugins/tpm/bin/install_plugins || echo "AVISO: no se instalaron los complementos; dentro de tmux pulsa Ctrl+b y luego I"

echo "TMUX INSTALADO"

echo ""

sleep 2
