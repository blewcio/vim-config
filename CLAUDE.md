# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains both classic Vim and modern Neovim configurations for a developer using a German keyboard layout with extensive customizations for navigation, editing, and development workflows.

Classic Vim is the daily driver. Migration to Neovim is in progress and just started, but Neovim is not yet actually used day-to-day — the `nvim/` config exists and is symlinked to `~/.config/nvim`, but Vim remains the default editor until the migration is further along.

**Two Configurations Available:**
- **Classic Vim** (`.vimrc` + `.vim/`) - Vimscript with Vundle plugin manager
- **Modern Neovim** (`nvim/`) - Lua-based with lazy.nvim plugin manager

Both configurations provide the same functionality and key mappings but use different plugin ecosystems.

## Setup and Installation

### Classic Vim Setup

To deploy the classic Vim configuration:
```bash
./deploy.sh
```

This script will:
1. Symlink `.vim/` and `.vimrc` to `$HOME`
2. Initialize git submodules (Vundle)
3. Install all Vim plugins via Vundle

To manually install/update plugins within Vim:
```vim
:PluginInstall    " Install configured plugins
:PluginUpdate     " Update all plugins
:PluginClean      " Remove unused plugins
```

### Neovim Setup

The Neovim configuration is already symlinked to `~/.config/nvim`:
```bash
~/.config/nvim -> ~/vim-config/nvim
```

On first launch, Neovim will automatically install lazy.nvim and all plugins. See `nvim/README.md` for details.

**Managing Neovim plugins:**
```vim
:Lazy             " Open plugin manager UI
:Lazy update      " Update all plugins
:Mason            " Manage LSP servers
```

## Architecture

### Core Components

1. **Plugin Manager**: Vundle (`.vim/bundle/Vundle.vim`) - manages all plugins
2. **Main Config**: `.vimrc` - single monolithic configuration file
3. **Supporting Directories**:
   - `.vim/bundle/` - Vundle-managed plugins
   - `.vim/var/` - Persistent state (undo, backup, swap, view files)
   - `.vim/spell/` - Spell checking dictionaries
   - `.vim/snippets/` - Custom code snippets
   - `.vim/thesaurus/` - Thesaurus for word completion

### Key Plugin Categories

**Navigation & Search**:
- `fzf.vim` / `ctrlp.vim` - Fuzzy file/buffer finding (Leader key mappings: `,of`, `,ob`, `,or`, `,og`)
- `vim-easymotion` + `incsearch-fuzzy.vim` - Quick cursor jumping (`,, + motion`, `,,/` for fuzzy jump)
- `nerdtree` - File tree explorer (F3)

**Editing & Text Manipulation**:
- `vim-surround` - Modify surrounding brackets/quotes
- `nerdcommenter` - Comment/uncomment (`,cc`, `,c<space>`)
- `vim-easy-align` - Align text around delimiters (`ga`)
- `vim-move` - Move lines/blocks with Alt+hjkl

**Git Integration**:
- `vim-fugitive` - Git commands in Vim
- `vim-gitgutter` - Show git diff in sign column (`]h`/`[h` to navigate hunks)

**Development Tools**:
- `ale` - Async linting on save, plus LSP-backed completion (auto-opens error list; replaces the unmaintained Syntastic)
- `tagbar` - Browse code structure (F8)
- `vim-gutentags` - Regenerates ctags in the background automatically (no manual key needed)
- `undotree` - Browse persistent undo history, including branches (`,u`)
- `supertab` - Tab completion in insert mode
- `vim-snipmate` / `ultisnips` - Code snippets

**Tmux Integration** (if tmux is installed):
- `vim-tmux-navigator` - Seamless pane switching (Ctrl+hjkl)
- `vimux` - Run commands in tmux pane (`,rr`, `,ri`, `,rx`)

### Leader Key Mappings

The leader key is `,` (comma). Important mappings:

**File Operations**:
- `,of` - Open files (fzf/CtrlP)
- `,ob` - Open buffers
- `,or` - Open recent files
- `,og` - Grep file contents (requires ripgrep)
- `,e` - Edit `.vimrc`
- `,s` - Source `.vimrc`

**Buffer Management**:
- `,b` - Buffer explorer
- `,x` - Close buffer
- `,r` - Reload all buffers
- `gb` / `gB` - Next/previous buffer
- `,1` through `,5` - Jump to buffer 1-5
- `,<Tab>` - Jump to alternate (last used) buffer

**Clipboard**:
- `,yy` / `,Y` - Yank line / yank to end of line, to system clipboard
- `,p` / `,P` - Paste from system clipboard

**Git**:
- `]h` / `[h` - Next/previous git hunk
- `,ho` - Open git hunks in QuickFix list
- `,hr` - Reload git gutter

**Toggle Features**:
- `,pp` - Toggle paste mode
- `,m` - Toggle mark visibility
- `,ig` - Toggle indent guides
- `,tt` - Toggle Tagbar
- `,u` - Toggle Undotree

