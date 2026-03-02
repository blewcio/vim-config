-- Utility plugins

return {
  -- Which-key (show keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "single",
          position = "bottom",
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
        },
      })

      -- Register leader key to show which-key
      vim.keymap.set("n", "<leader>", function()
        require("which-key").show({ keys = ",", loop = false })
      end, { desc = "Show keymaps" })
    end,
  },

  -- Indent guides (replaces vim-indent-guides)
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
    },
  },

  -- Rainbow parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Vim signature (marks)
  {
    "kshenoy/vim-signature",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<Leader>m", "<cmd>SignatureToggle<cr>", desc = "Toggle marks" },
    },
  },

  -- ListToggle (quickfix and location list)
  {
    "Valloric/ListToggle",
    keys = {
      { "<leader>q", desc = "Toggle quickfix" },
      { "<leader>l", desc = "Toggle location list" },
    },
    config = function()
      vim.g.lt_height = 5
    end,
  },

  -- Peekaboo (register preview)
  {
    "junegunn/vim-peekaboo",
    event = "VeryLazy",
  },

  -- Coloresque (visualize color codes)
  {
    "gko/vim-coloresque",
    ft = { "css", "scss", "html", "javascript", "typescript" },
  },

  -- Sensible defaults
  {
    "tpope/vim-sensible",
  },

  -- Unimpaired (bracket mappings)
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },

  -- A.vim (toggle between .c and .h)
  {
    "vim-scripts/a.vim",
    ft = { "c", "cpp" },
    keys = {
      { "<Leader>a", "<cmd>A<cr>", desc = "Alternate file" },
    },
  },
}
