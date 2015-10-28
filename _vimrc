" ======================================
"    FileName: _vimrc
"    Author:   Edward Green
"    Version:  1.0.0
"    Email:    zhendongguan@gmail.com
"    Blog: http://vimer.xyz
"    Date: 2015-10-28
" =======================================

" ????Vundle
set nocompatible " ȡ??????
filetype off " Vundle required
set rtp+=$VIM\vimfiles\bundle\Vundle.vim " ?涨Vundle??·??
call vundle#begin('$VIM\vimfiles\bundle\') " ?涨?????İ?װ·??
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'altercation/vim-colors-solarized' " ??ɫ????

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


" ?????ļ?

let mapleader = "," " ????mapleader
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
" ????Ϊ?ڶ????κ??ļ?֮???Զ?ִ??
set nu! " ??ʾ?к?
set background=dark " ???????ð?ɫ????
colorscheme solarized " ??????ɫ
syntax enable
set guifont=Monaco:h14:cANSI
set gfw=Monaco:h14:cGB2312 " ????????
syntax on " ?????﷨????
au GUIEnter * simalt ~x " ??????????
set cindent " C???Է???????
set autoindent " ?Զ?????һ??????һ??
set guioptions= " ȡ???߿?
" set guioptions-=T " ???ع?????
" set guioptions-=m " ???ز˵?��
set nobackup " ȡ???Զ?????
set tabstop=4 " ?Ʊ???ռ?ĸ??ո?
set shiftwidth=4 " Ĭ???????ĸ??ո?
" set hlsearch " ????????????
set ignorecase " ???????Դ?Сд
set cursorline " ͻ????ʾ??ǰ??
set shortmess=atI " ȡ????ӭ????
set autoread " ???ļ????ⲿ?޸??Զ????¸??ļ?
set autowrite " ?????Զ??浵

" ????????ת
set tags=tags
set autochdir
" Դ???????����? Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
" ???ĵ??༭
" let g:miniBufExplMapCTabSwitchBufs=1
" let g:miniBufExplMapWindowsNavVim=1
" let g:miniBufExplMapWindowNavArrows=1

