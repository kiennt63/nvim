local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

local harpoon = require 'harpoon'

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
-- Normal --

-- LSP
keymap('n', '<leader>lt', ':ClangdSwitchSourceHeader<cr>', opts)

-- debugger
local dap = require 'dap'
vim.keymap.set('n', '<leader>df', ':DapPickPythonFile<cr>', opts)
vim.keymap.set('n', '<leader>dc', dap.continue, opts)
vim.keymap.set('n', '<leader>dn', dap.step_over, opts)
vim.keymap.set('n', '<leader>di', dap.step_into, opts)
vim.keymap.set('n', '<leader>do', dap.step_out, opts)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<leader>dx', dap.disconnect, opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap('n', '<C-A-l>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-A-h>', ':vertical resize +2<CR>', opts)

-- Remove hls
keymap('n', '<esc><esc>', ':noh<cr>', opts)

-- =======================================================
-- Navigate buffers
keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<leader>bd', '<cmd>lua Snacks.bufdelete()<CR>', opts)

-- -- Navigate harpoon
keymap('n', '<A-1>', function()
    harpoon:list():select(1)
end, opts)
keymap('n', '<A-2>', function()
    harpoon:list():select(2)
end, opts)
keymap('n', '<A-3>', function()
    harpoon:list():select(3)
end, opts)
keymap('n', '<A-4>', function()
    harpoon:list():select(4)
end, opts)
keymap('n', '<A-5>', function()
    harpoon:list():select(5)
end, opts)
keymap('n', '<A-6>', function()
    harpoon:list():select(6)
end, opts)
keymap('n', '<A-7>', function()
    harpoon:list():select(7)
end, opts)
keymap('n', '<A-8>', function()
    harpoon:list():select(8)
end, opts)
keymap('n', '<A-9>', function()
    harpoon:list():select(9)
end, opts)

keymap('n', '<leader>bp', function()
    harpoon:list():add()
end, opts)
keymap('n', '<leader>fh', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, opts)

keymap('n', '<C-S-P>', function()
    harpoon:list():prev()
end, opts)
keymap('n', '<C-S-N>', function()
    harpoon:list():next()
end, opts)

-- =======================================================
-- Saving and stuff
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>qa', ':qa<CR>', opts)

keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>wa', ':wa<CR>', opts)

keymap('n', '<leader>wq', ':wq<CR>', opts)
keymap('n', '<leader>wqa', ':wqa<CR>', opts)

-- =======================================================
-- Normal
-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==', opts)
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==', opts)

-- =======================================================
-- Insert --
-- Press jk fast to exit insert mode
-- keymap("i", "jk", "<ESC>", opts)

-- =======================================================
-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

-- Copy to clipboard
keymap('v', '<leader>y', '"+y', opts)

-- =======================================================
-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Copy to clipboard
keymap('x', '<leader>y', '"+y', opts)

-- Share yank and paste between vim processes
keymap('v', '<leader>gy', ':w! /tmp/vitmp<CR>', opts)
keymap('n', '<leader>gp', ':r! cat /tmp/vitmp<CR>', opts)

-- =======================================================
-- Trouble
-- keymap('n', '<leader>t', ':Trouble diagnostics toggle<cr>', opts)

-- Diagnostic
keymap(
    'n',
    '<leader>ld',
    '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<cr>',
    { desc = '[L]SP [D]iagnostic' }
)

keymap('n', '[d', function()
    vim.diagnostic.goto_prev {
        severity = vim.diagnostic.severity.WARN,
        wrap = true,
    }
end, opts)
keymap('n', ']d', function()
    vim.diagnostic.goto_next {
        severity = vim.diagnostic.severity.WARN,
        wrap = true,
    }
end, opts)
keymap('n', '[D', function()
    vim.diagnostic.goto_prev {
        severity = vim.diagnostic.severity.ERROR,
        wrap = true,
    }
end, opts)
keymap('n', ']D', function()
    vim.diagnostic.goto_next {
        severity = vim.diagnostic.severity.ERROR,
        wrap = true,
    }
end, opts)

