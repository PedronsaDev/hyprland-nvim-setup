-- Options configuration for Neovim
-- Clean, fast, and structured for C++ developers

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Indentation (4 spaces by default, guess-indent will adjust per project)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false -- Show absolute line numbers

-- Behavior
vim.opt.mouse = 'a'
vim.opt.showmode = false -- Done in lualine
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- List chars
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Clipboard sync (scheduled to improve startup performance)
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
