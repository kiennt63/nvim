vim.cmd.colorscheme 'kanagawa-paper'

-- vim.api.nvim_set_hl(0, 'LineNr', { bg = 'None' })
-- vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'None' })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'None' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'None' })
-- vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { link = 'None' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'None' })
-- vim.api.nvim_set_hl(0, 'Visual', { link = 'TelescopeSelection' })
-- -- vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })
-- -- vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = 'None' })
-- vim.api.nvim_set_hl(0, 'Cursorline', { bg = '#2e383c' })
vim.api.nvim_set_hl(0, 'Visual', { link = 'TelescopeSelection' })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = 'None', bg = '#54546D', bold = true })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#a292a3', bg = 'None', bold = true })

-- vim.api.nvim_set_hl(0, '@parameter', { link = '@lsp.type.parameter' })
vim.api.nvim_set_hl(0, '@method', { link = '@lsp.type.method' })
vim.api.nvim_set_hl(0, '@field', { link = '@lsp.type.property' })
vim.api.nvim_set_hl(0, '@conditional', { link = 'keyword' })
vim.api.nvim_set_hl(0, '@include', { link = 'keyword' })
vim.api.nvim_set_hl(0, '@repeat', { link = 'keyword' })

vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'TelescopeBorder' })
