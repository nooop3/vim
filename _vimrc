" ======================================
"    FileName: _vimrc
"    Author:   Edward Green
"    Version:  1.0.0
"    Email:    zhendongguan@gmail.com
"    Blog: http://104.224.175.151
"    Date: 2015-8-25
" =======================================

" 配置Vundle
set nocompatible " 取消兼容
filetype off " Vundle required
set rtp+=$VIM\vimfiles\bundle\Vundle.vim " 规定Vundle的路径
call vundle#begin('$VIM\vimfiles\bundle\') " 规定插件的安装路径
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'altercation/vim-colors-solarized' " 配色插件

" All of Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


" 配置文件

let mapleader = "," " 设置mapleader
" map <silent> <leader>ss :source I:\Win8Install\Vim\_vimrc<cr>
" Fast reloading of the .vimrc
map <silent> <leader>ee :e I:\Win8Install\Vim\_vimrc<cr>
" Fast editing of .vimrcs
" autocmd! bufwritepost _vimrc source I:\Win8Install\Vim\_vimrc " When .vimrc is edited, reload it

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50 " keep 50 lines of command line history
set ruler " show the curser position all the time
set showcmd " display incomplate commands
set incsearch " do incremental searching
if has('mouse')
	set mouse=a
endif	
set hlsearch " Enable highlighting when searching
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
" 设置为在读入任何文件之后自动执行
set nu! " 显示行号
set background=dark " 背景设置暗色主题
colorscheme solarized " 设置配色
syntax enable
set guifont=Monaco:h14:cANSI
set gfw=Monaco:h14:cGB2312 " 设置字体
syntax on " 设置语法高亮
au GUIEnter * simalt ~x " 启动最大化
set cindent " C语言风格缩进
set autoindent " 自动与上一行缩进一致
set guioptions= " 取消边框
" set guioptions-=T " 隐藏工具条
" set guioptions-=m " 隐藏菜单栏
set nobackup " 取消自动备份
set tabstop=4 " 制表符占四个空格
set shiftwidth=4 " 默认缩进四个空格
" set hlsearch " 搜索结果高亮
set ignorecase " 搜索忽略大小写
set cursorline " 突出显示当前行
set shortmess=atI " 取消欢迎界面
set autoread " 当文件在外部修改自动更新该文件
set autowrite " 设置自动存档

" 程序中跳转
set tags=tags
set autochdir
" 源代码分析工具 Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
" 多文档编辑
" let g:miniBufExplMapCTabSwitchBufs=1
" let g:miniBufExplMapWindowsNavVim=1
" let g:miniBufExplMapWindowNavArrows=1

