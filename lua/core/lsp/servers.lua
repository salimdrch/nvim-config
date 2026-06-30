local M = {}

M.list = { "terraformls", "yamlls", "bashls", "dockerls", "pyright", "ansiblels" }

-- Résout le chemin d'un binaire installé par Mason.
-- Nécessaire sur Neovim 0.12 : vim.lsp.config() est appelé avant que
-- mason-lspconfig n'ait enregistré les cmd des serveurs installés.
local function mason_bin(name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. name
end

function M.configure()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  vim.lsp.config("terraformls", {
    cmd = { mason_bin("terraform-ls"), "serve" },
    capabilities = capabilities,
    filetypes = { "terraform", "tf" },
  })

  vim.lsp.config("yamlls", {
    cmd = { mason_bin("yaml-language-server"), "--stdio" },
    capabilities = capabilities,
    filetypes = { "yaml" },
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
          ["h:qttps://json.schemastore.org/docker-compose.json"] = "/*docker-compose*.yml",
        },
        validate = true,
        completion = true,
        hover = true,
      },
    },
  })

  vim.lsp.config("bashls", {
    cmd = { mason_bin("bash-language-server"), "start" },
    capabilities = capabilities,
    filetypes = { "sh", "bash", "zsh" },
  })

  vim.lsp.config("dockerls", {
    cmd = { mason_bin("docker-langserver"), "--stdio" },
    capabilities = capabilities,
    filetypes = { "dockerfile" },
  })

  vim.lsp.config("pyright", {
    cmd = { mason_bin("pyright-langserver"), "--stdio" },
    capabilities = capabilities,
    filetypes = { "python" },
  })

  vim.lsp.config("ansiblels", {
    cmd = { mason_bin("ansible-language-server"), "--stdio" },
    capabilities = capabilities,
    filetypes = { "yaml.ansible" },
  })
end

return M
