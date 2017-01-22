" ======================================
"    FileName: .vimrc
"    Author:   Edward Green
"    Version:  1.0.1
"    Email:    zhendongguan@gmail.com
"    Blog: http://vimer.xyz
"    Date: 2016-01-22
" =======================================

" Set mapleader
let mapleader = ";"
let g:mapleader = ";"

" Bundle start
set nocompatible  " 取消兼容
filetype off      " Bundle required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/bundle/plugin')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 经典配色方案
Plugin 'altercation/vim-colors-solarized' 

" 中文帮助
Plugin 'asins/vimcdoc'
set helplang=cn "使用中文帮助

" 模拟黑客帝国
Plugin 'matrix.vim--Yang'

" Airline状态栏增强插件
Plugin 'bling/vim-airline'

" set t_Co=256      " 指定配色方案为256色
set laststatus=2
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" 映射<leader>num到num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>

" 文件浏览器
Plugin 'scrooloose/nerdtree'
" open a NERDTree aotomatically
" autocmd vimenter * NERDTree
" open NERDTree with Ctrl-n
map <C-z> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 前端快捷补齐
Plugin 'mattn/emmet-vim'
" 设置快捷键为<tab>
let g:user_emmet_expandabbr_key = '<C-d>'
" let g:user_emmet_expandabbr_key = '<Tab>'
							
" 代码补全
" Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neocomplcache.vim'
" 启动开启代码补全
let g:neocomplcache_enable_at_startup = 1

" 括号自动匹配
Plugin 'jiangmiao/auto-pairs'

" 批量选取
" Plugin 'terryma/vim-multiple-cursors'

" 快速搜索
" Plugin 'ctrlpvim/ctrlp.vim'

" php-cs-fixer
Plugin 'stephpy/vim-php-cs-fixer'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" End Bundle

" Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
" Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
" Fast saving
map <leader>w :w!<CR>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :set nohlsearch<cr>

" have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

syntax enable     " 开启代码高亮
"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized

set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set showmode        " Show Current mode
set number          " Show line number
set cmdheight=1     " Set number of the lines to use for the command-lines
set autoread        " Auto read file when changed outside of vim
set scrolloff=3       " Minimum number of lines above and below of cursor
set ignorecase		" Do case insensitive matching
set smartcase		" When searching try to be smart about cases 
set incsearch		" Incremental search
set hlsearch		" Highlight search results
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
"set cursorcolumn    " Highlight the screen column of the cursor
"set cursorline      " Highlight the screen line of the line
set autoindent		" always set autoindenting on
set smartindent     " Smart indent
set expandtab		" Use Space instead of tabs
set smarttab        " Be smart when using tabs:)
set shiftwidth=4    " 1 tab == 4 space when (autu)indent
set tabstop=4       " 1 tab = 4 spaces
set wrap            " set word wrap
set shortmess=atI   " Cancel the welcome screen
set noswapfile		" Turn backup off
set encoding=utf8   " Set utf8 as standard encoding and en_US as the standard language
set fileencodings=utf-8
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Use Unix as the standard file type
set fileformats=unix,dos,mac

set pastetoggle=<F9>	" 插入代码按下F9取消自动缩进
set guioptions=   " 取消边框
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 15 
if has('mouse')
	set mouse=a
endif
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
