-- Options configuration
-- Converted from .vimrc settings

local opt = vim.opt

-- General settings
opt.encoding = "utf-8"
opt.hidden = true              -- Enable buffer change without saving
opt.autowrite = true           -- Auto-write at any buffer operation
opt.undofile = true            -- Persistent undo
opt.backup = false             -- Disable backup (was commented out in .vimrc)

-- Undo, backup, swap, and view directories
local data_dir = vim.fn.stdpath("data")
opt.undodir = data_dir .. "/undo"
opt.backupdir = data_dir .. "/backup"
opt.directory = data_dir .. "/swp"
opt.viewdir = data_dir .. "/view"

-- Dictionary and thesaurus
opt.dictionary:append("/usr/share/dict/words")
local thesaurus_path = vim.fn.expand("~/.vim/thesaurus/mthesaur.txt")
if vim.fn.filereadable(thesaurus_path) == 1 then
  opt.thesaurus:append(thesaurus_path)
end

-- Tags
opt.tags = "./tags,tags"

-- Editing
opt.expandtab = true           -- Expand <Tab> to spaces
opt.autoindent = true          -- Copy indent from current line
opt.shiftwidth = 2             -- Default shift width
opt.softtabstop = 2            -- Default tab width
opt.tabstop = 2                -- Tab display width
opt.shiftround = true          -- Round indent to multiple of shiftwidth
opt.smarttab = true            -- sw at start of line, sts elsewhere
opt.backspace = "indent,eol,start" -- Enable backspace over lines
opt.linebreak = true           -- Break lines at convenient points
opt.textwidth = 79             -- Max columns for auto line breaking
opt.report = 0                 -- Always show count of modifications

-- Completion
opt.completeopt = "menu,menuone,popup"
opt.omnifunc = "syntaxcomplete#Complete"

-- Navigation
opt.mouse = "nvi"              -- Enable mouse (normal, visual, insert)
opt.mousemodel = "popup"       -- Popup on mouse hover
opt.sidescroll = 5             -- Horizontal scrolling acceleration
opt.whichwrap = "h,l"          -- Allow h,l to jump to next/prev line
opt.scrolljump = 5             -- Lines to scroll when cursor off screen
opt.scrolloff = 3              -- Lines to keep above/below for context

-- Folding
opt.foldmethod = "syntax"      -- Fold based on syntax
opt.foldnestmax = 3            -- Max nested folds
opt.foldenable = false         -- Start with folds open

-- Search
opt.incsearch = true           -- Highlight as you type
opt.ignorecase = true          -- Ignore case when searching
opt.hlsearch = false           -- Don't highlight previous matches
opt.smartcase = true           -- Case sensitive if uppercase present

-- Display
opt.syntax = "on"              -- Syntax highlighting
opt.wrap = false               -- Don't wrap lines
opt.breakindent = true         -- Indent wrapped lines
opt.showbreak = " ++"          -- Mark wrapped lines with ++
opt.showcmd = true             -- Show command in last line
opt.wildmenu = true            -- Command line completion menu
opt.wildmode = "longest:full,full" -- Completion mode
opt.wildignore:append({ "*.o", "*.obj" }) -- Ignore during completion
opt.number = true              -- Show line numbers
opt.relativenumber = true      -- Show relative line numbers
opt.numberwidth = 5            -- Width of line number column
opt.history = 500              -- Command/search history size
opt.cursorline = true          -- Highlight cursor line
opt.list = true                -- Display whitespaces
opt.listchars = {              -- Only show tabs and trailing spaces
  tab = "▷⋅",
  trail = "⋅",
  nbsp = "⋅",
}
opt.showmatch = true           -- Highlight matching brackets
opt.matchtime = 1              -- Bracket highlight time (1/10 second)
opt.laststatus = 2             -- Always show status line
opt.errorbells = false         -- No error bells
opt.visualbell = false         -- No visual bell

-- Terminal colors
opt.termguicolors = true
if vim.fn.has("termguicolors") == 1 then
  opt.termguicolors = true
end

-- Neovim specific
opt.clipboard = "unnamedplus"  -- Use system clipboard
opt.updatetime = 250           -- Faster completion
opt.timeoutlen = 500           -- Shorter timeout for which-key

-- Create necessary directories
local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

ensure_dir(vim.fn.stdpath("data") .. "/undo")
ensure_dir(vim.fn.stdpath("data") .. "/backup")
ensure_dir(vim.fn.stdpath("data") .. "/swp")
ensure_dir(vim.fn.stdpath("data") .. "/view")
