" ======================================
"    FileName: .vimrc
"    Author:   Edward Green
"    Version:  1.3.0
"    Email:    zhendongguan@gmail.com
"    Blog: https://uare.github.io
"    Date: 2018-07-15
" =======================================

" Set mapleader
let mapleader = ';'
let g:mapleader = ';'

if !exists('g:os')
  if has('win64') || has('win32') || has('win16')
    let g:os = 'Windows'
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

if g:os == 'Windows'
  " Windows (PowerShell)
  md ~\vimfiles\autoload
  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile(
    $uri,
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
      '~\vimfiles\autoload\plug.vim'
    )
  )
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
else
  " Unix (MacOs, Linux)
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  " add fzf support
  if has('Mac')
    set rtp+=/usr/local/opt/fzf
  endif
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction


"""""""""""""""""""""""""""
" vim-plug list
"""""""""""""""""""""""""""

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Vim-plug help doc
Plug 'junegunn/vim-plug'

" Color Schemes
Plug 'morhetz/gruvbox'

" solarized color theme
" Plug 'altercation/vim-colors-solarized'

" Airline status line
Plug 'bling/vim-airline'

" Chinese help docs
Plug 'asins/vimcdoc'

" Search files
Plug 'ctrlpvim/ctrlp.vim'

" Files browser
Plug 'scrooloose/nerdtree'

" Simple fold
Plug 'tmhedberg/SimpylFold'

" Python3 neovim client: pip3 install neovim
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'mhartington/nvim-typescript'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter'

" Syntax checking
Plug 'w0rp/ale'

Plug 'mattn/emmet-vim'

Plug 'fatih/vim-go'

" php-cs-fixer
" Plug 'stephpy/vim-php-cs-fixer'

Plug 'python-mode/python-mode'

Plug 'pangloss/vim-javascript'

Plug 'leafgarland/typescript-vim'

Plug 'artur-shaik/vim-javacomplete2'

Plug 'tomlion/vim-solidity'

" Martix
Plug 'vim-scripts/matrix.vim--Yang'

call plug#end()

"""""""""""""""""""""""""""
" Plugin Configure
"""""""""""""""""""""""""""

" Color Schemes Configure
set background=dark
if has('gui_running')
    " let g:solarized_termcolors=256
    " let g:solarized_termtrans = 1
    colorscheme solarized
else
    colorscheme gruvbox
endif

" Airline
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Use chinese help doc
set helplang=cn

" ctrlp
let g:ctrp_show_hidden = 1
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

" NERDTree
" open a NERDTree aotomatically
" autocmd vimenter * NERDTree
" open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" SimpylFold
let g:SimpylFold_docstring_preview = 1

" deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase
" let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 3
" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=python3complete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSextComs = 1
let g:NERDTrimTrailingWhitespace = 1

" ale
let g:ale_linters = {
\   'java': ['javac'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'python': ['flake8'],
\   'solidity': ['solium'],
\   'proto': ['protoc-gen-lint']
\}
let g:ale_javascript_eslint_use_global = 1
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Emmet
let g:user_emmet_expandabbr_key = '<C-d>'
" let g:user_emmet_expandabbr_key = '<Tab>'

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

" typescript vim
let g:typescript_indent_disable = 1

" vim java complete
" java compile
map <F2> :call CompileJava()<CR>
func! CompileJava()
    :w
    :!javac "%"
endfunc
" run class
map <F3> :call RunClass()<CR>
func! RunClass()
    :!java -cp "%:p:h" "%:t:r"
endfunc
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" enable smart (trying to guess import option) inserting class imports with F4
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
" enable usual (will ask for import option) inserting class imports with F5
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
" add all missing imports with F6
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
" remove all unused imports with F7
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)


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

nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>

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
set whichwrap=b,<,>,[,],h,l
set backspace=indent,eol,start
" Use Unix as the standard file type
set pastetoggle=<F9>
set guioptions=
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
  if has('macunix')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  else
    if has("autocmd")
      au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
      au InsertEnter,InsertChange *
        \ if v:insertmode == 'i' | 
        \   silent execute '!echo -ne "\e[5 q"' | redraw! |
        \ elseif v:insertmode == 'r' |
        \   silent execute '!echo -ne "\e[3 q"' | redraw! |
        \ endif
      au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
    endif
  end
endif

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
if has('mouse')
  set mouse=a
endif
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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

" Indent Python in the Google way.
autocmd Filetype python setlocal indentexpr=GetGooglePythonIndent(v:lnum)

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.pyw,*.c,*.h,*.coffee :call DeleteTrailingWS()

autocmd BufNewFile,BufRead *.js,*.json,*.ts,*tsx,*.html,*.css,*.yml,*.proto
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2
autocmd BufNewFile,BufRead *.md
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4
