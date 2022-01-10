" Do 16 Okt 2014 18:47:39 CEST

"  -------------  Load plugins first  -------------
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
let mapleader= ","            " Map leader command key

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle: let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" BufExplorer: open a window with a list of active buffers
" Plugin 'jlanzarotta/bufexplorer'
" nnoremap ,b :BufExplorerHorizontalSplit<CR>

" NerdTree: open a window with a file tree
" Key: <F3>
Plugin 'preservim/nerdtree.git'
nnoremap <F3> :NERDTreeToggle<CR> " NERDTree, toggle as a window

" CtrlP: Fuzzy search in files and buffers
" Keys: Open ,o or ,or search inrrecent files, ,of in filesystem, ,ob in buffers
"       Ctrl-kj move up and down; Ctrl-c close
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPCurFile' "Search current directory as default
nmap <Leader>of :CtrlP<CR>
nmap <Leader>or :CtrlPMRU<CR>
nmap <Leader>ob :CtrlPBuffer<CR>

" Easymotion: Jump directly to a position on the screen
" Keys: ,s{character} ; ,w word within a line ; ,j lines up ; ,k lines down
Plugin 'easymotion/vim-easymotion'
"let g:EasyMotion_do_mapping = 0 " Disable default mappings with two leaders ,,
let g:EasyMotion_smartcase = 1  " Enable case-sensitive search
nmap <Leader>w <Plug>(easymotion-bd-w) " Jump to words on screen with one leader
nmap <Leader>f <Plug>(easymotion-s) " Jump to characters on screen with one ,

" NerdCommenter: Comment with shortcut keys
" Keys: ,cc comment, c<space> toggle comment, cu uncomment,
"        c$ comment out till end of the line,
Plugin 'preservim/nerdcommenter.git'
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters

" TagBar: Browse the tags of the current file and get an overview of its structure
Plugin 'preservim/tagbar'
nnoremap <silent> <F2> :TagbarToggle<CR>

" Fugitive: git integration
" Commands: G add, Gwrite, Gread, Gcommit, Glog, Gstatus (dv diff, cc commit, - " add)
Plugin 'tpope/vim-fugitive'

" Surround: Quick changing of surroundings (tags, parentheses, etc)
" Keys: cs[",',t,etc] to change; in visual mode <Shift-s> for prompt
"       ds[",',t,etc] to delete
"       ys{motion}[",',t,etc] to add; s as motion = whole line
Plugin 'tpope/vim-surround'

" Abolish: Universal substitution of word combinations.
" Command: %S/ / /g
Plugin 'tpope/vim-abolish'

" Repeat: Enable repeating of plugin actions with .
Plugin 'tpope/vim-repeat'

" Matchit: Enable matching of complex brackets, e.g. html tags, with %
" Keys: % cycle through tags, but also through if, elsif, else (excluding C)
Plugin 'tmhedberg/matchit'

" Syntastic: Integrate syntax checking. By default works when writing to files.
" Command: Errors - display local list of syntax errors
Plugin 'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list = 1 " Populate list with errors
let g:syntastic_auto_loc_list = 1 " Auto-open error list, if any
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_jump = 2 " Auto-jump to first error
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1        " Visualize errors at the beginning of each line
let g:syntastic_error_symbol="✗"      " Custom symbol for errors
let g:syntastic_warning_symbol="⚠"    " Custom symbol for warnings
let g:syntastic_enable_balloons=1     " Show ballons when the mouse is hovered
let g:syntastic_aggregate_errors=1    " Run through all available checkers
let g:syntastic_html_checkers = ["w3", "tidy", "validator"]  " Change the default order of HTML checkers

" vim-signature: Show marks next to lines
" Keys: ,m to toggle,  m/ lists of marks, mx place a mark, dmx delete
Plugin 'kshenoy/vim-signature'
nnoremap <Leader>m :SignatureToggle<CR> " Toggle marks visibility on screen

" ListToggle: Easy toggle quickfix and location lists
" Keys: ,q and ,l
Plugin 'Valloric/ListToggle'
let g:lt_height = 5 " Height of the opened window

"vim-peekaboo: Show content of registers in a split window,
" " or @ to toggle, or C-R in INSERT (then symbol to paste)
Plugin 'junegunn/vim-peekaboo'

