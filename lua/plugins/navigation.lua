return {
  -- ─── fzf-lua ────────────────────────────────────────────────
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader><space>", desc = "Find files" },
      { "<leader>/",        desc = "Live grep" },
      { "<leader>fb",       desc = "Buffers" },
      { "<leader>fr",       desc = "Recent files" },
      { "<leader>fh",       desc = "Help tags" },
      { "<leader>fd",       desc = "Diagnostics" },
      { "<leader>fs",       desc = "Symbols fichier" },
      { "<leader>fS",       desc = "Symbols workspace" },
      { "<leader>fc",       desc = "Git commits" },
      { "<leader>fB",       desc = "Git branches" },
    },
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        winopts = {
          height  = 0.85,
          width   = 0.85,
          preview = { layout = "horizontal", ratio = 55 },
        },
        files = {
          fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude .terraform",
        },
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden",
        },
      })

      local map = vim.keymap.set
      map("n", "<leader><space>", fzf.files,       { desc = "Find files" })
      map("n", "<leader>/",       fzf.live_grep,   { desc = "Live grep" })
      map("n", "<leader>fb",      fzf.buffers,     { desc = "Buffers" })
      map("n", "<leader>fr",      fzf.oldfiles,    { desc = "Recent files" })
      map("n", "<leader>fh",      fzf.help_tags,   { desc = "Help tags" })
      map("n", "<leader>fd",      fzf.diagnostics_workspace, { desc = "Diagnostics" })
      map("n", "<leader>fs",      fzf.lsp_document_symbols,  { desc = "Symbols fichier" })
      map("n", "<leader>fS",      fzf.lsp_workspace_symbols, { desc = "Symbols workspace" })
      map("n", "<leader>fc",      fzf.git_commits, { desc = "Git commits" })
      map("n", "<leader>fB",      fzf.git_branches,{ desc = "Git branches" })
    end,
  },

  -- ─── oil.nvim ───────────────────────────────────────────────
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<leader>e", desc = "Oil (dossier courant)" },
      { "<leader>E", desc = "Oil (flottant)" },
      { "-",         desc = "Oil parent" },
    },
    -- default_file_explorer=true intercepte normalement "nvim ." / "nvim <dir>",
    -- mais ça suppose oil déjà chargé. En lazy-loading via keys/cmd, on doit
    -- forcer le chargement nous-mêmes si l'argument de démarrage est un répertoire.
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          local arg = vim.fn.argv(0)
          if arg ~= "" and vim.fn.isdirectory(vim.fn.expand(arg)) == 1 then
            require("lazy").load({ plugins = { "oil.nvim" } })
            vim.cmd.edit(arg)
          end
        end,
      })
    end,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = false,
        view_options = {
          show_hidden = true,
        },
        float = {
          padding = 2,
          max_width = 80,
          max_height = 30,
        },
        keymaps = {
          ["g?"]  = "actions.show_help",
          ["<CR>"]= "actions.select",
          ["<C-v>"]= "actions.select_vsplit",
          ["<C-s>"]= "actions.select_split",
          ["-"]   = "actions.parent",
          ["_"]   = "actions.open_cwd",
          ["gs"]  = "actions.change_sort",
          ["gx"]  = "actions.open_external",
          ["g."]  = "actions.toggle_hidden",
          ["q"]   = "actions.close",
        },
      })

      -- Ouvrir oil dans le dossier du fichier courant
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>",       { desc = "Oil (dossier courant)" })
      vim.keymap.set("n", "<leader>E", "<cmd>Oil --float<cr>", { desc = "Oil (flottant)" })
      -- Remplace netrw : - pour remonter d'un niveau
      vim.keymap.set("n", "-", "<cmd>Oil<cr>",               { desc = "Oil parent" })
    end,
  },
}
