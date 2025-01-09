return {
    'saghen/blink.cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
            local ls = require 'luasnip'
            -- some shorthands...
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node
            local f = ls.function_node
            local l = ls.l
            local rep = require('luasnip.extras').rep
            local fmt = require('luasnip.extras.fmt').fmt

            local function current_date()
                return os.date '%d-%b-%Y' -- Formats date as "08-Nov-2024"
            end

            local function relative_filepath()
                local filepath = vim.fn.expand '%:p' -- Get absolute path
                local cwd = vim.fn.getcwd() -- Get current working directory

                -- If filepath starts with cwd, make it relative
                if filepath:sub(1, #cwd) == cwd then
                    return filepath:sub(#cwd + 2) -- Remove cwd and leading slash
                else
                    return filepath -- Return absolute path if it can't be made relative
                end
            end

            local function get_path_from_root()
                local filename = vim.fn.expand '%:t'
                local filepath = vim.fn.expand '%:p'
                local root_dir = vim.fn.finddir('.git/..', filepath .. ';')

                if root_dir == '' then
                    -- Fallback to just filename if no root dir found
                    return string.upper(filename:gsub('[./]', '_'))
                end

                -- Get root directory name and sanitize it
                local root_name = vim.fn.fnamemodify(root_dir, ':t')
                root_name = root_name:gsub('[%-.]', '_')

                -- Get relative path from root
                local relative_path = filepath:sub(#root_dir + 2)
                -- Convert to uppercase and replace special chars with underscore
                local guard = string.upper(root_name .. '_' .. relative_path:gsub('[./]', '_'))

                return guard
            end

            ls.add_snippets(nil, {
                all = {},
            })
            ls.add_snippets('cpp', {
                s('guard', {
                    f(function()
                        return '#ifndef ' .. get_path_from_root()
                    end),
                    t { '', '#define ' },
                    f(function()
                        return get_path_from_root()
                    end),
                    t { '', '', '' },
                    i(0),
                    t { '', '', '' },
                    t { '', '#endif  // ' },
                    f(function()
                        return get_path_from_root()
                    end),
                }),
            })
            ls.add_snippets('python', {
                s('ipdb', t "__import__('ipdb').set_trace()"),
                s({
                    trig = 'head',
                    namr = 'omnivision copyright',
                    dscr = 'omnivision copyright',
                }, {
                    t {
                        '# ****************************************************************************',
                        '# *',
                        '# * Copyright (c) 2018 OmniVision Technologies, Inc.',
                        '# * The material in this file is subject to copyright. It may not',
                        '# * be used, copied or transferred by any means without the prior written',
                        '# * approval of OmniVision Technologies, Inc.',
                        '# *',
                        '# * OMNIVISION TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES WITH REGARD TO',
                        '# * THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND',
                        '# * FITNESS, IN NO EVENT SHALL OMNIVISION TECHNOLOGIES, INC. BE LIABLE FOR',
                        '# * ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER',
                        '# * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF',
                        '# * CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN',
                        '# * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.',
                        '# *',
                        '# ****************************************************************************',
                        '# @files      ',
                    },
                    f(relative_filepath, {}),
                    t { '', '# @brief      ' },
                    i(1, 'description'),
                    t { '', '# @version    ' },
                    i(2, '0.1'),
                    t { '', '# @date       ' },
                    f(current_date, {}),
                    t { '', '', '' },
                    i(3),
                }),
                s(
                    'pycls',
                    fmt(
                        [[
                    class {}:
                        def __init__(self, {}):
                            {}
                    ]],
                        {
                            i(1, 'ClassName'), -- Class name
                            i(2, 'arg1, arg2, arg3'), -- Constructor arguments
                            i(
                                3,
                                fmt('self.{} = {}\n        self.{} = {}\n        self.{} = {}', {
                                    i(4, 'arg1'),
                                    i(4),
                                    i(5, 'arg2'),
                                    i(5),
                                    i(6, 'arg3'),
                                    i(6),
                                })
                            ),
                        }
                    )
                ),
                s('getset', {
                    -- Getter
                    t '@property',
                    t { '', 'def ' },
                    i(1, 'attr'),
                    t { '(self):' },
                    t { '', '    return self.__' },
                    f(function(args)
                        return args[1][1]
                    end, { 1 }),

                    -- Setter
                    t { '', '', '@' },
                    f(function(args)
                        return args[1][1]
                    end, { 1 }),
                    t { '.setter' },
                    t { '', 'def ' },
                    f(function(args)
                        return args[1][1]
                    end, { 1 }),
                    t { '(self, value):' },
                    t { '', '    self.__' },
                    f(function(args)
                        return args[1][1]
                    end, { 1 }),
                    t { ' = value' },
                }),
            })
        end,
    },
    version = '*',
    opts_extend = { 'sources.default' },
    config = function()
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
            snippets = { preset = 'luasnip' },
            sources = {
                default = { 'snippets', 'lsp', 'path', 'buffer' },
                cmdline = {},
            },

            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                -- menu = {
                --     border = 'single',
                -- },
                -- documentation = { window = { border = 'single' } },
            },
            signature = {
                enabled = false,
                -- window = { border = 'single' },
            },
        }
    end,
}
