# Neovim Configuration

Modern Neovim configuration converted from the legacy `.vimrc` setup, using Lua and lazy.nvim.

## Features

- **Plugin Manager**: lazy.nvim (replaces Vundle)
- **Colorscheme**: PaperColor (dark mode)
- **Fuzzy Finder**: Telescope (replaces fzf/CtrlP)
- **File Explorer**: nvim-tree (replaces NERDTree)
- **Statusline**: lualine (replaces vim-airline)
- **Git Integration**: gitsigns + fugitive (replaces gitgutter)
- **Completion**: nvim-cmp + LuaSnip (replaces SuperTab)
- **LSP**: Native LSP with Mason (replaces Syntastic)
- **Syntax**: Treesitter (enhanced syntax highlighting)
- **Motion**: Flash + vim-sneak (replaces easymotion)
- **Commenting**: Comment.nvim (replaces nerdcommenter)
- **Code Navigation**: Aerial (replaces tagbar)
- **Tmux Integration**: vim-tmux-navigator + vimux

## Installation

### Prerequisites

```bash
# Install Neovim (0.9.0+ required)
brew install neovim

# Install optional dependencies
brew install ripgrep fd fzf  # For telescope
brew install make            # For building telescope-fzf-native
```

### Setup

The configuration is located in `~/vim-config/nvim/`. To use it:

```bash
# Backup existing Neovim config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Symlink this config
ln -s ~/vim-config/nvim ~/.config/nvim

# Launch Neovim - plugins will auto-install
nvim
```

On first launch, lazy.nvim will automatically:
1. Install itself
2. Install all configured plugins
3. Set up LSP servers via Mason

### Post-Installation

After Neovim opens, you may want to:

```vim
" Install LSP servers
:Mason

" Install Treesitter parsers
:TSInstall bash c cpp css html javascript json lua markdown python vim

" Check health
:checkhealth
```

## Directory Structure

```
nvim/
├── init.lua              # Entry point, bootstraps lazy.nvim
├── lua/
│   ├── config/
│   │   ├── options.lua   # Vim options
│   │   ├── keymaps.lua   # Key mappings (including German keyboard)
│   │   └── autocmds.lua  # Autocommands and filetype settings
│   └── plugins/
│       ├── colorscheme.lua  # PaperColor theme
│       ├── lualine.lua      # Statusline
│       ├── telescope.lua    # Fuzzy finder
│       ├── nvim-tree.lua    # File explorer
│       ├── git.lua          # Git integration
│       ├── editing.lua      # Comment, surround, align, etc.
│       ├── motion.lua       # Flash and sneak
│       ├── completion.lua   # nvim-cmp setup
│       ├── treesitter.lua   # Syntax highlighting
│       ├── lsp.lua          # LSP configuration
│       ├── tmux.lua         # Tmux integration
│       └── utilities.lua    # Various utility plugins
└── README.md
```

## Key Mappings

All key mappings from the original `.vimrc` are preserved.

### Leader Key

Leader: `,` (comma)

### German Keyboard Mappings

- `ß` → `/` (search)
- `¿` → `\` (backslash)
- `ö`/`ä` → `[`/`]` (brackets)
- `Ö`/`Ä` → `{`/`}` (braces)
- `ü`/`Ü` → `~`/`^` (tilde/caret)

### File Operations

- `,of` - Find files (Telescope)
- `,ob` - Find buffers
- `,or` - Recent files
- `,og` - Grep files (requires ripgrep)
- `,ol` - Search in current buffer
- `,/` - Search keymaps
- `<F3>` - Toggle file tree

### Buffer Navigation

- `gb` / `gB` - Next/previous buffer
- `,1` through `,5` - Jump to buffer 1-5
- `,b` - Buffer explorer (via Telescope)
- `,x` - Close buffer
- `,r` - Reload all buffers

### Git

- `]h` / `[h` - Next/previous hunk
- `,hs` - Stage hunk
- `,hr` - Reset hunk
- `,hp` - Preview hunk
- `,ho` - Hunks to quickfix list

### Code Navigation (LSP)

- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Hover documentation
- `[d` / `]d` - Previous/next diagnostic
- `,ca` - Code actions
- `,rn` - Rename symbol
- `,f` - Format code

### Motion

- `,,w` - Flash to word
- `,,f` - Flash to character
- `,,j` / `,,k` - Flash to line
- `/` - Flash search (enhanced search)
- `s` + 2 chars - Sneak to location

### Editing

- `,cc` - Comment line
- `,c<space>` - Toggle comment
- `,cu` / `,cd` - Uncomment
- `ga` - Align (e.g., `gaip=` to align around `=`)
- `cs"'` - Change surrounding " to '
- `ds"` - Delete surrounding "
- `ys` + motion + char - Add surrounding

### Tmux (if tmux installed)

- `<C-h/j/k/l>` - Navigate between vim/tmux panes
- `,rr` - Run current file in tmux pane
- `,ri` - Inspect tmux runner
- `,rx` - Close tmux runner

### Other

- `<F8>` / `,tt` - Toggle code outline (Aerial)
- `,pp` - Toggle paste mode
- `+` / `-` - Open/close fold
- `,nh` - Clear search highlight
- `<C-S>` - Save file

## Plugin Management

### Install/Update Plugins

```vim
" Update all plugins
:Lazy update

" Open plugin manager UI
:Lazy

" Install a new plugin
" Add to lua/plugins/*.lua, then restart Neovim
```

### LSP Management

```vim
" Open Mason UI
:Mason

" Install a language server
:MasonInstall <server-name>

" Update all servers
:MasonUpdate
```

## Configuration Changes

To modify settings:

1. **Options**: Edit `lua/config/options.lua`
2. **Keymaps**: Edit `lua/config/keymaps.lua`
3. **Autocommands**: Edit `lua/config/autocmds.lua`
4. **Add Plugin**: Create/edit files in `lua/plugins/`

Changes take effect after `:source $MYVIMRC` or restarting Neovim.

## Differences from Original .vimrc

### Enhanced Features

- **Native LSP**: Better code intelligence than Syntastic
- **Treesitter**: Superior syntax highlighting
- **Telescope**: More powerful than fzf
- **Better Performance**: Lazy-loaded plugins
- **Modern UI**: Floating windows, better diagnostics

### Removed

- Vundle → lazy.nvim
- BufExplorer → Telescope buffers
- CtrlP → Telescope (when fzf not available)

### Kept as-is

- All tpope plugins (fugitive, surround, repeat, etc.)
- vim-signature (marks)
- vim-move
- vim-asterisk
- German keyboard mappings
- All custom autocommands

## Troubleshooting

### Plugins not installing

```vim
:Lazy sync
```

### LSP not working

```vim
:LspInfo
:Mason
```

### Treesitter errors

```vim
:TSUpdate
```

### General health check

```vim
:checkhealth
```

## Migration from Vim

Your original Vim configuration (`.vimrc`) remains unchanged at `~/vim-config/.vimrc`. Both configurations can coexist:

- Use `vim` for the classic Vimscript setup
- Use `nvim` for the modern Lua setup

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