### German Keyboard Remappings

The configuration extensively remaps keys for German keyboard layouts:
- `ß` → `/` (search)
- `¿` → `\` (backslash)
- `ö`/`ä` → `[`/`]` (brackets)
- `Ö`/`Ä` → `{`/`}` (braces)
- `ü`/`Ü` → `~`/`^` (tilde/caret)

## File Type Specific Behavior

- **Python**: 4-space tabs, makeprg set to `python %`
- **HTML**: F9 opens in browser, textwidth disabled
- **Text files**: Spell checking enabled (en_us)
- **Shell scripts**: Shebang auto-insertion, makeprg set to `sh %`

## Important Settings

- **Persistent undo**: Enabled, stored in `.vim/var/undo/`; browsable via Undotree (`,u`)
- **Auto-save**: On focus loss and buffer leave
- **View persistence**: Window state saved/restored automatically
- **Ctags**: Auto-regenerated in the background by vim-gutentags whenever files change (no manual key needed)
- **Line length**: 80 columns highlighted (magenta background)
- **Folding**: Syntax-based, disabled by default
- **Completion**: Omnicomplete enabled, dictionary and thesaurus configured

## Editing .vimrc

When modifying `.vimrc`:
- The configuration is a single monolithic file (~708 lines)
- Plugin declarations are between `call vundle#begin()` and `call vundle#end()` (.vimrc:106-473)
- General settings start at line 475
- Filetype-specific configurations are in autocmd groups starting at line 596
- The file auto-reloads on save (line 506)

## Common Tasks

**Add a new plugin**:
1. Add `Plugin 'author/plugin-name'` in the Vundle section (.vimrc:106-473)
2. Run `:PluginInstall` in Vim

**Modify key mapping**:
- Leader mappings are scattered throughout, search for `<leader>` or `<Leader>`
- Plugin-specific mappings are typically near their Plugin declaration

**Change color scheme**:
- Current: PaperColor (dark mode)
- Color configuration is at .vimrc:686-706

**Add snippet**:
- Place custom snippets in `.vim/snippets/`
- Shared snippets come from `honza/vim-snippets` plugin

## Neovim Configuration (nvim/)

### Structure

The Neovim configuration is organized in a modern Lua structure:

```
nvim/
├── init.lua                  # Entry point, bootstraps lazy.nvim
├── lua/
│   ├── config/
│   │   ├── options.lua       # All vim options (converted from .vimrc)
│   │   ├── keymaps.lua       # All key mappings (including German keyboard)
│   │   └── autocmds.lua      # Autocommands and filetype settings
│   └── plugins/
│       ├── colorscheme.lua   # PaperColor theme
│       ├── lualine.lua       # Statusline (replaces vim-airline)
│       ├── telescope.lua     # Fuzzy finder (replaces fzf/CtrlP)
│       ├── nvim-tree.lua     # File explorer (replaces NERDTree)
│       ├── git.lua           # Gitsigns + Fugitive
│       ├── editing.lua       # Comment, surround, align, etc.
│       ├── motion.lua        # Flash (replaces easymotion)
│       ├── completion.lua    # nvim-cmp (replaces SuperTab)
│       ├── treesitter.lua    # Syntax highlighting
│       ├── lsp.lua           # Native LSP (replaces ALE)
│       ├── tmux.lua          # Tmux integration
│       └── utilities.lua     # Various utilities
└── README.md                 # Full Neovim documentation
```

### Key Differences from Vim Config

**Plugin Equivalents:**
- Vundle → lazy.nvim (plugin manager)
- fzf/CtrlP → Telescope
- NERDTree → nvim-tree
- vim-airline → lualine
- ALE → Native LSP + nvim-lint
- tagbar → Aerial
- vim-easymotion → Flash
- SuperTab → nvim-cmp + LuaSnip

**Enhanced Features:**
- Native LSP support with auto-completion
- Treesitter for better syntax highlighting
- Mason for easy LSP server installation
- Lazy-loaded plugins for faster startup
- Modern floating windows and popups

**Preserved:**
- All key mappings (same leader key: `,`)
- German keyboard mappings
- All tpope plugins (fugitive, surround, repeat, etc.)
- Tmux integration (when tmux is installed)
- File type specific settings

### Modifying Neovim Config

**Add a new plugin:**
1. Create or edit a file in `nvim/lua/plugins/`
2. Add the plugin spec (see existing files for examples)
3. Restart Neovim or run `:Lazy sync`

**Change settings:**
- Edit `nvim/lua/config/options.lua` for vim options
- Edit `nvim/lua/config/keymaps.lua` for key mappings
- Edit `nvim/lua/config/autocmds.lua` for autocommands

**Install LSP servers:**
1. Open Neovim and run `:Mason`
2. Search for language server (e.g., `pyright`, `lua_ls`)
3. Press `i` to install

See `nvim/README.md` for comprehensive documentation.
