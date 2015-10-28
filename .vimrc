" ======================================
"    FileName: .vimrc
"    Author:   Edward Green
"    Version:  1.0.0
"    Email:    zhendongguan@gmail.com
"    Blog: http://104.224.175.151
"    Date: 2015-9-18
" =======================================

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

" 模拟黑客帝国
Plugin 'matrix.vim--Yang'

" Powerline插件，状态栏增强显示
" Plugin 'Lokaltog/vim-powerline'
" set laststatus=2
set t_Co=256      " 指定配色方案为256色
" let g:Powline_symbols='fancy'

" Airline状态栏增强插件
Plugin 'bling/vim-airline'
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

syntax enable     " 开启代码高亮
"if has('gui_running')
	set background=dark
	"let g:solarized_termcolors=256
	set t_Co=256
	colorscheme solarized
"else
"	set background=light
"	set t_Co=16
"endif

set hlsearch      " 开启搜索高亮
set incsearch     " 输入字符串的同时进行搜索
set ignorecase    " 搜索忽略大小写
set showmode      " 开启模式显示
set ruler         " 开启光标位置显示
set number        " 显示行号
set cursorline    " 高亮光标所在行
set cursorcolumn  " 高亮所在列
set cmdheight=1   " 命令部分高度为2
set autoindent    " 自动缩进
set smartindent   " 智能缩进
set autoread      " 当文件在外部改变时，vim自动更新内容
set autowrite     " 设置自动存档
set showmatch     " 显示匹配的括号
set tabstop=4     " 制表符占四个空格
set shiftwidth=4  " 默认缩进四个空格
set history=50    " keep 50 lnes of command line history
set showcmd       " display incomplate command
set scrolloff=3
set shortmess=atI " 取消欢迎界面
set nobackup      " 不备份文件
set noswapfile
set fileencodings=utf-8
set fileformats=unix,dos,mac
set guioptions=   " 取消边框
" set guifont=DejaVu\ Sans\ Mono\ 15
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 15 
set backspace=indent,eol,start " alllow backspacing over everything in insert mode
autocmd! bufwritepost .vimrc source ~/.vimrc
if has('mouse')
	set mouse=a
endif
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
