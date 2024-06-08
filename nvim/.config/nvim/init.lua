local api = vim.api
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt
local global_opt = vim.opt_global
local indent = 2
-- --------------------------------------------------------------------------
--  Setup
-- --------------------------------------------------------------------------
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '

-- Color Scheme
vim.cmd.colorscheme("desert")

-- window-scoped
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
--opt.foldmethod = "expr"
--opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.backspace = '2'
opt.showcmd = true
opt.autowrite = true
opt.autoread = true

-- buffer-scoped
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.shiftround = true
opt.expandtab = true
opt.fileformat = "unix"
opt.modeline = false

-- opt.mouse = ""

-- Line numbers
vim.wo.number = true

-- use spaces for tabs and whatnot

vim.api.nvim_create_autocmd("VimEnter", {
    command = "set nornu nonu | Neotree toggle",
})

vim.api.nvim_create_autocmd("BufEnter", {
    command = "set rnu nu",
})

-- global
local global_opt = vim.opt_global

global_opt.shortmess:append("c")
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 300
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" }
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.clipboard = "unnamed"
global_opt.completeopt = { "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5
global_opt.laststatus = 3
global_opt.mouse = ""

if g.light then
  global_opt.background = "light"
end

-- --------------------------------------------------------------------------
--  Lazy
-- --------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- --------------------------------------------------------------------------
--  Plugins
-- --------------------------------------------------------------------------
require("plugins")
-- require("lsp").setup()
-- require("diagnostic").setup()