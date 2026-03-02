# Neovim Migration Guide

You have Neovim v0.11.5 installed. This guide explains your options for using your Vim configuration with Neovim.

## Current Status

**Vim Configuration**: `~/vim-config/.vimrc`
- 36+ plugins managed by Vundle
- Extensive key mappings (German keyboard)
- tmux integration
- Complete development setup

**Neovim Configuration**: `~/.config/nvim/init.lua`
- Minimal setup with lazy.nvim
- Only 3 plugins: claudecode.nvim, snacks.nvim, lazy.nvim
- Leader key set to Space (differs from your Vim's comma)

## Migration Options

### Option 1: Quick Start - Use Your Existing .vimrc (Simplest)

Neovim can read Vimscript. You can use your existing configuration immediately.

**Approach A: Symlink (recommended for testing)**
```bash
# Backup your current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup

# Create new nvim directory
mkdir -p ~/.config/nvim

# Symlink your vimrc as init.vim
ln -s ~/vim-config/.vimrc ~/.config/nvim/init.vim

# Symlink the .vim directory as nvim
ln -s ~/.vim ~/.config/nvim
```

**Approach B: Source from init.lua**
Add to `~/.config/nvim/init.lua`:
```lua
vim.cmd('source ~/vim-config/.vimrc')
```

**Pros:**
- Works immediately with all your plugins and settings
- No configuration rewrite needed
- Vundle plugins mostly work with Neovim

**Cons:**
- Doesn't use modern Neovim features
- Still using older Vundle instead of lazy.nvim
- Some Vim plugins have better Neovim alternatives

### Option 2: Modern Neovim Setup (Recommended Long-term)

Migrate your configuration to Lua with lazy.nvim and modern Neovim plugins.

**What needs to change:**
1. Plugin manager: Vundle → lazy.nvim
2. Configuration language: Vimscript → Lua (optional but recommended)
3. Some plugins have Neovim-specific alternatives

**Plugin Equivalents:**

| Vim Plugin (Vundle) | Neovim Alternative (lazy.nvim) | Notes |
|---------------------|--------------------------------|-------|
| `junegunn/fzf.vim` | `nvim-telescope/telescope.nvim` | More powerful, native |
| `preservim/nerdtree` | `nvim-tree/nvim-tree.lua` | Faster, Lua-based |
| `vim-airline/vim-airline` | `nvim-lualine/lualine.nvim` | Faster, modern |
| `vim-syntastic/syntastic` | `neovim/nvim-lspconfig` + `nvim-lint` | Native LSP support |
| `preservim/tagbar` | `stevearc/aerial.nvim` | LSP-based |
| `ervandew/supertab` | `hrsh7th/nvim-cmp` | Better completion |
| `tpope/vim-fugitive` | Keep it! Works great in Neovim | |
| `airblade/vim-gitgutter` | `lewis6991/gitsigns.nvim` | Faster, Lua-based |
| `easymotion/vim-easymotion` | `folke/flash.nvim` or `ggandor/leap.nvim` | Modern alternatives |
| Most tpope plugins | Keep them! They all work | |

**Pros:**
- Access to modern Neovim features (native LSP, Treesitter, Lua)
- Better performance
- Active ecosystem
- Built-in terminal, LSP, Treesitter

**Cons:**
- Requires time to migrate configuration
- Learning curve for Lua (though Vimscript still works)
- Need to set up all mappings again

### Option 3: Hybrid Approach

Keep both configurations but share common settings.

**Structure:**
```
~/.config/nvim/
├── init.lua                 # Neovim-specific setup
├── vimrc_common.vim         # Shared settings from .vimrc
└── lua/
    └── plugins/             # Lazy.nvim plugins
```

In `init.lua`:
```lua
-- Source shared Vimscript config
vim.cmd('source ~/.config/nvim/vimrc_common.vim')

-- Neovim-specific Lua config below
require("lazy").setup({...})
```

**Pros:**
- Best of both worlds
- Gradual migration
- Can test Neovim features while keeping Vim working

**Cons:**
- Maintaining two configs
- More complex setup

## Compatibility Issues Found

Most of your .vimrc will work with Neovim, but be aware:

1. **Python Provider**: Some plugins need Python support
   ```bash
   pip3 install pynvim
   ```

2. **Clipboard**: Neovim handles clipboard differently
   - Your `*` register mappings should work
   - May need `pbcopy`/`pbpaste` on macOS (already installed)

3. **GUI Differences**:
   - `has("gui_running")` is always false in terminal Neovim
   - Use a GUI like `neovide` or `nvim-qt` if needed

4. **Removed Features**:
   - `:scriptencoding` - Neovim is always UTF-8
   - Some `'term'` values differ

## My Recommendation

**For immediate use:**
1. Try Option 1A (symlink approach) first to test compatibility
2. This gets you productive immediately with your familiar setup

**For long-term:**
1. Gradually migrate to Option 2 over time
2. Start with key plugins: fzf → telescope, airline → lualine
3. Add LSP support for better language features
4. Keep your muscle memory with the same key mappings

## Quick Test

Before committing, test if your config works:

```bash
# Backup current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup

# Test your vimrc with Neovim
nvim -u ~/vim-config/.vimrc

# If it works well, proceed with symlinking
```

## Next Steps

Let me know which approach you prefer:
1. Quick migration (symlink your .vimrc)
2. Modern setup (I'll help convert your config to Lua + lazy.nvim)
3. Hybrid approach (gradual migration)

I can help you implement whichever option you choose!
