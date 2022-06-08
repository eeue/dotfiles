local use = require('packer').use
return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'ms-jpq/coq_nvim'
	use 'ms-jpq/coq.artifacts'
	use 'windwp/nvim-autopairs'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'dense-analysis/ale'
	use 'dracula/vim'
end)

