lua = require('plugins')
local lsp = require "lspconfig"
local coq = require "coq"
require("nvim-autopairs").setup {}
require('lualine').setup()

vim.cmd('COQnow -s')
vim.cmd('colorscheme dracula')

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