" Ultisnip: Enable snippet injection
" Note: xterm does not recognize the difference between C-Tab, S-Tab, Tab
if has("py3")
  "Plugin 'SirVer/ultisnips'
  "Plugin 'honza/vim-snippets' "Snipets repository
  "let g:UltiSnipsExpandTrigger="<Tab>"
  "let g:UltiSnipsJumpForwardTrigger="<Tab>"
  "let g:UltiSnipsJumpBackwardTrigger="<S-Tab>" " Will not work in xterm
  "let g:UltiSnipsListSnippets="<C-l>"          " Applies to Insert mode only
  " function! GetSnipsInCurrentScope() " Required for AutoComplPop
  "    return UltiSnips#SnippetsInCurrentScope()
  " endfunction
endif

" Bufferline: to list active buffers in airline
Plugin 'bling/vim-bufferline'

" Airline: more functional status line
Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" Conditional loading if tmux installed
if executable("tmux")
  " Tmuxline: list active tmux sessions in the bottom of the screen
  Plugin 'edkolev/tmuxline.vim'

  " TmuxNavigator: seamlessly switch to tmux panes
  " Keys: Ctrl-hjkl
  Plugin 'christoomey/vim-tmux-navigator'
  let g:tmuxline_separators = {
        \ 'left' : '',
        \ 'left_alt': '>',
        \ 'right' : '',
        \ 'right_alt' : '<',
        \ 'space' : ' '}

  " Vimux: launch commands from vim in a separate tmux pane (useful for scripting)
  Plugin 'preservim/vimux'
  nnoremap <Leader>rr :call VimuxRunCommand("clear; ./" . bufname("%"))<CR> " Execute the current file (TODO: works for executable scripts only)
  nnoremap <Leader>ri :VimuxInspectRunner<CR> " Inspect runner pane
  nnoremap <Leader>rx :VimuxCloseRunner<CR>   " Close vim tmux runner opened by VimuxRunCommand

  " Dispatch: build asynchroneously in tmux
  " Commands: Make, Make!, Dispatch
  Plugin 'tpope/vim-dispatch'
  nnoremap <F9> :Dispatch<CR> " Remap F9 to run compiler asynchroneusly
endif

" a: Easy toggling between .c and .h files
" Keys ,a
Plugin 'vim-scripts/a.vim'
nnoremap <Leader>a :A<CR>

" Colorsque: Automatically visualize css color codes
Plugin 'gko/vim-coloresque'

" Vimwiki: Personal wiki within of Vim
"          Note: I modified the script to disable default bindings
" Keys:,h open wiki (help), ,hn make a note
Plugin 'vim-scripts/vimwiki'
nmap <Leader>h <Plug>VimwikiIndex
nmap <Leader>hn <Plug>VimwikiMakeDiaryNote

" Load colorscheme
Plugin 'NLKNguyen/papercolor-theme'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" -------------  General configuration -------------
" --------------------------------------------------
filetype plugin indent on " Load filetype plugin/configuration file
filetype plugin on     " Detect type and set FileType for event detection
filetype indent on     " Load filetype indent file

set encoding=utf-8     " This line fixes encoding issues over SSH
set termencoding=utf-8 " This line fixes encoding issues over SSH
set nocompatible       " Activates vi Improved enhacements, e.g. filetype
let mapleader= ","     " Map leader command key
set hidden             " Enable buffer change without saving
set autowrite          " Auto-write at any buffer operation or command
" set backup             " Auto-backup before rewrite.  NOTE: Might be annoying if you forget to close a buffer
set undofile           " Save undo history to an undo file, persistently stored
if has("win32")  " TODO: needs relative paths
"  set undodir=C:\vim\var\undo       " Where to store undo files
"  set backupdir=C:\vim\var\backup   " Where to store backup files
"  set viewdir=C:\vim\var\view       " Where to store view files
"  set directory=C:\vim\var\swp      " Where to store swap files
else
  set undodir=~/.vim/var/undo       " Where to store undo files
  set backupdir=~/.vim/var/backup   " Where to store backup files
  set viewdir=~/.vim/var/view       " Where to store view files
  set directory=~/.vim/var/swp      " Where to store swap files
