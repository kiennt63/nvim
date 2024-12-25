require('blink.cmp').setup {
    keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
    },
    snippets = {
        expand = function(snippet)
            require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
            if filter and filter.direction then
                return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
        end,
        jump = function(direction)
            require('luasnip').jump(direction)
        end,
    },
    sources = {
        default = { 'luasnip', 'lsp', 'path', 'buffer' },
        cmdline = {},
    },
    completion = {
        list = { selection = 'auto_insert' },
        menu = {
            border = 'single',
        },
        documentation = { window = { border = 'single' } },
    },
    signature = { window = { border = 'single' } },
}
