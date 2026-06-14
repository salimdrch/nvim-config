-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Clipboard système macOS
vim.opt.clipboard = "unnamedplus"

-- Indentation
vim.opt.tabstop    = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab  = true
vim.opt.smartindent = true

-- UI
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.scrolloff      = 8
vim.opt.sidescrolloff  = 8
vim.opt.wrap           = false
vim.opt.cursorline     = true