endif
set dictionary+=/usr/share/dict/words " " Load file for keyword autocompletion (^X^K)
set thesaurus+=~/.vim/thesaurus/mthesaur.txt " Load file for thesaurus (^X^T)
set tags=./tags,tags    " Automatically load tags file

autocmd FocusLost   ?* silent! wa      " Auto-save when focus is lost (GUI)
autocmd BufWinLeave ?* mkview          " Auto-save session when closing a buffer (?* to apply for files only)
autocmd BufWinEnter ?* silent loadview " Restore session when opening a buffer
autocmd! BufWritePost .vimrc source ~/.vimrc " Auto reload $MYVIMRC when editing it

" Keys:
noremap <silent> <F9> :make<CR>  " Default make/compile key

" -------------  Editing -------------
set expandtab             " Auto magically expand <Tab> to <Spaces>s
set autoindent            " Copy indent from current line when starting a new line
set shiftwidth=2          " Default shift width, can be overwritten by FileType settings
set softtabstop=2         " Default tab width can be overwritten by FileType settings
set shiftround            " Round indent to multiple of shiftwidth
set smarttab              " sw at the start of the line, sts everywhere else
set backspace=indent,eol,start " Enable backspace to go over lines
set linebreak             " Break lines at convinient points
"set virtualedit=all      " Cursor can be moved anywhere, where is no text too
set pastetoggle=<F12>     " Use paste modes to copy in terminal form other windows
" TODO: set clipboard=unnamedplus " yank/paste to the system clipboard (*) by default (needs vim-gnome)
set textwidth=79          " Max number of columns, for auto line breaking
set report=0              " Always show count of modifications (e.g. substitution)
set omnifunc=syntaxcomplete#Complete " Omnicomplete function for C^X+C^O
autocmd BufWrite * :call DeleteTrailingWS() " Automatically delete trailing spaces when programming

" Keys: (make Y consistent with C and D)
nnoremap Y y$

"Abbrevs: (expand in Insert mode)
iab xdate <c-r>=strftime("%c")<cr>

" -------------  Navigation -------------
" Mouse:
set mouse=nvi             " Enable the use of the mouse (Works in GUI, but not in all terminals)
set mousemodel=popup      " Popup options on mouse hover. Works with gvim.
set ttymouse=xterm2

" Cursor: Move cursor by one physical line (and not a wrapped one)
set sidescroll=5       " Acceleration of horizontal scrolling. Jump by 5 col
set whichwrap=h,l      " Allow to jump to the next/previous line by overrun
set scrolljump=5       " Number of lines to scroll when the cursor gets off the screen
set scrolloff=3        " Number of lines to keep above/below for context info

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Buffers:
nnoremap <leader>x :bd <CR> " Shortcut to close a buffer

" Files:
nnoremap <leader>cd :cd %:p:h<cr> " Switch to the directory of the open buffer

" Folding:
" set foldmethod=indent " Default fold method (indent) (alternative: syntax)
set foldnestmax=3     " Maximal number of nested folds
set nofoldenable      " By default all folds are open
nnoremap + zo         " Shortcut for quicker opening of folds
nnoremap - zc         " Shortcut for quicker closing of folds

" ------------- Search  -------------
set incsearch                    " Highlight matches as you type in the search string
set ignorecase                   " When searching ignore case (except explicit caps)
set nohlsearch                   " Do NOT highlight previous matches of a search pattern
set smartcase                    " Case insensitive searches become casesensitive
nmap <leader>nh :nohlsearch <CR> " Shortcut to disable current highlighting

syntax on               " Syntax highlighting
hi comment ctermfg=grey " Adapt colors of comments
set nowrap             " Don't break lines (doesn't affect the file)
if exists('+breakindent')
    set breakindent showbreak=\ ++ " If lines are wrapped, mark with ++
endif
set showcmd            " Show the current command in the last line (on the right)
set wildmenu           " Display autocompletion options above the command line
set wildmode=longest:full,full " Completion mode that is used
set wildignore+=*.o,*.obj " Ignored during autocompletion
set completeopt+=longest
set number             " Show line numbers
set relativenumber     " Show relative line numer
set numberwidth=5      " Width of the line number column
set history=500        " Number of commands/search pattern to remember in ":"
set cursorline         " Highlight the screen line of the cursor.
set list               " Display whitespaces ...
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " ... but show only tabs and trailing whitespaces (from github/scroolose)
set showmatch          " Highlight matching brackets
set matchtime=1        " Bracket highlighting time (1/10 of second)
set laststatus=2       " Always show the status line (0 never)
set noerrorbells
autocmd GUIEnter * set visualbell t_vb= " Disables bells in GUI mode

