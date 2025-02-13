return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
            'saghen/blink.cmp',
            {
                'p00f/clangd_extensions.nvim',
                lazy = true,
                config = function ()
                    require('clangd_extensions').setup({
                        inlay_hints = {
                            inline = vim.fn.has 'nvim-0.10' == 1,
                            only_current_line = false,
                            only_current_line_autocmd = { 'CursorHold' },
                            show_parameter_hints = true,
                            parameter_hints_prefix = '<- ',
                            other_hints_prefix = '=> ',
                            max_len_align = false,
                            max_len_align_padding = 1,
                            right_align = false,
                            right_align_padding = 7,
                            highlight = 'Comment',
                            priority = 100,
                        },
                        ast = {
                            role_icons = {
                                type = '',
                                declaration = '',
                                expression = '',
                                specifier = '',
                                statement = '',
                                ['template argument'] = '',
                            },

                            kind_icons = {
                                Compound = '',
                                Recovery = '',
                                TranslationUnit = '',
                                PackExpansion = '',
                                TemplateTypeParm = '',
                                TemplateTemplateParm = '',
                                TemplateParamObject = '',
                            },

                            highlights = {
                                detail = 'Comment',
                            },
                        },
                        memory_usage = {
                            border = 'none',
                        },
                        symbol_info = {
                            border = 'none',
                        },
                    })
                end,
            },
            -- {
            --     'mrcjkb/rustaceanvim',
            --     version = '^4', -- Recommended
            --     ft = { 'rust' },
            -- },
        },
        opts = {
            diagnostics = {
                underline = {
                    severity = { min = vim.diagnostic.severity.ERROR },
                },
                update_in_insert = false,
                virtual_text = {
                    severity = { min = vim.diagnostic.severity.WARN },
                    spacing = 4,
                    source = 'if_many',
                    prefix = '●',
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.HINT] = '',
                        [vim.diagnostic.severity.INFO] = '',
                    },
                },
                --     severity = {
                --         ['unused-local'] = vim.diagnostic.severity.HINT,
                --     },
            }
        },

        config = function (_, opts)
            local util = require 'lspconfig/util'

            local on_attach = function (_, bufnr)
                local nmap = function (keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                local imap = function (keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
                end

                nmap('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
                nmap('<leader>la', vim.lsp.buf.code_action, '[L]SP Code [A]ction')

                nmap('gd', function ()
                    require('fzf-lua').lsp_definitions { jump_to_single_result = true }
                end, '[G]oto [D]efinition')
                nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
                nmap('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
                nmap('<leader>lt', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
                nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap(
                    '<leader>ws',
                    require('fzf-lua').lsp_workspace_symbols,
                    '[W]orkspace [S]ymbols'
                )

                -- See `:help K` for why this keymap
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                -- Format code
                nmap('<space>lf', function ()
                    vim.lsp.buf.format { async = true }
                end, 'Format')

                nmap('gD', require('fzf-lua').lsp_declarations, '[G]oto [D]eclaration')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap(
                    '<leader>wr',
                    vim.lsp.buf.remove_workspace_folder,
                    '[W]orkspace [R]emove Folder'
                )
                nmap('<leader>wl', function ()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function (_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end

            local servers = {
                clangd = {
                    filetypes = {
                        'c',
                        'cpp',
                        'objc',
                        'objcpp',
                        'cuda',
                    },
                    cmd = {
                        'clangd',
                        '--background-index',
                        '--offset-encoding=utf-16',
                        '--clang-tidy',
                        '--header-insertion=iwyu',
                        '--completion-style=detailed',
                        '--function-arg-placeholders',
                        '--fallback-style=llvm',
                        -- '--query-driver=/usr/local/cuda/bin/nvcc',
                        -- '--query-driver=/usr/bin/c++',
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },

                glsl_analyzer = {},

                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                                indent_style = 'space',
                                indent_size = '4',
                                defaultConfig = {
                                    indent_style = 'space',
                                    indent_size = '4',
                                },
                            },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                            },
                        },
                    },
                },
                bashls = {},

                cmake = {
                    root_dir = util.root_pattern('build', 'build_x64_linux', 'build_aarch64_linux'),
                    settings = {
                        cmake = {
                            format = {
                                enable = true, -- Enables formatting
                            },
                        },
                    },
                },

                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                -- jedi_completion = {
                                --     include_params = true,
                                -- },
                                -- jedi_signature_help = { enabled = true },
                                pyflakes = { enabled = true },
                                pylint = {
                                    args = { '--ignore=E501,E231', '-' },
                                    enabled = true,
                                    debounce = 200,
                                },
                                pylsp_mypy = { enabled = true },
                                pycodestyle = {
                                    enabled = true,
                                    ignore = { 'E501', 'E231', 'W293', 'E266' },
                                    maxLineLength = 88,
                                },
                                autopep8 = {
                                    enabled = false,
                                },
                                yapf = {
                                    enabled = false,
                                },
                                black = {
                                    enabled = false,
                                },
                            },
                        },
                    },
                },
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            diagnostics = {
                                enable = false,
                            },
                        },
                    },
                },
                zls = {

                }
            }

            -- Setup neovim lua configuration
            require('neodev').setup()

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            -- capabilities.offsetEncoding = { 'utf-16' }

            -- Ensure the servers above are installed
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                -- ensure_installed = vim.tbl_keys(servers),
            }

            local function setup(server)
                local server_opts = vim.tbl_deep_extend('force', {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = on_attach,
                }, servers[server] or {})

                require('lspconfig')[server].setup(server_opts)
            end


            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    if server_opts.enabled ~= false then
                        setup(server)
                        -- -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        -- if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        -- else
                        --     ensure_installed[#ensure_installed + 1] = server
                        -- end
                    end
                end
            end

            -- mason_lspconfig.setup_handlers {
            --     function (server_name)
            --         require('lspconfig')[server_name].setup {
            --             capabilities = capabilities,
            --             on_attach = on_attach,
            --             settings = (servers[server_name] or {}).settings,
            --             filetypes = (servers[server_name] or {}).filetypes,
            --             cmd = (servers[server_name] or {}).cmd,
            --             root_dir = (servers[server_name] or {}).root_dir,
            --         }
            --     end,
            -- }

            -- diagnostics signs
            if vim.fn.has('nvim-0.10.0') == 0 then
                if type(opts.diagnostics.signs) ~= 'boolean' then
                    for severity, icon in pairs(opts.diagnostics.signs.text) do
                        local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
                        name = 'DiagnosticSign' .. name
                        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
                    end
                end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
        end,
    },

    -- linter, formater
    {
        'nvimtools/none-ls.nvim',
        config = function ()
            local null_ls = require 'null-ls'

            null_ls.setup {
                sources = {
                    -- null_ls.builtins.formatting.stylua,
                    -- null_ls.builtins.diagnostics.eslint,
                    -- null_ls.builtins.completion.spell,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.prettier.with {
                        filetypes = { 'html', 'json', 'yaml', 'markdown' },
                    },
                },
            }
        end,
    },

    -- diagnostics
    {
        'folke/trouble.nvim',
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>t',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
}
