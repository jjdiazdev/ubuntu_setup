## Entorno de desarrollo para Ubuntu (automatizado)

Este proyecto automatiza la preparación de un entorno de desarrollo en Linux Ubuntu mediante una serie de scripts Bash. Incluye instalación de editores, shells, herramientas de IA, gestores de paquetes y configuraciones listas para usar.

### Instalación rápida

- Ejecuta la instalación desde la raíz del proyecto:

```bash
bash install.sh
```

- Si no tienes permisos de ejecución sobre el archivo:

```bash
sudo chmod +x install.sh
bash install.sh
```

Durante la instalación se solicitará tu contraseña para ejecutar comandos con `sudo`.

### Requisitos

- Ubuntu con `apt` funcional e Internet.
- Permisos para usar `sudo`.

### ¿Qué instala y configura?

- **Actualizaciones del sistema**: `apt update`, `apt upgrade -y`, `apt autoremove -y`.
- **Neovim** (vía Snap): `nvim --classic`.
  - Copia de configuraciones: `neovim_files/.vim`, `neovim_files/.vimrc`, `neovim_files/.config/nvim` a tu `$HOME`.
  - Plugins (Vim-Plug):
    - **Tema**: `morhetz/gruvbox` (contraste dark "hard").
    - **IDE/UX**: `vim-easymotion`, `nerdtree`, `vim-tmux-navigator`, `lightline.vim`, `nerdcommenter`.
    - **Autopairs**: `windwp/nvim-autopairs`.
    - **LSP/Autocomplete**: `neovim/nvim-lspconfig`, `neoclide/coc.nvim` (release), `hrsh7th/nvim-cmp` y fuentes relacionadas.
  - Ajustes clave en `~/.vimrc`:
    - Numeración relativa, `mouse=a`, `syntax enable`, `encoding=utf-8`, `timeoutlen=500`.
    - Mapeos con `mapleader` = `n` para navegación, guardado, buffers, terminal, etc.
    - Integración LSP básica (ej. `pyright`, `sqlls`, `gopls`) y `nvim-autopairs`.
  - Dependencias para LSP:
    - **Node.js** y **npm** (instalados con `apt` y actualización a estable vía `n`).
    - Servidores de lenguaje globales (npm): `pyright`, `sql-language-server`, `html`, `css`, `javascript-typescript-langserver`.
    - **PHP** + **Composer** + `felixfbecker/language-server` (global con Composer) y `libapache2-mod-php`.
    - **Python**: `python3-pip` y `pylint`.
- **Zsh** y **Oh My Zsh**:
  - Instalación de `zsh` y copia de `zsh_files/oh-my-zsh` a `~/.oh-my-zsh` y `zsh_files/.zshrc` a `~/.zshrc`.
  - Tema por defecto: `adben`. Plugins: `git`.
  - Cambio de shell por defecto a `/bin/zsh` para el usuario actual.
- **Ollama** (IA local):
  - Instalación vía script oficial (`curl -fsSL https://ollama.com/install.sh | sh`).
  - Descarga del modelo `qwen2.5-coder:1.5b`.
- **tmux** (multiplexor de terminal):
  - Instalación de `tmux` y `git`, descarga de TPM (`~/.tmux/plugins/tpm`) e instalación de `tmux-resurrect`.
  - Herramienta de portapapeles según la sesión: `wl-clipboard` (Wayland) o `xclip` (X11).
  - Copia de `tmux_files/.tmux.conf` a `~/.tmux.conf` (respalda la anterior en `~/.tmux.conf.bak`).
  - Atajos `tt` y `tts` en `.zshrc` para crear o entrar a sesiones por proyecto.

### Uso después de instalar

- Abre Neovim y ejecuta la instalación de plugins y extensiones:

```nvim
:PlugInstall
:CocInstall coc-python coc-phpls coc-tsserver coc-html coc-css coc-sql
```

- Reinicia la terminal si es necesario para que `zsh` y los cambios de `node` queden activos.

- Para verificar Ollama y el modelo descargado:

```bash
ollama list
```

- Si los complementos de tmux no se instalaron, dentro de tmux pulsa `Ctrl+b` y luego `I` (i mayúscula).

### Estructura de scripts

- `install.sh`: orquestación. Ejecuta en orden: `update.sh`, `neovim.sh`, `ollama.sh`, `zsh.sh`, `tmux.sh`, `update.sh` y luego inicia `/bin/zsh`.
- `update.sh`: actualiza y limpia paquetes.
- `neovim.sh`: instala Snap, Neovim, configura Vim/Neovim, instala Node/npm, actualiza Node con `n`, instala servidores de lenguaje y herramientas (PHP, Composer, pip, pylint).
- `ollama.sh`: instala `curl`, Ollama y descarga `qwen2.5-coder:1.5b`.
- `zsh.sh`: instala `zsh`, copia Oh My Zsh y `.zshrc`, cambia el shell por defecto.
- `tmux.sh`: instala `tmux`, TPM, `tmux-resurrect` y la herramienta de portapapeles, y copia `.tmux.conf`.

### Notas importantes

- La instalación copia configuraciones directamente al `$HOME` del usuario que ejecuta el script.
- Los scripts usan rutas relativas: ejecuta `bash install.sh` desde la raíz del proyecto.
- La instalación de Ollama ejecuta un script remoto; revisa el contenido si lo prefieres antes de continuar.
- El script de Node actualiza a la versión estable globalmente con `n`; podría requerir reabrir sesión para aplicar rutas.
- Si Snap no estuviera disponible, el script lo instala (`sudo apt install snap -y`).

### Solución de problemas

- Permisos de ejecución ausentes:

```bash
sudo chmod +x install.sh
bash install.sh
```

- Si `:PlugInstall` o `:CocInstall` fallan: verifica conexión a Internet o reintenta tras abrir Neovim de nuevo.
- Si `ollama pull` falla: asegura que el servicio de Ollama esté corriendo (`sudo systemctl status ollama`) e intenta nuevamente.

### Compatibilidad

- Probado para entornos Ubuntu >= 22.04

### Licencia

- Este repositorio incluye una copia de `oh-my-zsh` bajo su propia licencia. Revisa `zsh_files/oh-my-zsh/LICENSE.txt` para detalles.

Para desarrolladores: puedes clonar o descargar este repositorio, revisar e instalar los paquetes listados en los scripts y adaptar libremente las configuraciones y pasos a tu entorno de trabajo (habilitando o deshabilitando secciones en `install.sh`, ajustando plugins de Neovim, temas de Oh My Zsh y añadiendo paquetes adicionales).

### Personalización y consideraciones

- Ajusta `neovim_files/.vimrc` para añadir/quitar plugins y mappings.
- Modifica `zsh_files/.zshrc` para cambiar el tema, plugins y alias.
- Si tu sistema no tiene Snap, instala `snapd` (`sudo apt install snapd -y`) antes de ejecutar `neovim.sh`.
- El paso de actualización de Node usa `n` de forma global; puedes fijar una versión específica si tu proyecto lo requiere.
- Revisa los scripts antes de ejecutarlos en equipos de producción; contienen instalaciones globales y cambios de shell.