highlight OverLength ctermbg=magenta ctermfg=white guibg=#592929   " Overlength highlighting
match OverLength /\%80v.\+/                                        " Define overlength TODO: should be dynamic

nnoremap <silent> <C-L> :nohls<CR><C-L>  " C-L should clean highlighted search too

" -------------  Filetypes -------------
autocmd BufNewFile,BufRead *.tex,*.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif " Define text filetype
autocmd BufRead,BufNewFile *.pde set filetype=arduino " Define a type for arduino
autocmd BufRead,BufNewFile *.ino set filetype=arduino " Define a type for arduino

augroup FileTypeOptions
autocmd!

" Text:
autocmd FileType text setlocal spell                 " Turn on the spell checker
autocmd FileType text setlocal spell spelllang=en_us " Set the language to US
" setlocal spell spelllang=de                        " Set the language to German
autocmd FileType gitcommit,svn,*commit* setlocal spell " Spell check when writing commit logs

" Shell:
autocmd FileType sh iab #! #!/bin/<C-R>=&ft<CR>
autocmd FileType sh set makeprg=sh\ %

" C:
autocmd FileType c nnoremap <silent> <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Python:
autocmd FileType python setlocal ts=4
autocmd FileType python setlocal sw=4
autocmd FileType python setlocal sts=4
autocmd FileType python,ruby,perl iab #! #!/usr/bin/env<Space><C-R>=&ft<CR>
autocmd FileType python set makeprg=python\ %

" Perl:
autocmd FileType perl set makeprg=perl\ %

" LaTeX:
autocmd FileType tex let g:Tex_DefaultTargetFormat='pdf'
autocmd FileType tex let g:Tex_CompileRule_pdf='pdflatex --file-line-error --interaction=nonstopmode $*'
"au BufWritePost *.tex silent call Tex_RunLaTeX() " Automagically compile when saving

" HTML:
autocmd FileType html setlocal textwidth=0 " No text wrapping for HTML
" Map F9 to open a browser
if has("win32")
  autocmd FileType html noremap <F9> :update|silent start %:p<CR>
else
  autocmd FileType html noremap <F9> :silent update<Bar>silent !xdg-open %:p & <CR><C-L>
endif

" Web Wiki:
func! WikiModeOn()
  setlocal textwidth=0 " No text wrapping for wiki articles
  setlocal wrap        " Wrap lines for easier editing
  echom "Wiki mode: textwidth restriction off, text wrapping off"
endfunc
command! WikiMode call WikiModeOn()

" Auto-close tags with Ctrl-_
autocmd Filetype html inoremap <C-_> </<C-X><C-O><CR>

" CSS:

" JavaScript:

" Arduino:
au! BufRead,BufNewFile *.pde setfiletype arduino

" -------------  Helper functions -------------

" Delete trailing spaces in the entire file
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

" -------------  Misc -------------

" CScope : From old .vimrc, TODO: to be reviewed with the next C project
if has("cscope")
    set csto=0 " Search cscope databse first, tag files second
    set cst    " Use ctags with CTRL-]
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    " Keys:
    nnoremap <C-_>  :cstag <C-R>=expand("<cword>")<CR><CR>   "NOTE: might interfere with closing tags
    nnoremap g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR> " Check where a function is used
    nnoremap g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
endif

" -------------  Color configuration -------------
" --------------------------------------------------

" Fix to enable color schemes on terminal
if (&term == "screen-256color" || &term == "xterm")
  set t_Co=256
endif

try
  colorscheme PaperColor
" set background=light  " Change default background to white
  if has("gui_running") " From stackoverflow discussion
    if has("gui_gtk2")
      set guifont=Inconsolata\ 14
    elseif has("gui_macvim")
      set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
      set guifont=Consolas:h12:cANSI
    endif
  endif
catch
  echo "Color scheme cannot be loaded. Maybe you need to install it first"
endtry
