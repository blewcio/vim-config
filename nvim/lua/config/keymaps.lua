-- Key mappings
-- Converted from .vimrc mappings

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap Esc to Ctrl-C in Insert mode
map("i", "<C-c>", "<Esc>", opts)

-- General key bindings - move by visual line
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("v", "j", "gj", opts)
map("v", "k", "gk", opts)

-- German keyboard remappings
-- ß -> /
map("n", "ß", "/", { noremap = true })
map("i", "ß", "/", { noremap = true })
map("v", "ß", "/", { noremap = true })
map("c", "ß", "/", { noremap = true })
map("x", "ß", "/", { noremap = true })

-- ¿ -> \
map("n", "¿", "\\", { noremap = true })
map("i", "¿", "\\", { noremap = true })
map("v", "¿", "\\", { noremap = true })
map("c", "¿", "\\", { noremap = true })
map("x", "¿", "\\", { noremap = true })

-- Ü -> ^
map("n", "Ü", "^", { noremap = true })
map("i", "Ü", "^", { noremap = true })
map("v", "Ü", "^", { noremap = true })
map("c", "Ü", "^", { noremap = true })
map("x", "Ü", "^", { noremap = true })

-- ü -> ~
map("n", "ü", "~", { noremap = true })
map("i", "ü", "~", { noremap = true })
map("v", "ü", "~", { noremap = true })
map("o", "ü", "~", { noremap = true })
map("c", "ü", "~", { noremap = true })
map("x", "ü", "~", { noremap = true })

-- ö -> [
map("n", "ö", "[", { noremap = true })
map("i", "ö", "[", { noremap = true })
map("v", "ö", "[", { noremap = true })
map("c", "ö", "[", { noremap = true })
map("o", "ö", "[", { noremap = true })
map("x", "ö", "[", { noremap = true })

-- ä -> ]
map("n", "ä", "]", { noremap = true })
map("i", "ä", "]", { noremap = true })
map("v", "ä", "]", { noremap = true })
map("c", "ä", "]", { noremap = true })
map("o", "ä", "]", { noremap = true })
map("x", "ä", "]", { noremap = true })

-- Ö -> {
map("n", "Ö", "{", { noremap = true })
map("i", "Ö", "{", { noremap = true })
map("v", "Ö", "{", { noremap = true })
map("c", "Ö", "{", { noremap = true })
map("o", "Ö", "{", { noremap = true })
map("x", "Ö", "{", { noremap = true })

-- Ä -> }
map("n", "Ä", "}", { noremap = true })
map("i", "Ä", "}", { noremap = true })
map("v", "Ä", "}", { noremap = true })
map("c", "Ä", "}", { noremap = true })
map("o", "Ä", "}", { noremap = true })
map("x", "Ä", "}", { noremap = true })

-- Bash-like movement in command line
map("c", "<C-A>", "<Home>", { noremap = true })
map("c", "<C-E>", "<End>", { noremap = true })
map("c", "<C-K>", "<C-U>", { noremap = true })
map("c", "<C-P>", "<Up>", { noremap = true })
map("c", "<C-N>", "<Down>", { noremap = true })

-- Save like in other applications
map("n", "<C-S>", ":write!<CR>", opts)

-- System clipboard shortcuts
map("n", "<Leader>p", '"*]p', opts)
map("n", "<Leader>P", '"*]P', opts)
map("n", "<Leader>y", '"+y', opts)
map("v", "<Leader>y", '"+y', opts)
map("n", "<Leader>Y", '"+y$', opts)
map("n", "<Leader>yap", '"+yap', opts)

-- Text operations
map("n", "Y", "y$", opts) -- Yank to end of line
map("n", "<leader>pp", ":setlocal paste!<CR>", { noremap = true, desc = "Toggle paste mode" })

-- Buffer operations
map("n", "<leader>x", ":bd<CR>", { noremap = true, desc = "Close buffer" })
map("n", ",e", ":e $MYVIMRC<CR>", { noremap = true, desc = "Edit config" })
map("n", ",s", ":source $MYVIMRC<CR>", { noremap = true, desc = "Source config" })

-- Buffer navigation (will be enhanced by plugin)
map("n", "gb", ":bnext<CR>", opts)
map("n", "gB", ":bprevious<CR>", opts)
map("n", "<leader>1", ":b1<CR>", opts)
map("n", "<leader>2", ":b2<CR>", opts)
map("n", "<leader>3", ":b3<CR>", opts)
map("n", "<leader>4", ":b4<CR>", opts)
map("n", "<leader>5", ":b5<CR>", opts)

-- Reload all buffers (e.g. when working with Claude)
map("n", "<Leader>r", ":bufdo e<CR>", { noremap = true, desc = "Reload all buffers" })

-- Folding shortcuts
map("n", "+", "zo", { noremap = true, desc = "Open fold" })
map("n", "-", "zc", { noremap = true, desc = "Close fold" })

-- Search
map("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, desc = "Clear highlight" })
map("n", "<C-L>", ":nohls<CR><C-L>", opts)

-- Make
map("n", "<F9>", ":make<CR>", { silent = true, desc = "Run make" })

-- Insert abbreviation for date
vim.cmd([[iab xdate <C-R>=strftime("%c")<CR>]])

-- Git hunks navigation (will be provided by gitsigns plugin)
-- These are placeholders, actual mappings in gitsigns config
-- map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
-- map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