-- keymap('n', '[d', require('delimited').goto_prev, opts)
-- keymap('n', ']d', require('delimited').goto_next, opts)
-- keymap('n', '[D', function ()
--     require('delimited').goto_prev { severity = vim.diagnostic.severity.ERROR }
-- end, opts)
-- keymap('n', ']D', function ()
--     require('delimited').goto_next { severity = vim.diagnostic.severity.ERROR }
-- end, opts)
--
-- local M = {}
--
-- M.pos_equal = function (p1, p2)
--   local r1, c1 = unpack(p1)
--   local r2, c2 = unpack(p2)
--   return r1 == r2 and c1 == c2
-- end
--
-- M.goto_error_then_hint = function ()
--   local pos = vim.api.nvim_win_get_cursor(0)
--   vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap = true} )
--   local pos2 = vim.api.nvim_win_get_cursor(0)
--   if ( M.pos_equal(pos, pos2)) then
--     vim.diagnostic.goto_next( {wrap = true} )
--   end
-- end
--
-- return M
--
-- =======================================================
-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
-- keymap('n', '<leader>F', '<cmd>Telescope find_files<cr>', opts)
-- local live_grep_args_shortcuts = require 'telescope-live-grep-args.shortcuts'
keymap(
    'n',
    '<leader>o',
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
    opts
)
-- keymap(
--     'n',
--     '<leader>fg',
--     ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
--     opts
-- )
-- keymap(
--     'n',
--     '<leader>fg',
--     ":lua require('telescope').extensions.live_grep_args.live_grep_args({ layout_stategy = 'vertical' })<CR>",
--     opts
-- )
-- keymap('n', '<leader>fs', ':Telescope git_status<cr>', opts)
-- keymap('n', '<leader>fw', function()
--     live_grep_args_shortcuts.grep_word_under_cursor {
--         quote = false,
--         postfix = '',
--     }
-- end, opts)
-- keymap('v', '<leader>fw', live_grep_args_shortcuts.grep_visual_selection, opts)
-- keymap('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]resume' })

-- FzfLua
-- keymap('n', '<leader>o', "<cmd>lua require('fzf-lua').files()<cr>", opts)
keymap('n', '<leader>fg', "<cmd>lua require('fzf-lua').live_grep()<CR>", opts)
keymap(
    'n',
    '<leader>fw',
    '<cmd>lua require("fzf-lua").live_grep({ search = vim.fn.expand("<cword>") })<cr>',
    opts
)
keymap('n', '<leader>fr', '<cmd>lua require("fzf-lua").resume()<cr>', opts)

-- Git workstree
-- File manager
keymap('n', '<leader>fq', ':RnvimrToggle<cr>', opts)
keymap('n', '<leader>e', '<cmd>lua require("oil").toggle_float()<cr>', opts)

-- Searching
keymap('v', '//', [[y/\V<c-r>=escape(@",'/\')<cr><cr>]], opts)

-- Focus mode (centering window)
keymap('n', '<leader>z', '<cmd>NoNeckPain<cr>', opts)

-- Git sign
keymap('n', '<leader>gs', ':Gitsigns preview_hunk<cr>', opts)
keymap('n', '<leader>gd', ':Gitsigns reset_hunk<cr>', opts)
keymap('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<cr>', opts)
keymap('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<cr>', opts)
keymap('n', '<leader>gn', ':Gitsigns next_hunk<cr>', opts)
keymap('n', '<leader>gp', ':Gitsigns prev_hunk<cr>', opts)

-- Noice (messages and notification)
keymap('n', '<leader>nd', ':NoiceDismiss<cr>', opts)

-- symbol (aeriel)
keymap('n', '<leader>sp', '<cmd>AerialPrev<CR>', opts)
keymap('n', '<leader>sn', '<cmd>AerialNext<CR>', opts)
keymap('n', '<leader>st', '<cmd>AerialToggle<CR>', opts)
