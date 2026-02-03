-- Neovim configuration converted from vimrc-code
-- Date: 2026-02-03

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- Folding
  { "tmhedberg/SimpylFold" },

  -- Python indentation
  { "vim-scripts/indentpython.vim" },

  -- Linting/Syntax checking (syntastic replacement for neovim)
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_linters = { python = { "flake8" } }
    end,
  },

  -- Colorscheme
  { "jnurmine/Zenburn" },

  -- Fuzzy finder (ctrlp replacement - telescope is the modern standard)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    },
  },

  -- Git integration
  { "tpope/vim-fugitive" },

  -- Ansible/YAML
  { "chase/vim-ansible-yaml" },
})

-- General settings
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.autoindent = true
vim.opt.startofline = false
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.cmdheight = 2
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200
vim.opt.number = true
vim.opt.scrolloff = 10

-- Syntax and filetype
vim.cmd("syntax on")
vim.cmd("filetype indent plugin on")

-- Colorscheme
vim.cmd("colorscheme zenburn")

-- Key mappings
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "<C-L>", ":nohl<CR><C-L>", { desc = "Clear search highlight" })

-- Highlight trailing whitespace
vim.cmd([[
highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/
]])

-- Python syntax highlighting
vim.g.python_highlight_all = 1

-- Code folding
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = "indent"

-- Diff mode mappings
if vim.opt.diff:get() then
  vim.keymap.set("n", "n", "]c", { buffer = true })
  vim.keymap.set("n", "N", "[c", { buffer = true })
  vim.keymap.set("n", "=", ":diffget<CR>", { buffer = true })
end

-- Autocommands
local augroup = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

-- Python settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = "unix"
  end,
})

-- YAML settings
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    vim.opt_local.filetype = "yaml"
    vim.opt_local.foldmethod = "indent"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
