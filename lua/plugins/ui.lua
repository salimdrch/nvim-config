return {
  -- ─── Catppuccin ─────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        gitsigns   = true,
        treesitter = true,
        mason      = true,
        mini       = true,
        fzf        = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- ─── mini.nvim ──────────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()

      -- Statusline
      require("mini.statusline").setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git          = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics  = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename     = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo     = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location     = MiniStatusline.section_location({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
        },
      })

      -- Completion
      require("mini.completion").setup({
        delay = { completion = 100, info = 100, signature = 50 },
        window = {
          info      = { height = 25, width = 80, border = "rounded" },
          signature = { height = 25, width = 80, border = "rounded" },
        },
        lsp_completion = {
          source_func  = "omnifunc",
          auto_setup   = true,
        },
      })

      -- Pairs
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
      })

      -- Surround
      require("mini.surround").setup({
        mappings = {
          add            = "sa",
          delete         = "sd",
          find           = "sf",
          find_left      = "sF",
          highlight      = "sh",
          replace        = "sr",
          update_n_lines = "sn",
        },
      })

      -- Comment
      require("mini.comment").setup({
        mappings = {
          comment      = "gc",
          comment_line = "gcc",
          textobject   = "gc",
        },
      })

      -- Notifications
      require("mini.notify").setup({
        window = {
          config = function()
            return { border = "rounded" }
          end,
        },
      })

      -- Trailing whitespace
      require("mini.trailspace").setup()

    end,
  },
}
