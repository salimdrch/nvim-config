return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 400,
        virt_text_pos = "eol",
      },
      on_attach = function(buf)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
        end
        local gs = require("gitsigns")

        -- Navigation hunks
        map("]h", gs.next_hunk,        "Hunk suivant")
        map("[h", gs.prev_hunk,        "Hunk précédent")

        -- Actions
        map("<leader>gs", gs.stage_hunk,    "Stage hunk")
        map("<leader>gr", gs.reset_hunk,    "Reset hunk")
        map("<leader>gS", gs.stage_buffer,  "Stage buffer")
        map("<leader>gR", gs.reset_buffer,  "Reset buffer")
        map("<leader>gp", gs.preview_hunk,  "Preview hunk")
        map("<leader>gb", gs.blame_line,    "Blame ligne")
        map("<leader>gd", gs.diffthis,      "Diff this")
      end,
    },
  },
}
