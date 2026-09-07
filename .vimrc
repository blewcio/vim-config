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

" Remap Esc to Ctrl-C in Insert mode (Normal Ctrl-C is normally a hard stop)
inoremap <C-c> <Esc>

" General key bindings
" Move by display line when no count is given, but fall back to normal
" linewise j/k when a count is supplied (keeps 5j, macros, and operator
" counts working as expected)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

" Remap keys for German keyboard
nnoremap ß /
inoremap ß /
vnoremap ß /
cnoremap ß /
xnoremap ß /
nnoremap ¿ \
inoremap ¿ \
vnoremap ¿ \
cnoremap ¿ \
xnoremap ¿ \
nnoremap Ü ^
inoremap Ü ^
vnoremap Ü ^
cnoremap Ü ^
nnoremap ü ~
inoremap ü ~
vnoremap ü ~
onoremap ü ~
cnoremap ü ~
nnoremap ö [
nnoremap ä ]
inoremap ö [
inoremap ä ]
vnoremap ö [
vnoremap ä ]
cnoremap ö [
cnoremap ä ]
onoremap ö [
onoremap ä ]
nnoremap Ö {
nnoremap Ä }
inoremap Ö {
inoremap Ä }
vnoremap Ö {
vnoremap Ä }
cnoremap Ö {
cnoremap Ä }
onoremap Ö {
onoremap Ä }
xnoremap ö [
xnoremap ä ]
xnoremap Ä }
xnoremap Ö {
xnoremap ü ~
xnoremap Ü ^

" Bash-like movement in Vims command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Save like in other windows applications
nnoremap <C-S> :write!<CR>

" Shortcuts to directly use the system clipboard
nnoremap <Leader>p "*]p
nnoremap <Leader>P "*]P
nnoremap <Leader>Y "*y$
nnoremap <Leader>yy "*yy
nnoremap <Leader>yap "*yap
vnoremap <Leader>y "*y

" Text operations:
" Yank to the end of line (make Y consistent with C and D)
nnoremap Y y$
" Split line at cursor (opposite of J)
nnoremap S i<CR><Esc>k$
" Toggle paste mode for copy paste from external sources
noremap <leader>pp :setlocal paste!<cr>

" Others:
" Shortcut to close a buffer
nnoremap <leader>x :bd <CR>
noremap <Leader>e :e $MYVIMRC<CR>
noremap <Leader>s :so $MYVIMRC<CR>

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle: let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" BufExplorer: open a window with a list of active buffers
Plugin 'jlanzarotta/bufexplorer'
nnoremap <Leader>b :BufExplorerHorizontalSplit<CR>
noremap gb :bnext<cr>
noremap gB :bprevious<cr>
noremap <leader>1 :b1<cr>
noremap <leader>2 :b2<cr>
noremap <leader>3 :b3<cr>
noremap <leader>4 :b4<cr>
noremap <leader>5 :b5<cr>
" Jump to the alternate (last used) buffer, more reliable than raw <C-^>
" across terminals/keyboard layouts
nnoremap <Leader><Tab> <C-^>
" Reload all buffers (e.g. when working with Claude)
nnoremap <Leader>r :bufdo e<CR>

" NerdTree: open a window with a file tree
" Key: <F3>
Plugin 'preservim/nerdtree.git'
" NERDTree, toggle as a window
nnoremap <F3> :NERDTreeToggle<CR>

" A collection of language pack for syntax highlighting, e.g. csv
Plugin 'sheerun/vim-polyglot'

" Insert or delete brackets, parens, quotes in pair.
" Plugin 'jiangmiao/auto-pairs'

" A universal set of defaults
Plugin 'tpope/vim-sensible'

" Pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Prefer fzf over CtrlP
if executable("fzf")
  Plugin 'junegunn/fzf.vim' " Main plugin
  Plugin 'junegunn/fzf' "Base functions
  " Use ripgrep for :Files so it's faster and respects .gitignore
  if executable("rg")
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  endif
  " Open files
  nnoremap <Leader>of :Files<CR>
  " Open buffers
  nnoremap <Leader>ob :Buffers<CR>
  " Recent files
  nnoremap <Leader>or :History<CR>
  " File content (requires ripgrep)
  nnoremap <Leader>og :Rg<CR>
  " Search lines in open buffers
  nnoremap <Leader>ol :Lines<CR>
  " Key mappings
  nnoremap <Leader>/ :Maps<CR>
else
  " CtrlP: Fuzzy search in files and buffers
  " Keys: Open ,o or ,or search in recent files, ,of in filesystem, ,ob in buffers
  "       Ctrl-kj move up and down; Ctrl-c close
  Plugin 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_map = '<leader>o'
  let g:ctrlp_cmd = 'CtrlPCurFile' "Search current directory as default
  nnoremap <Leader>of :CtrlP<CR>
  nnoremap <Leader>or :CtrlPMRU<CR>
  nnoremap <Leader>ob :CtrlPBuffer<CR>
endif

" Easymotion: Jump directly to a position on the screen
" Keys: ,,f{character} ; ,,w word within a line
" ,,k jump to line (overwin) ; ,,l jump to line (lineanywhere)
" ,,/ fuzzy search + jump (via incsearch-fuzzy)
Plugin 'easymotion/vim-easymotion'
"let g:EasyMotion_do_mapping = 0 " Disable default mappings with two leaders ,,
let g:EasyMotion_smartcase = 1  " Enable case-sensitive search
let g:EasyMotion_enter_jump_first = 1 " Jump to first occurence by pressing Enter
map <Leader><Leader>w <Plug>(easymotion-overwin-w)
map <Leader><Leader>k <Plug>(easymotion-overwin-line)
map <Leader><Leader>l <Plug>(easymotion-lineanywhere)
map <Leader><Leader>f <Plug>(easymotion-s)
map <Leader><Leader>; <Plug>(easymotion-repeat)

" incsearch.vim: required base plugin for incsearch-fuzzy.vim below
Plugin 'haya14busa/incsearch.vim'

" Fuzzy search with Easymotion
Plugin 'haya14busa/incsearch-fuzzy.vim'
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Leader><Leader>/ incsearch#go(<SID>config_easyfuzzymotion())

" Move entire lines (or characters) of text
" Keys: A-(hjkl)
" let g:move_key_modifier_visualmode = 'S' "Move entire blocks in visual mode
Plugin 'matze/vim-move' "

" Shows a git diff in the sign column.
" Keys: jump between hunks [c and ]c. Preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu respectively.
" :GitGutterToggle
Plugin 'airblade/vim-gitgutter' " git status
" Consistent movement mappings for hunks using 'h'
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" Open list of changes as QuickFixList
" Populate QuickFixList
nnoremap <Leader>ho :GitGutterQuickFix<cr>:copen<cr>
" Reload lines
nnoremap <Leader>hr :GitGutter<cr>

" Visually display indent guide
Plugin 'nathanaelkane/vim-indent-guides'
" Usage: Indent guide toggle :IndentGuidesToggle, ,ig toggle
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236

" Show different colors for different levels of parentheses
" Usage: :RainbowToggle
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1

" NerdCommenter: Comment with shortcut keys
" Keys: ,cc comment, c<space> toggle comment, cu uncomment,
" c$ comment out till end of the line,
Plugin 'preservim/nerdcommenter.git'
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters
" Additional mappings to comment entire blocks (without motion support)
nnoremap <silent> <leader>cd :call nerdcommenter#Comment('n', 'uncomment')<CR>
nnoremap <silent> <leader>cap V}:call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <silent> <leader>cB V}:call nerdcommenter#Comment('x', 'toggle')<CR>

