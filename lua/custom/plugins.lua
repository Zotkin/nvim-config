local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "Pocco81/auto-save.nvim" -- autosave file
  -- colorsheme plugins
  use "catppuccin/nvim" -- colorsheme
  use "folke/tokyonight.nvim" -- colorscheme
  -- completion clugins
  use "hrsh7th/nvim-cmp" -- completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completion
  use "hrsh7th/cmp-nvim-lua" -- lua completion

  -- snippets
  use "L3MON4D3/LuaSnip" -- snippet support
  use "rafamadriz/friendly-snippets" -- snippet completions
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- language server installer
  use "williamboman/mason-lspconfig.nvim" -- bridge between lspconfig and mason
  use "jose-elias-alvarez/null-ls.nvim" -- LSP diagnostics
  -- File search
  use "nvim-telescope/telescope.nvim"
  -- Better synthax highlight
  use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
  }
  -- colored parantesis
  use "HiPhish/nvim-ts-rainbow2"
  -- autopairs
  use "windwp/nvim-autopairs"
  -- git integration
  use "lewis6991/gitsigns.nvim"
  -- icons for nvtree
  use "nvim-tree/nvim-web-devicons"
  -- navigation tree
  use "nvim-tree/nvim-tree.lua"
  -- tab bar
  use "moll/vim-bbye"
  use "akinsho/bufferline.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
