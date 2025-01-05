local o = vim.o
local bo = vim.bo
local wo  = vim.wo
local g = vim.g


g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local vim = vim
o.scrolloff = 10
o.sessionoptions = 'buffers,curdir,tabpages,winsize'
-- o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
o.cursorline = true
o.ignorecase = true
o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
o.backup = false
o.undodir = vim.fn.stdpath('data') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autowriteall = true
-- o.breakindent = true
-- o.noswapfile = true
o.pumheight = 15
o.splitright = true

vim.opt.fillchars = { eob = " "}

-- bo.autoindent = true
-- bo.smartindent = true
-- bo.indentexpr = true;
bo.swapfile = false
vim.opt.fixendofline = true

wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = true

vim.api.nvim_command [[autocmd FileType * setlocal formatoptions-=o]] -- equivalent to set formatoptions-=cro
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
