" Кодировка UTF-8
set encoding=utf8

" Отключение совместимости с vi. Нужно для правильной работы некоторых опций
set nocompatible

" Игнорировать регистр при поиске
set ignorecase

" Не игнорировать регистр, если в паттерне есть большие буквы
set smartcase

" Подсвечивать найденный паттерн
set hlsearch

" Интерактивный поиск
set incsearch

" Размер табов - 4
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Превратить табы в пробелы
set expandtab

" Таб перед строкой будет вставлять количество пробелов определённое в shiftwidth
set smarttab

" Копировать отступ на новой строке
set autoindent
set smartindent

" Показывать номера строк
set number

" Относительные номера строк
set relativenumber

" Автокомплиты в командной строке
set wildmode=longest,list

" Подсветка синтаксиса
syntax on

" Разрешить использование мыши
set mouse=a

" Использовать системный буфер обмена
set clipboard=unnamedplus

" Быстрый скроллинг
set ttyfast

" Курсор во время скроллинга будет всегда в середине экрана
set so=30

" Встроенный плагин для распознавания отступов
filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/itchyny/vim-gitbranch.git'
"Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
"Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ellisonleao/gruvbox.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
call plug#end()

"colorscheme
set background=dark " or light if you want light mode
colorscheme gruvbox

" Автоматическое открытие NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | wincmd p

" Включить/выключить NERDTree при нажатии \n
nnoremap <leader>n :NERDTreeToggle<CR>
" Юникодные иконки папок (Работает только с плагином vim-devicons)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Показывает количество строк в файлах
let g:NERDTreeFileLines = 1
" Игнорировать указанные папки
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$']
" Закрыть vim, если единственная вкладка - это NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:airline_statusline_ontop=0
"let g:airline_theme='bubblegum'
"let g:airline#extensions#tabline#formatter = 'default'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

let g:go_def_mapping_enabled = 0
