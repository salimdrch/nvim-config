local specs = {}
vim.list_extend(specs, require("plugins.lsp.mason"))
vim.list_extend(specs, require("plugins.lsp.conform"))
return specs
