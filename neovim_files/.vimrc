" Para instalar neovim
" sudo snap install nvim
"
" VIMPLUG
"
"# Crear directorios y descargar plug.vim
"mkdir -p ~/.vim/autoload
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"# Crear directorio para plugins
"mkdir -p ~/.vim/plugged

"# Solucionar problemas de permisos (si es necesario)
"chown -R u+rxw ~/.vim
"
"Para extender las funciones de neovim según las configuraciones realizadas y
"plugins instalados y compatibilizarlo con vim, agregamos el siguiente path:
"En .config/nvim/init.vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
"source ~/.vimrc


set number		" colocar números en cada línea del código
set mouse=a		" interactuar con el mouse dentro del editor
syntax enable		" activar sintaxis del lenguaje de programación
set showcmd		" mostrar comandos que estamos utilizando
set encoding=utf-8	" permite configurar la codificaciòn de nuestros documentos a utf-8
set showmatch		" mostrar parentesis o corchete opuesto
set relativenumber	" mostrar número hacia arriba y hacia abajo contando desde 0 donde está el cursor
set sw=2		" identar el código con cuatro espacios
set timeoutlen=500	" tiempo para detectar combinaciones de atajos de teclado a medio segundo


" iniciando Vim Plug gestor de plugins

call plug#begin('~/.vim/plugged')

" themes

Plug 'morhetz/gruvbox'			"instalando el tema de gruvbox

" IDE

Plug 'easymotion/vim-easymotion'	"instalando EasyMotion para movernos mas rapido

Plug 'scrooloose/nerdtree'		"nerdtree para navegar entre los archivos y directorios

Plug 'christoomey/vim-tmux-navigator'	"este es para movernos entre el tree y el archivo abierto

Plug 'itchyny/lightline.vim'		"showmode status line for neovim

Plug 'preservim/nerdcommenter'		"plugin para comentar


" Autopairs
Plug 'windwp/nvim-autopairs' "cerrar parentesis automaticamente


" LSP
" Plugin LSP puente entre el editor y las funciones del lenguaje
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Agregando Emmet
Plug 'mattn/emmet-vim'

" Agregando soporte para blade
Plug 'jwalton512/vim-blade'

" Lorem ipsum text plugin
Plug 'https://github.com/wolandark/vim-loremipsum.git'


call plug#end()
" Instalar plugins con VimPlug
" :PlugInstall

" activando las configuraciones del LSP
" :CocInstall coc-python coc-html coc-css coc-sql coc-php coc-tsserver

"enabling gruvbox theme
colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

" Nerdtree configuración
let NERDTreeQuitOnOpen=1
"esto es para que al abrir un archivo desde el arbol, el arbol se cierre

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_python = 1


"setting up Leader key

let mapleader="n"

nmap <Leader>s <Plug>(easymotion-s2)

nmap <Leader>m :NERDTreeFind<CR>

nmap <Leader>e <CR>


nmap <Leader>w :w<CR>

nmap <Leader>q :q<CR>

nmap <Leader>wq :wq<CR>


nmap <Leader>r :noh<CR>


nmap <Leader>t :terminal<CR>


nmap <Leader>bw :new<CR>

nmap <Leader>bl :ls<CR>

nmap <Leader>bs :bn<CR>
":bn #

nmap <Leader>bd :bd!<CR>
":bd!#

nmap <Leader>y <C-y>,

" Conquer of completion requiere arquitectura de 64 bit y neovim 0.9 en adelante
"
" LSP
"
"# Paso 1: Actualizar la lista de paquetes disponibles (opcional, pero recomendado)
"sudo apt update

"# Paso 2: Instalar Node.js versión 16.18.0 o superior
"sudo apt install nodejs

"# Paso 3: Verificar la versión instalada de Node.js
"node --version

"# Paso 4: Instalar el gestor de paquetes npm (si no está instalado)
"sudo apt install npm

"# Paso 5: Actualizar npm a la última versión (recomendado)
"sudo npm install -g npm@latest

"# Paso 6: Instalar el paquete 'n' para gestionar versiones de Node.js (opcional, pero muy útil)
"sudo npm install -g n

"# Paso 7: Actualizar Node.js a la última versión estable (usando 'n')
"sudo n stable

"# Paso 8: Verificar nuevamente la versión de Node.js (para confirmar la actualización)
"node --version"" installing a language server for python: sudo npm i -g pyright

" installing a language server for sql: sudo npm i -g sql-language-server
" installing a language server for html: sudo npm i -g html
" installing a language server for css: sudo npm i -g css

" to use python pylint you will need to install pip first: sudo apt install python3-pip
" to istall pylint on ubuntu: sudo apt-get install pylint

" LSP configuración


lua << EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require("nvim-autopairs").setup {}


EOF


" Mappings Go To's
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gR <Plug>(coc-references)

" Mappings Completion

" seleccionar el autocompletado con la tecla enter

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" moverse entre las opciones con tab y shift+tab

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Mappings Diagnostics
nnoremap <silent> d{ <Plug>(coc-diagnostic-prev)
nnoremap <silent> d} <Plug>(coc-diagnostic-next)

