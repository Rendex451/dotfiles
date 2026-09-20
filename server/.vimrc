" ========================================================================== "
" { ОСНОВНЫЕ НАСТРОЙКИ }
" ========================================================================== "
syntax on
filetype plugin indent on

set encoding=utf-8
set nocompatible

let mapleader = "\\"

" Поиск
set ignorecase
set smartcase
set hlsearch
set incsearch

" Табуляция и отступы
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set clipboard=unnamedplus

" Интерфейс
set number
set relativenumber
set wildmenu
set mouse=a
set scrolloff=30
set signcolumn=yes    " место под значки LSP-диагностики всегда зарезервировано

" ========================================================================== "
" { ПЛАГИНЫ (vim-plug) }
" ========================================================================== "

let s:plug_vim = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_vim))
  silent execute '!curl -fLo ' . s:plug_vim . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" LSP: чистый vimscript-клиент + автоустановка/автоконфиг серверов по filetype
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Автодополнение поверх LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Дерево проекта
Plug 'preservim/nerdtree'

" Статус-лайн
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Тема
Plug 'morhetz/gruvbox'
Plug 'axvr/photon.vim', { 'as': 'photon' }
Plug 'fxn/vim-monochrome'
Plug 'davidosomething/vim-colors-meh'

call plug#end()

" ========================================================================== "
" { ЦВЕТА }
" ========================================================================== "
" termguicolors тут так же зависит от связки tmux (default-terminal +
" terminal-features RGB, см. .tmux.conf) — сам по себе Vim этого не проверяет.
set background=dark
set termguicolors


"colorscheme gruvbox
"let g:airline_theme = 'gruvbox'

colorscheme meh
let g:airline_theme = 'deus'
" ========================================================================== "
" { LSP: маппинги (вешаются на буфер при подключении сервера) }
" ========================================================================== "

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gD <plug>(lsp-declaration)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> <leader>ca <plug>(lsp-code-action)
  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
  nmap <buffer> <leader>f <plug>(lsp-document-format)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ========================================================================== "
" { Дерево проекта }
" ========================================================================== "

nnoremap <leader>n :NERDTreeToggle<CR>
