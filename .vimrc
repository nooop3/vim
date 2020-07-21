" ======================================
"    FileName: .vimrc
"    Author:   Edward Green
"    Version:  2.0.0
"    Email:    wanwanroad@gmail.com
"    Blog: https://uare.github.io
"    Date: 2020-05-02
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
        " brew install fzf
        " $(brew --prefix)/opt/fzf/install
        set rtp+=/usr/local/opt/fzf
    else
        " git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        " ~/.fzf/install
        set rtp+=~/.fzf
    endif
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
endif


"""""""""""""""""""""""""""
" vim-plug list
"""""""""""""""""""""""""""

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Vim-plug
Plug 'junegunn/vim-plug'

" Fzf vim
Plug 'junegunn/fzf.vim'

" Color Schemes
Plug 'sainnhe/gruvbox-material'

" solarized color theme
if has('gui_running')
 Plug 'altercation/vim-colors-solarized'
endif

" Airline status line
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

" vim rooter
Plug 'airblade/vim-rooter'

" Files browser
Plug 'scrooloose/nerdtree'

" Simple fold
Plug 'tmhedberg/SimpylFold'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter'

" vim polyglot
Plug 'sheerun/vim-polyglot'

" Syntax checking
Plug 'w0rp/ale'

" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python3 neovim client: pip3 install neovim
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'mhartington/nvim-typescript',
" \{ 'do': 'yarn global add typescript --ignore-engines', 'for': 'typescript' }

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
" Plug 'google/vim-glaive'

Plug 'mattn/emmet-vim'

Plug 'fatih/vim-go'

" php-cs-fixer
" Plug 'stephpy/vim-php-cs-fixer'

Plug 'leafgarland/typescript-vim'

Plug 'artur-shaik/vim-javacomplete2'

Plug 'tomlion/vim-solidity'

" Martix
Plug 'vim-scripts/matrix.vim--Yang'

call plug#end()

"""""""""""""""""""""""""""
" Plugin Configure
"""""""""""""""""""""""""""

" junegunn/fzf.vim
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

let g:fzf_buffers_jump = 1

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader><space> :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn

nnoremap <silent> <C-k> :call SearchWordWithAg()<CR>
vnoremap <silent> <leader>k :call SearchVisualSelectionWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
vnoremap <silent> <leader>k :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

function! s:update_fzf_colors()
    let rules =
                \ { 'fg':      [['Normal',       'fg']],
                \ 'bg':      [['Normal',       'bg']],
                \ 'hl':      [['Comment',      'fg']],
                \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
                \ 'bg+':     [['CursorColumn', 'bg']],
                \ 'hl+':     [['Statement',    'fg']],
                \ 'info':    [['PreProc',      'fg']],
                \ 'prompt':  [['Conditional',  'fg']],
                \ 'pointer': [['Exception',    'fg']],
                \ 'marker':  [['Keyword',      'fg']],
                \ 'spinner': [['Label',        'fg']],
                \ 'header':  [['Comment',      'fg']] }
    let cols = []
    for [name, pairs] in items(rules)
        for pair in pairs
            let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
            if !empty(name) && code > 0
                call add(cols, name.':'.code)
                break
            endif
        endfor
    endfor
    let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
    let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
                \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
    autocmd!
    autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

" Color Schemes
" for dark version
set background=dark
if has('gui_running')
    " let g:solarized_termcolors=256
    " let g:solarized_termtrans = 1
    colorscheme solarized
else
    if has('termguicolors')
        set termguicolors
    endif

    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_disable_italic_comment = 1

    colorscheme gruvbox-material
    " let g:airline_theme = 'gruvbox_material'
endif

" sheerun/vim-polyglot
let g:polyglot_disabled = []

" vim-airline/vim-airline
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" airblade/vim-rooter
let g:rooter_silent_chdir = 1

" scrooloose/nerdtree
" open a NERDTree aotomatically
" autocmd vimenter * NERDTree
" open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" tmhedberg/SimpylFold
let g:SimpylFold_docstring_preview = 1

" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSextComs = 1
let g:NERDTrimTrailingWhitespace = 1

" w0rp/ale
let g:ale_linters = {
            \ 'python': [],
            \ 'javascript': [],
            \ 'java': ['javac'],
            \ 'typescript': ['tslint'],
            \ 'proto': ['protoc-gen-lint'],
            \ 'solidity': ['solium']
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'typescript': ['prettier'],
            \ 'proto': ['clang-format']
            \}
let g:ale_c_clangformat_options = '-assume-filename=.proto'

" coc-vim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> KV :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" mattn/emmet-vim
let g:user_emmet_expandabbr_key = '<C-d>'
" let g:user_emmet_expandabbr_key = '<Tab>'

" fatih/vim-go
au FileType go nmap <leader>g  :<C-u>w !go run %<cr>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" leafgarland/typescript-vim
" let g:typescript_indent_disable = 1

" artur-shik/vim-javacomplete2
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

nnoremap [b :gt
nnoremap ]b :gT
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt

" Support navigating in vims commnad mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

set number          " Show line number
" set ignorecase		" Do case insensitive matching
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
set cmdheight=2     " Set number of the lines to use for the command-lines
set cursorline      " Highlight the screen line of the line
set cursorcolumn    " Highlight the screen column of the cursor
set signcolumn=yes
set showmatch		" Show matching brackets.
set autoindent		" always set autoindenting on
set showcmd			" Show (partial) command in status line.
set showmode        " Show Current mode
set autoread        " Auto read file when changed outside of vim
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set nobackup		" do not keep a backup file, use versions instead
set nowritebackup
set updatetime=300
set smartindent     " Smart indent
set wrap            " set word wrap
set shortmess=atIc  " Cancel the welcome screen
set noswapfile		" Turn backup off
set linebreak
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

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py,*.pyw,*.c,*.h,*.coffee,*.md :call DeleteTrailingWS()
autocmd BufNewFile,BufRead crontab* set filetype=crontab

autocmd FileType sh
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2
autocmd BufNewFile,BufRead *.js,*.json,*.ts,*tsx,*.html,*.css,*.yml,*.proto,*.sh
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2
autocmd BufNewFile,BufRead *.md
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4
