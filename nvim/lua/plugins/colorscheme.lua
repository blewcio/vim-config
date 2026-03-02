-- Colorscheme configuration
-- Using PaperColor theme like in .vimrc

return {
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.cmd([[colorscheme PaperColor]])
      -- Custom highlight for comments
      vim.cmd([[hi comment ctermfg=grey]])
    end,
  },
}
