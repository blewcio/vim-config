-- Motion plugins (replaces easymotion, sneak, incsearch)

return {
  -- Flash (modern replacement for easymotion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
      },
      label = {
        uppercase = true,
        rainbow = {
          enabled = false,
          shade = 5,
        },
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          jump_labels = true,
          multi_line = true,
        },
      },
    },
    keys = {
      -- Replaces easymotion mappings from .vimrc
      { "<Leader><Leader>w", mode = { "n", "x", "o" }, function() require("flash").jump({ pattern = "\\<" }) end, desc = "Flash word" },
      { "<Leader><Leader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<Leader><Leader>j", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = "Flash line" },
      { "<Leader><Leader>k", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = "Flash line" },
      { "<Leader><Leader>l", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search" } }) end, desc = "Flash anywhere" },
      { "<Leader><Leader>h", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search" } }) end, desc = "Flash anywhere" },
      { "<Leader><Leader>;", mode = { "n", "x", "o" }, function() require("flash").jump({ continue = true }) end, desc = "Flash repeat" },
      -- Search integration
      { "/", mode = { "n" }, function() require("flash").jump({ search = { forward = true, wrap = true, multi_window = false } }) end, desc = "Flash search" },
      { "?", mode = { "n" }, function() require("flash").jump({ search = { forward = false, wrap = true, multi_window = false } }) end, desc = "Flash search backward" },
      -- Treesitter search
      { "<Space>/", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Vim-sneak (keep it as alternative for 2-char search)
  {
    "justinmk/vim-sneak",
    keys = {
      { "s", mode = { "n", "x", "o" } },
      { "S", mode = { "n", "x", "o" } },
    },
    config = function()
      vim.g["sneak#label"] = 1
    end,
  },
}
