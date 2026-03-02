-- Autocommands
-- Converted from .vimrc autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-save when focus is lost
autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wa",
  desc = "Auto-save when focus lost",
})

-- Auto-save and restore view (session)
local view_group = augroup("AutoView", { clear = true })
autocmd("BufWinLeave", {
  group = view_group,
  pattern = "?*",
  command = "silent! mkview",
  desc = "Save view when leaving buffer",
})
autocmd("BufWinEnter", {
  group = view_group,
  pattern = "?*",
  command = "silent! loadview",
  desc = "Restore view when entering buffer",
})

-- Auto reload vimrc when edited
autocmd("BufWritePost", {
  pattern = vim.fn.expand("$MYVIMRC"),
  command = "source $MYVIMRC",
  desc = "Auto reload config on save",
})

-- Filetype specific settings
local filetype_group = augroup("FileTypeOptions", { clear = true })

-- Text files
autocmd("FileType", {
  group = filetype_group,
  pattern = "text",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
  desc = "Enable spell check for text files",
})

-- Git commit messages
autocmd("FileType", {
  group = filetype_group,
  pattern = { "gitcommit", "svn", "*commit*" },
  callback = function()
    vim.opt_local.spell = true
  end,
  desc = "Enable spell check for commit messages",
})

-- Shell scripts
autocmd("FileType", {
  group = filetype_group,
  pattern = "sh",
  callback = function()
    vim.cmd([[iab <buffer> #! #!/bin/sh]])
    vim.opt_local.makeprg = "sh %"
  end,
  desc = "Shell script settings",
})

-- C files
autocmd("FileType", {
  group = filetype_group,
  pattern = "c",
  callback = function()
    vim.keymap.set("n", "<F8>", ":!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>",
      { buffer = true, silent = true, desc = "Generate ctags" })
  end,
  desc = "C file settings",
})

-- Python files
autocmd("FileType", {
  group = filetype_group,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.makeprg = "python %"
    vim.cmd([[iab <buffer> #! #!/usr/bin/env python]])
  end,
  desc = "Python file settings",
})

-- Ruby files
autocmd("FileType", {
  group = filetype_group,
  pattern = "ruby",
  callback = function()
    vim.cmd([[iab <buffer> #! #!/usr/bin/env ruby]])
  end,
  desc = "Ruby file settings",
})

-- Perl files
autocmd("FileType", {
  group = filetype_group,
  pattern = "perl",
  callback = function()
    vim.opt_local.makeprg = "perl %"
    vim.cmd([[iab <buffer> #! #!/usr/bin/env perl]])
  end,
  desc = "Perl file settings",
})

-- LaTeX files
autocmd("FileType", {
  group = filetype_group,
  pattern = "tex",
  callback = function()
    vim.g.Tex_DefaultTargetFormat = "pdf"
    vim.g.Tex_CompileRule_pdf = "pdflatex --file-line-error --interaction=nonstopmode $*"
  end,
  desc = "LaTeX file settings",
})

-- HTML files
autocmd("FileType", {
  group = filetype_group,
  pattern = "html",
  callback = function()
    vim.opt_local.textwidth = 0
    -- Auto-close tags with Ctrl-_
    vim.keymap.set("i", "<C-_>", "</<C-X><C-O><CR>", { buffer = true })

    -- F9 to open in browser
    if vim.fn.has("mac") == 1 then
      vim.keymap.set("n", "<F9>", ":silent update<Bar>silent !open %:p &<CR><C-L>",
        { buffer = true, desc = "Open in browser" })
    else
      vim.keymap.set("n", "<F9>", ":silent update<Bar>silent !xdg-open %:p &<CR><C-L>",
        { buffer = true, desc = "Open in browser" })
    end
  end,
  desc = "HTML file settings",
})

-- Arduino files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_group,
  pattern = { "*.pde", "*.ino" },
  command = "setfiletype arduino",
  desc = "Set Arduino filetype",
})

-- Define text filetype for various extensions
autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_group,
  pattern = { "*.tex", "*.txt", "README", "INSTALL", "NEWS", "TODO" },
  callback = function()
    if vim.bo.filetype == "" then
      vim.bo.filetype = "text"
    end
  end,
  desc = "Set text filetype",
})

-- Highlight overlength (80+ columns)
autocmd({ "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[highlight OverLength ctermbg=magenta ctermfg=white guibg=#592929]])
    vim.fn.matchadd("OverLength", [[\%80v.\+]])
  end,
  desc = "Highlight lines over 80 columns",
})

-- Custom function for wiki mode
vim.api.nvim_create_user_command("WikiMode", function()
  vim.opt_local.textwidth = 0
  vim.opt_local.wrap = true
  print("Wiki mode: textwidth restriction off, text wrapping on")
end, { desc = "Enable wiki editing mode" })

-- Helper function to delete trailing whitespace
local function delete_trailing_ws()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.winrestview(save)
end

vim.api.nvim_create_user_command("DeleteTrailingWS", delete_trailing_ws,
  { desc = "Delete trailing whitespace" })
