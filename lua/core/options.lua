local opt = vim.opt

-- Clipboard
opt.clipboard     = "unnamedplus"

-- Indentation
opt.tabstop       = 2
opt.shiftwidth    = 2
opt.expandtab     = true
opt.smartindent   = true

-- UI
opt.number        = true
opt.relativenumber = true
opt.cursorline    = true
opt.scrolloff     = 8
opt.sidescrolloff = 8
opt.wrap          = false
opt.signcolumn    = "yes"
opt.colorcolumn   = "120"
opt.termguicolors = true

-- Recherche
opt.ignorecase    = true
opt.smartcase     = true
opt.hlsearch      = false
opt.incsearch     = true

-- Fichiers
opt.undofile      = true
opt.swapfile      = false
opt.backup        = false
opt.undodir       = vim.fn.stdpath("state") .. "/undo"

-- Splits
opt.splitbelow    = true
opt.splitright    = true

-- Performance
opt.updatetime    = 250
opt.timeoutlen    = 300
opt.lazyredraw    = false

-- Completion
opt.completeopt   = "menu,menuone,noselect"

-- Apparence
opt.showmode      = false
opt.pumheight     = 10
