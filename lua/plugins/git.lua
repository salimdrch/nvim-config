return {
  -- Gitsigns : blame inline + hunks
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 400,
        virt_text_pos = "eol",
      },
    },
  },

  -- Lazygit via snacks (natif LazyVim, pas de dépendance externe)
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git blame ligne" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse (ouvre GitHub)" },
    },
  },
}
