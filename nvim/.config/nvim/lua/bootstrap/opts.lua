vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- Color Scheme
vim.cmd.colorscheme("desert")

-- vim.opt.mouse = ""

-- Line numbers
vim.wo.number = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("VimEnter", {
    command = "set nornu nonu | Neotree toggle",
})

vim.api.nvim_create_autocmd("BufEnter", {
    command = "set rnu nu",
})