" TagBar: Browse the tags of the current file and get an overview of its structure
" Install brew install universal-ctags
" Note: Own key mappings in Tagbar, e.g. p,P open without jumping, ? for help
Plugin 'preservim/tagbar'
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>

" Gutentags: regenerate ctags in the background whenever files change
" (uses the same universal-ctags binary as Tagbar above)
Plugin 'ludovicchabant/vim-gutentags'
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Undotree: visualize and navigate the persistent undo history (undofile
" above only stores it; this makes it actually browsable, including
" branches you'd otherwise lose by undoing then editing differently)
Plugin 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2

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

" ALE: Async linting (replaces Syntastic, which is unmaintained)
" Command: ALEInfo - show which linters ALE found for the current buffer
Plugin 'dense-analysis/ale'
let g:ale_open_list = 1                  " Auto-open error list, if any
let g:ale_list_window_size = 5
let g:ale_set_signs = 1                  " Visualize errors at the beginning of each line
let g:ale_sign_error = "✗"               " Custom symbol for errors
let g:ale_sign_warning = "⚠"             " Custom symbol for warnings
let g:ale_set_balloons = 1               " Show balloons when the mouse is hovered
let g:ale_completion_enabled = 1         " LSP-backed completion popups (Tab still driven by SuperTab)
" ALE lints on every keystroke by default; keep the old Syntastic-like
" behaviour of only linting on save/open instead
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" Drop Syntastic's network-dependent 'w3' HTML checker; ALE runs every
" other detected linter per filetype by default when g:ale_linters is unset
let g:ale_linters = {'html': ['tidy']}

" vim-signature: Show marks next to lines
" Keys: ,m to toggle mark sign, m. toggle mark in line,  m? lists of marks 
"       mx place a mark x, dmx delete
Plugin 'kshenoy/vim-signature'
" Toggle marks visibility on screen
nnoremap <Leader>m :SignatureToggle<CR>

" ListToggle: Easy toggle quickfix and location lists
" Keys: ,q toggle quickfix list, ,l toggle location list
Plugin 'Valloric/ListToggle'
let g:lt_height = 5 " Height of the opened window

"vim-peekaboo: Show content of registers in a split window,
" " or @ to toggle, or C-R in INSERT (then symbol to paste)
Plugin 'junegunn/vim-peekaboo'

" For now use SnipMate insted of UltiSnip
" Ultis, Bash likenip: Enable snippet injection
" Note: xterm does not recognize the difference between C-Tab, S-Tab, Tab
let g:use_ultisnips = 0 " Set to 1 to switch back to UltiSnips
if (g:use_ultisnips && has("py3" ))
  Plugin 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<Tab>"
  let g:UltiSnipsJumpBackwardTrigger="<S-Tab>" " Will not work in xterm
  let g:UltiSnipsListSnippets="<C-l>"          " Applies to Insert mode only
  function! GetSnipsInCurrentScope() " Required for AutoComplPop
     return UltiSnips#SnippetsInCurrentScope()
  endfunction
else
  Plugin 'MarcWeber/vim-addon-mw-utils' " Dependency of snipmate
  Plugin 'tomtom/tlib_vim.git' " Dependency of snipmate
  Plugin 'garbas/vim-snipmate'
" List all snipets in this context
  imap <M-n> <Plug>snipMateShow
  imap <M-j> <Plug>snipMateNextOrTrigger
endif

Plugin 'honza/vim-snippets' "Snipets repository

" Airline: more functional status line
Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1 " Show ALE error/warning counts in the statusline
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline#extensions#tmuxline#enabled = 0

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
  " Execute the current file (TODO: works for executable scripts only)
  nnoremap <Leader>rr :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
  " Inspect runner pane
  nnoremap <Leader>ri :VimuxInspectRunner<CR>
  " Close vim tmux runner opened by VimuxRunCommand
  nnoremap <Leader>rx :VimuxCloseRunner<CR>

  " TODO: Currently not used
  " Dispatch: build asynchroneously in tmux
  " Commands: Make, Make!, Dispatch
  " Plugin 'tpope/vim-dispatch'
  " nnoremap <F9> :Dispatch<CR> " Remap F9 to run compiler asynchroneusly
endif

" a: Easy toggling between .c and .h files
" Keys ,a
Plugin 'vim-scripts/a.vim'
nnoremap <Leader>a :A<CR>

" Colorsque: Automatically visualize css color codes
Plugin 'gko/vim-coloresque'

" I don't really use vimwiki
" Vimwiki: Personal wiki within of Vim
"          Note: I modified the script to disable default bindings
" Keys:,h open wiki (help), ,hn make a note
" Plugin 'vim-scripts/vimwiki'
" nmap <Leader>h <Plug>VimwikiIndex
" nmap <Leader>hn <Plug>VimwikiMakeDiaryNote

" Load colorscheme
Plugin 'NLKNguyen/papercolor-theme'

" Easily align lines (e.g. variabe definitions)
" Example: gaip= start command (ga) for inner paragraph (ip)
"          and align around ="
Plugin 'junegunn/vim-easy-align' " align spaces before =
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" SuperTab: auto-completion with Tab in Insert mode
" Key: Tab
Plugin 'ervandew/supertab'
" Enable SuperTab with SnipMate and OmniComplete
let g:SuperTabDefaultCompletionType = '<C-n>' " Use <Ctrl-n> for default completion
" SuperTab behavior with SnipMate
let g:SuperTabContextDefaultCompletionType = 'context'
" Custom SuperTab mappings
let g:SuperTabMappingForward = '<Tab>'
let g:SuperTabMappingBackward = '<S-Tab>'

" Copilot: AI-powered code completion
" Commands: :Copilot setup (first time), :Copilot enable/disable
Plugin 'github/copilot.vim'
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-Y> copilot#Accept("\<CR>")

" Improved asterisk *
" Useful for z*cgn and then . (replace next search pattern)
Plugin 'haya14busa/vim-asterisk'
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

Plugin 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey ','<CR>
" By default timeoutlen is 1000 m_s
set timeoutlen=500

" ---- Considered but not added (reviewed 2026-09-07); revisit if the itch
" ---- comes back ----
" - tpope/vim-obsession: auto session (window/tab/buffer layout)
"   persistence, complementing the mkview/loadview per-buffer state below.
"   Pair it with `set sessionoptions-=options`.
" - ALE fixers (g:ale_fixers + g:ale_fix_on_save): auto-format on save,
"   reusing ALE's existing lint-on-save wiring. Start with just
"   '*': ['remove_trailing_lines', 'trim_whitespace'] before trusting it
"   with per-language formatters (black/prettier/gofmt).
" - editorconfig/editorconfig-vim: respect a project's .editorconfig over
"   our own indent defaults. Needs
"   g:EditorConfig_exclude_patterns = ['fugitive://.*'] to avoid errors on
"   fugitive's virtual buffers.
" - janko/vim-test: real test-runner (nearest/file/suite/last) via the
"   existing vimux strategy, replacing the ,rr "run current file" hack.
" - asyncomplete.vim + asyncomplete-lsp.vim: proper completion engine to
"   replace SuperTab+ALE completion. Lower priority while the Neovim
"   migration is already building the same thing via nvim-cmp.

" All of your Plugins must be added before the following line
call vundle#end()            " required

" -------------  General configuration -------------
" --------------------------------------------------
filetype plugin indent on " Detect filetype; load its plugin and indent files

set encoding=utf-8     " This line fixes encoding issues over SSH
set hidden             " Enable buffer change without saving
set autowrite          " Auto-write at any buffer operation or command
set updatetime=100     " Faster CursorHold events (snappier GitGutter/ALE signs)
set signcolumn=yes     " Always reserve the sign column so text doesn't shift
" set backup             " Auto-backup before rewrite.  NOTE: Might be annoying if you forget to close a buffer
set undofile           " Save undo history to an undo file, persistently stored
if has("win32")  " TODO: needs relative paths
"  set undodir=C:\vim\var\undo       " Where to store undo files
"  set viewdir=C:\vim\var\view       " Where to store view files
"  set directory=C:\vim\var\swp      " Where to store swap files
else
  set undodir=~/.vim/var/undo       " Where to store undo files
  set viewdir=~/.vim/var/view       " Where to store view files
  set directory=~/.vim/var/swp      " Where to store swap files
endif
set dictionary+=/usr/share/dict/words " " Load file for keyword autocompletion (^X^K)
set thesaurus+=~/.vim/thesaurus/mthesaur.txt " Load file for thesaurus (^X^T)
set tags=./tags,tags    " Automatically load tags file

" NOTE (trade-off, kept deliberately): this fires on every BufLeave, not just
" window-manager focus loss, so ALE lints/writes can run against buffer
" states you didn't consciously choose to save. Convenient day-to-day; if it
" ever causes surprise writes, scope it down to `autocmd FocusLost ?* ...`.
autocmd FocusLost,BufLeave ?* silent! wa      " Auto-save when focus is lost (GUI)
" &buftype ==# '' excludes quickfix/location-list/help/etc. windows: without
" it, ALE's async loclist popping open during quit (g:ale_open_list) fires
" this on a loclist buffer and loadview's implicit buffer switch collides
" with Vim's shutdown, raising E788 (see SNR ... VimCloseCallback errors)
autocmd BufWinLeave ?* if &buftype ==# '' | mkview | endif " Auto-save session when closing a buffer (?* to apply for files only)
autocmd BufWinEnter ?* if &buftype ==# '' | silent loadview | endif " Restore session when opening a buffer
autocmd! BufWritePost $MYVIMRC source $MYVIMRC " Auto reload $MYVIMRC when editing it

" Keys:
" Default make/compile key
noremap <silent> <F9> :make<CR>

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
" DECISION: not setting clipboard=unnamedplus. The <Leader>y/Y/yy/yap/p/P
" mappings above already give explicit, deliberate control over when the
" system clipboard is touched; 'unnamedplus' would make every yank/delete
" silently overwrite it instead.
set textwidth=79          " Max number of columns, for auto line breaking
set report=0              " Always show count of modifications (e.g. substitution)
set omnifunc=syntaxcomplete#Complete " Omnicomplete function for C^X+C^O
" autocmd BufWrite * :call DeleteTrailingWS() " Automatically delete trailing spaces when programming

"Abbrevs: (expand in Insert mode)
iab xdate <c-r>=strftime("%c")<cr>

" -------------  Navigation -------------
" Splits:
set splitright            " Open vertical splits to the right of the current window
set splitbelow            " Open horizontal splits below the current window

" Mouse:
set mouse=nvi             " Enable the use of the mouse (Works in GUI, but not in all terminals)
set mousemodel=popup      " Popup options on mouse hover. Works with gvim.

" Cursor: Move cursor by one physical line (and not a wrapped one)
set sidescroll=5       " Acceleration of horizontal scrolling. Jump by 5 col
set whichwrap=h,l      " Allow to jump to the next/previous line by overrun
set scrolljump=5       " Number of lines to scroll when the cursor gets off the screen
set scrolloff=3        " Number of lines to keep above/below for context info

" Folding:
" set foldmethod=indent " Default fold method (indent) (alternative: syntax)
set foldmethod=syntax " Default fold method (indent) (alternative: syntax)
set foldnestmax=3     " Maximal number of nested folds
set nofoldenable      " By default all folds are open
nnoremap + zo         " Shortcut for quicker opening of folds
nnoremap - zc         " Shortcut for quicker closing of folds

" ------------- Search  -------------
set incsearch                    " Highlight matches as you type in the search string
set ignorecase                   " When searching ignore case (except explicit caps)
set nohlsearch                   " Do NOT highlight previous matches of a search pattern
set smartcase                    " Case insensitive searches become casesensitive
nnoremap <leader>nh :nohlsearch<CR> " Shortcut to disable current highlighting

syntax on               " Syntax highlighting
hi comment ctermfg=grey " Adapt colors of comments
" set nowrap           " Don't break lines (doesn't affect the file) -- disabled: conflicts with the gj/gk remap above, which only makes sense when lines wrap
if exists('+breakindent')
    set breakindent showbreak=\ ++ " If lines are wrapped, mark with ++
