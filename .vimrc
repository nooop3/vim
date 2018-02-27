" ======================================
"    FileName: .vimrc
"    Author:   Edward Green
"    Version:  1.0.6
"    Email:    zhendongguan@gmail.com
"    Blog: https://uare.github.io
"    Date: 2017-11-03
" =======================================


" Set mapleader
let mapleader = ";"
let g:mapleader = ";"


"""""""""""""""""""""""""""
" Bundle Plugin List
"""""""""""""""""""""""""""

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

" Color Schemes
Plugin 'morhetz/gruvbox'

" 经典配色方案
Plugin 'altercation/vim-colors-solarized'

" 中文帮助
Plugin 'asins/vimcdoc'

" 模拟黑客帝国
Plugin 'matrix.vim--Yang'

" Airline状态栏增强插件
Plugin 'bling/vim-airline'

" 文件浏览器
Plugin 'scrooloose/nerdtree'

" 代码注释快捷键
Plugin 'scrooloose/nerdcommenter'

" 前端快捷补齐
Plugin 'mattn/emmet-vim'

" 代码补全
" Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neocomplete.vim'

" 括号自动匹配
Plugin 'jiangmiao/auto-pairs'

" 批量选取
" Plugin 'terryma/vim-multiple-cursors'

" 快速搜索
Plugin 'ctrlpvim/ctrlp.vim'

" php-cs-fixer
" Plugin 'stephpy/vim-php-cs-fixer'

" Simple fold
Plugin 'tmhedberg/SimpylFold'

" python indent
Plugin 'vim-scripts/indentpython.vim'

" Syntax checking
Plugin 'vim-scripts/syntastic'

" vim-go
Plugin 'fatih/vim-go'

" python mode
Plugin 'python-mode/python-mode'

" vim-javascript
Plugin 'pangloss/vim-javascript'

" novim-mode
" Plugin 'tombh/novim-mode'

" vim game code break
Plugin 'johngrib/vim-game-code-break'

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

filetype plugin on
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" End Bundle


"""""""""""""""""""""""""""
" Plugin Configure
"""""""""""""""""""""""""""

" Color Schemes Configure
set background=dark
if has('gui_running')
    " let g:solarized_termcolors=256
    " let g:solarized_termtrans=1
    colorscheme solarized
else
    colorscheme gruvbox
endif

" 中文帮助
set helplang=cn "使用中文帮助

" Airline
set t_Co=256      " 指定配色方案为256色
set laststatus=2
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts=1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1

" NERDTree
" open a NERDTree aotomatically
" autocmd vimenter * NERDTree
" open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDCommenter
let g:NERDSpaceDelims=1
let g:NERDCompactSextComs=1
let g:NERDTrimTrailingWhitespace=1

" Emmet
" 设置快捷键为<tab>
let g:user_emmet_expandabbr_key = '<C-d>'
" let g:user_emmet_expandabbr_key = '<Tab>'

" neocomplete
" let g:neocomplcache_enable_at_startup=1
let g:neocomplete#enable_at_startup=1
" Use smartcase
let g:neocomplete#enable_smart_case=1
" Enable auto select
let g:neocomplete#enable_auto_select=1
au FileType python  setlocal omnifunc=python3complete#Complete

" SimpylFold
let g:SimpylFold_docstring_preview=1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "active_filetypes": ["php"],
  \ "passive_filetypes": ['python', 'go'] }

" vim-go
au FileType go nmap <leader>g  :<C-u>w !go run %<cr>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" python-mode
let g:pymode_python = 'python3'
let g:pymode_rope = 0
let g:pymode_folding = 0
" Check code on every save (every)
let g:pymode_lint_unmodified = 1
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 = 
    \ {'ignore': '',
    \ 'max_line_length': g:pymode_options_max_line_length}
let g:pymode_lint_options_mccabe = { 'complexity': 50 }
" skip tab warnings
" let g:pymode_lint_ignore = "E501,C901"
" let g:pymode_lint_ignore = "E501"
" let g:pymode_lint_ignore = "E191"
" let g:pymode_lint_ignore = "C901"
" open window vertically
" autocmd BufEnter __run__,__doc__ :wincmd L

" vim-javascript
" Enables syntax highlight for JSDocs
let g:javascript_plugin_jsdoc = 1
" Enables some additional syntax highlight for NGDocs.
" Requires JSDocs plugin to be enabled as well
let g:javascript_plugin_ngdoc = 1
" Enables syntax highlight for Flow
let g:javascript_plugin_flow = 1

" ctrlp
let g:ctrp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


"""""""""""""""""""""""""""
" Keybind Setting
"""""""""""""""""""""""""""

" Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<CR>
" Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<CR>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
" Fast saving
map <leader>w :w!<CR>
" Disable highlight when <leader><CR> is pressed
map <silent> <leader><CR> :set nohlsearch<CR>
" have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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

syntax enable       " 开启代码高亮

set number          " Show line number
set ignorecase		" Do case insensitive matching
set smartcase		" When searching try to be smart about cases
set incsearch		" Incremental search
set hlsearch		" Highlight search results
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab		" Use Space instead of tabs
set smarttab        " Be smart when using tabs:)
set textwidth=79
set scrolloff=5     " Minimum number of lines above and below of cursor
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set cursorline      " Highlight the screen line of the line
set cmdheight=1     " Set number of the lines to use for the command-lines
set cursorline      " Highlight the screen line of the line
set cursorcolumn    " Highlight the screen column of the cursor
set showmatch		" Show matching brackets.
set autoindent		" always set autoindenting on
set showcmd			" Show (partial) command in status line.
set showmode        " Show Current mode
set autoread        " Auto read file when changed outside of vim
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set nobackup		" do not keep a backup file, use versions instead
set smartindent     " Smart indent
set wrap            " set word wrap
set shortmess=atI   " Cancel the welcome screen
set noswapfile		" Turn backup off
set linebreak       " 不在单词中间断行
set splitright
set splitbelow
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
set completeopt-=preview
" disable perview
set wildmenu
" 在命令模式下使用 Tab 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来。
set whichwrap=b,<,>,[,],h,l
" 允许光标跨行
set backspace=indent,eol,start
" Use Unix as the standard file type
set pastetoggle=<F9>
" 插入代码按下F9取消自动缩进
set guioptions=   " 取消边框
set fileencodings=utf-8
set encoding=utf8   " Set utf8 as standard encoding and en_US as the standard language
" allow backspacing over everything in insert mode
set fileformat=unix
set fileformats=unix
" Configured Cursor Color
" Black ;DarkBlue ;DarkGreen ;DarkCyan ;DarkRed ;DarkMagenta ;
" Brown, DarkYellow ;LightGray, LightGrey, Gray, Grey ;
" DarkGray, DarkGrey ;Blue, LightBlue ;Green, LightGreen ;
" Cyan, LightCyan ;Red, LightRed ;Magenta, LightMagenta ;
" Yellow, LightYellow ;White
" highlight CursorLine ctermbg=DarkBlue
" highlight CursorColumn ctermbg=DarkBlue

" Swap iTerm2 cursors in vim insert mode when using tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
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

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function! GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

autocmd BufWrite *.py,*.pyw,*.c,*.h,*.coffee :call DeleteTrailingWS()

autocmd BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
