-- The initial configurations were copied from 
-- https://github.com/wbthomason/packer.nvim
--
-- however, it was also necessary to install it by running
-- the clone command first:
--
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--
--
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- here after, the things are added separately and
  -- no longer copied from packer.nvim

  -- Copied from https://github.com/nvim-telescope/telescope.nvim
  -- does fuzzy finding
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Copied from https://github.com/rose-pine/neovim
  -- for syntax colouring
  use({ 
	  'rose-pine/neovim', 
	  as = 'rose-pine',
	  config = function() 
		vim.cmd('colorscheme rose-pine')
	  end
  })

  -- Copied from https://github.com/nvim-treesitter/nvim-treesitter
  -- but tweaked to follow packer.nvim formatting
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
end)

