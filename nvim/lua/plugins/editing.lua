-- Editing enhancement plugins

return {
  -- Comment (replaces nerdcommenter)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>cc", mode = { "n", "v" } },
      { "<leader>c<space>", mode = { "n", "v" } },
      { "<leader>cu", mode = { "n", "v" } },
      { "gc", mode = { "n", "v" } },
      { "gb", mode = { "n", "v" } },
    },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        toggler = {
          line = "<leader>cc",
          block = "<leader>cB",
        },
        opleader = {
          line = "<leader>c",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
        },
      })

      -- Additional mappings to match .vimrc
      local api = require("Comment.api")
      vim.keymap.set("n", "<leader>c<space>", api.toggle.linewise.current, { desc = "Toggle comment" })
      vim.keymap.set("n", "<leader>cu", api.uncomment.linewise.current, { desc = "Uncomment" })
      vim.keymap.set("n", "<leader>cd", api.uncomment.linewise.current, { desc = "Uncomment" })
      vim.keymap.set("n", "<leader>cap", "V}gc", { remap = true, desc = "Comment paragraph" })
    end,
  },

  -- Surround (keep vim-surround, it works great)
  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Repeat (for plugin actions)
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Align (replaces vim-easy-align)
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Align" },
    },
  },

  -- Move lines (keep vim-move)
  {
    "matze/vim-move",
    keys = { { "<A-h>", mode = { "n", "v" } }, { "<A-j>", mode = { "n", "v" } }, { "<A-k>", mode = { "n", "v" } }, { "<A-l>", mode = { "n", "v" } } },
  },

  -- Abolish (for substitution)
  {
    "tpope/vim-abolish",
    cmd = { "Abolish", "Subvert", "S" },
  },

  -- Enhanced matchit
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Asterisk (improved *)
  {
    "haya14busa/vim-asterisk",
    keys = {
      { "*", "<Plug>(asterisk-*)", mode = { "n" }, desc = "Search word under cursor" },
      { "#", "<Plug>(asterisk-#)", mode = { "n" }, desc = "Search word under cursor backwards" },
      { "g*", "<Plug>(asterisk-g*)", mode = { "n" } },
      { "g#", "<Plug>(asterisk-g#)", mode = { "n" } },
      { "z*", "<Plug>(asterisk-z*)", mode = { "n" } },
      { "gz*", "<Plug>(asterisk-gz*)", mode = { "n" } },
      { "z#", "<Plug>(asterisk-z#)", mode = { "n" } },
      { "gz#", "<Plug>(asterisk-gz#)", mode = { "n" } },
    },
  },
}