endif
set showcmd            " Show the current command in the last line (on the right)
set wildmenu           " Display autocompletion options above the command line
set wildmode=longest:full,full " Completion mode that is used
set wildignore+=*.o,*.obj " Ignored during autocompletion
set wildignore+=*/node_modules/*,*/.git/*,*/__pycache__/*,*/.venv/* " Ignore heavy/vendored dirs
" set completeopt=longest
set completeopt=menu,menuone,popup
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

highlight ColorColumn ctermbg=magenta guibg=#592929 " Overlength highlighting
set colorcolumn=+1                                  " Track 'textwidth' dynamically

nnoremap <silent> <C-L> :nohls<CR><C-L>  " C-L should clean highlighted search too

" -------------  Filetypes -------------
autocmd BufNewFile,BufRead *.tex,*.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif " Define text filetype
autocmd BufRead,BufNewFile *.pde set filetype=arduino " Define a type for arduino
autocmd BufRead,BufNewFile *.ino set filetype=arduino " Define a type for arduino

augroup FileTypeOptions
autocmd!

" Text:
autocmd FileType text setlocal spell spelllang=en_us " Turn on the spell checker (US English)
" setlocal spell spelllang=de                        " Set the language to German
autocmd FileType gitcommit,svn,*commit* setlocal spell " Spell check when writing commit logs

" Shell:
autocmd FileType sh iab #! #!/bin/<C-R>=&ft<CR>
autocmd FileType sh set makeprg=sh\ %

" Python:
autocmd FileType python setlocal ts=4
autocmd FileType python setlocal sw=4
autocmd FileType python setlocal sts=4
autocmd FileType python,ruby,perl iab #! #!/usr/bin/env<Space><C-R>=&ft<CR>
autocmd FileType python set makeprg=python3\ %

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
  set background=dark  " light to rhange default background to white
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
