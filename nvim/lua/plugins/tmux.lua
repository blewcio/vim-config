-- Tmux integration (conditional, like in .vimrc)

return {
  -- Tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    cond = vim.fn.executable("tmux") == 1,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux navigate right" },
    },
  },

  -- Vimux
  {
    "preservim/vimux",
    cond = vim.fn.executable("tmux") == 1,
    keys = {
      {
        "<Leader>rr",
        function()
          vim.cmd('call VimuxRunCommand("clear; ./" . bufname("%"))')
        end,
        desc = "Run current file in tmux",
      },
      { "<Leader>ri", "<cmd>VimuxInspectRunner<cr>", desc = "Inspect tmux runner" },
      { "<Leader>rx", "<cmd>VimuxCloseRunner<cr>", desc = "Close tmux runner" },
    },
  },
}
