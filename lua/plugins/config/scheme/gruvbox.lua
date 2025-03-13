vim.cmd.colorscheme 'gruvbox-material'

-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' })
-- vim.api.nvim_set_hl(0, 'NonText', { bg = 'None' })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { link = 'White' })
vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { link = 'None' })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { link = 'IblIndent' })
-- vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { link = 'None' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'None' })
-- vim.api.nvim_set_hl(0, 'Visual', { link = 'TelescopeSelection' })
-- vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })
-- vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = 'None' })
-- vim.api.nvim_set_hl(0, 'Cursorline', { bg = 'None' })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderIcon', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'NvimTreeClosedFolderIcon', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#45403d', bg = '#45403d' })
vim.api.nvim_set_hl(0, '@constant.python', { link = 'Constant' })
vim.api.nvim_set_hl(0, '@constant.builtin.python', { link = 'Purple' })
vim.api.nvim_set_hl(0, '@type.python', { link = 'Yellow' })
vim.api.nvim_set_hl(0, '@type.builtin.python', { link = 'Yellow' })
vim.api.nvim_set_hl(0, '@include.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@repeat.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.return.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.storage.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.function.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.operator.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.directive.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.exception.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@conditional.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.directive.python', { link = 'RedItalic' })
vim.api.nvim_set_hl(0, '@keyword.python', { link = 'RedItalic' })

local function link_python_to_generic()
    local hl_groups = vim.fn.getcompletion('@lsp.', 'highlight')

    for _, hl in ipairs(hl_groups) do
        local python_hl = hl .. '.python'
        if vim.fn.hlID(hl) ~= 0 then
            vim.api.nvim_set_hl(0, python_hl, { link = hl })
        end
    end
end

-- Link all Python-specific semantic tokens to the generic ones
link_python_to_generic()


-- these are for harpoon
-- vim.api.nvim_set_hl(0, 'FloatTitle', { link = 'Float' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#ffffff' })
