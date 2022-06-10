local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local use = require("packer").use

return require("packer").startup(function()
	use("wbthomason/packer.nvim") -- let packer do cool stuff
	use("neovim/nvim-lspconfig") -- enable LSP
	use("ms-jpq/coq_nvim") -- fast as FUUUUUUUUUCK completion.
	use("ms-jpq/coq.artifacts") -- lots of snippets
	use("windwp/nvim-autopairs") -- autopair
	use("nvim-lua/plenary.nvim") -- useful functions
	use("dense-analysis/ale") -- formatters, linters, lsp shit
	use("dracula/vim") -- colorscheme
	use("nvim-lualine/lualine.nvim") -- cute line
	use("kyazdani42/nvim-web-devicons") -- cool icons
	use("lambdalisue/suda.vim")
end),
	
use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
