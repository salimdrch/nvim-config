local M = {}

function M.setup()
  -- Keymaps LSP au attach
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
      end
      map("gd",         vim.lsp.buf.definition,     "Go to definition")
      map("gD",         vim.lsp.buf.declaration,    "Go to declaration")
      map("gr",         vim.lsp.buf.references,     "References")
      map("gi",         vim.lsp.buf.implementation, "Go to implementation")
      map("K",          vim.lsp.buf.hover,          "Hover doc")
      map("<leader>cr", vim.lsp.buf.rename,         "Rename")
      map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
      map("<leader>cf", vim.lsp.buf.format,         "Format")
      map("<leader>cd", vim.diagnostic.open_float,  "Diagnostic float")
      map("]d",         vim.diagnostic.goto_next,   "Diagnostic suivant")
      map("[d",         vim.diagnostic.goto_prev,   "Diagnostic précédent")
    end,
  })

  -- Diagnostics
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })
end

return M
