return {
    { 'williamboman/mason.nvim', config = true },

    {
        dir    = vim.fn.stdpath('config'),
        name   = 'lsp-setup',
        lazy   = false,
        config = function ()
            -- ── on_attach ────────────────────────────────────────────────────
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-on-attach', { clear = true }),
                callback = function (ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local bufnr  = ev.buf

                    if client and client.name == 'basedpyright' then
                        client.server_capabilities.semanticTokensProvider = nil
                    end

                    if client and client.name == 'ruff' then
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end

                    local nmap = function (keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. (desc or '') })
                    end
                    local imap = function (keys, func, desc)
                        vim.keymap.set('i', keys, func, { buffer = bufnr, desc = 'LSP: ' .. (desc or '') })
                    end

                    nmap('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
                    nmap('<leader>la', vim.lsp.buf.code_action, '[L]SP Code [A]ction')

                    nmap('gd', function ()
                        require('fzf-lua').lsp_definitions { jump1 = true }
                    end, '[G]oto [D]efinition')
                    nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
                    nmap('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
                    nmap('<leader>lt', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
                    nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
                    nmap('<leader>ws', require('fzf-lua').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

                    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                    imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                    nmap('<space>lf', function ()
                        vim.lsp.buf.format { async = true }
                    end, 'Format')

                    nmap('gD', require('fzf-lua').lsp_declarations, '[G]oto [D]eclaration')
                    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                    nmap('<leader>wl', function ()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, '[W]orkspace [L]ist Folders')

                    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function (_)
                        vim.lsp.buf.format()
                    end, { desc = 'Format current buffer with LSP' })
                end,
            })

            -- ── Capabilities ─────────────────────────────────────────────────
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- ── Servers ──────────────────────────────────────────────────────
            local servers = {
                clangd = {
                    cmd          = {
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
                    filetypes    = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
                    root_markers = { 'compile_commands.json', '.git' },
                    init_options = {
                        usePlaceholders    = true,
                        completeUnimported = true,
                        clangdFileStatus   = true,
                    },
                },

                glsl_analyzer = {
                    cmd          = { 'glsl_analyzer' },
                    filetypes    = { 'glsl', 'vert', 'frag', 'geom', 'tesc', 'tese', 'comp' },
                    root_markers = { '.git' },
                },

                lua_ls = {
                    cmd          = { 'lua-language-server' },
                    filetypes    = { 'lua' },
                    root_markers = { '.luarc.json', '.git' },
                    settings     = {
                        Lua = {
                            format      = {
                                enable = true,
                                indent_style = 'space',
                                indent_size = '4',
                                defaultConfig = { indent_style = 'space', indent_size = '4' },
                            },
                            workspace   = { checkThirdParty = false },
                            telemetry   = { enable = false },
                            diagnostics = { globals = { 'vim' } },
                        },
                    },
                },

                bashls = {
                    cmd          = { 'bash-language-server', 'start' },
                    filetypes    = { 'sh', 'bash' },
                    root_markers = { '.git' },
                },

                cmake = {
                    cmd          = { 'cmake-language-server' },
                    filetypes    = { 'cmake' },
                    root_markers = { 'build', 'build_x64_linux', 'build_aarch64_linux', '.git' },
                    settings     = {
                        cmake = { format = { enable = true } },
                    },
                },

                -- basedpyright = {
                --     cmd          = { 'basedpyright-langserver', '--stdio' },
                --     filetypes    = { 'python' },
                --     root_markers = { 'pyproject.toml', 'setup.py', '.git' },
                --     settings     = {
                --         basedpyright = {
                --             disableOrganizeImports = true,
                --             typeCheckingMode = 'off',
                --             analysis = {
                --                 diagnosticMode = 'openFilesOnly',
                --                 diagnosticSeverityOverrides = { reportUnusedImport = 'none' },
                --                 inlayHints = { callArgumentNames = true },
                --                 disable = { 'reportUnusedImport' },
                --             },
                --         },
                --     },
                -- },

                ty = {
                    cmd          = { 'ty', 'server' },
                    filetypes    = { 'python' },
                    root_markers = { 'pyproject.toml', 'ty.toml', '.git' },
                },

                -- ruff = {
                --     cmd          = { 'ruff', 'server' },
                --     filetypes    = { 'python' },
                --     root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
                --     settings     = {
                --         ruff = {
                --             lineLength = 100,
                --             lint = { enable = true, select = { 'E', 'W', 'F' } },
                --             typeCheck = { enable = true },
                --         },
                --     },
                -- },

                rust_analyzer = {
                    cmd          = { 'rust-analyzer' },
                    filetypes    = { 'rust' },
                    root_markers = { 'Cargo.toml', '.git' },
                    settings     = {
                        ['rust-analyzer'] = {
                            diagnostics = { enable = false },
                        },
                    },
                },

                zls = {
                    cmd          = { 'zls' },
                    filetypes    = { 'zig', 'zir' },
                    root_markers = { 'build.zig', '.git' },
                },

                gdscript = {
                    cmd          = { 'gdscript' },
                    filetypes    = { 'gd', 'gdscript' },
                    root_markers = { 'project.godot', '.git' },
                },
            }

            for name, config in pairs(servers) do
                vim.lsp.config(name, vim.tbl_deep_extend('force', { capabilities = capabilities }, config))
            end

            vim.lsp.enable(vim.tbl_keys(servers))

            -- ── Diagnostics ──────────────────────────────────────────────────
            vim.diagnostic.config({
                underline        = false,
                update_in_insert = false,
                virtual_text     = {
                    severity = { min = vim.diagnostic.severity.WARN },
                    spacing  = 4,
                    source   = 'if_many',
                    prefix   = '●',
                },
                severity_sort    = true,
                signs            = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN]  = '',
                        [vim.diagnostic.severity.HINT]  = '',
                        [vim.diagnostic.severity.INFO]  = '',
                    },
                },
            })
        end,
    },

    -- formatter
    {
        'stevearc/conform.nvim',
        config = function ()
            require('conform').setup {
                formatters_by_ft = {
                    python   = { 'isort', 'black' },
                    html     = { 'prettier' },
                    json     = { 'prettier' },
                    yaml     = { 'prettier' },
                    markdown = { 'prettier' },
                    c        = { 'clang_format' },
                    cpp      = { 'clang_format' },
                    cuda     = { 'clang_format' },
                },
            }

            -- override the <space>lf set in LspAttach with conform
            -- lsp_format = 'fallback' means: use LSP if no conform formatter exists
            vim.keymap.set({ 'n', 'v' }, '<space>lf', function ()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end, { desc = 'Format' })
        end,
    },



    {
        'p00f/clangd_extensions.nvim',
        lazy = true,
        config = function ()
            require('clangd_extensions').setup({
                inlay_hints  = {
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
                ast          = {
                    role_icons = {
                        type = '',
                        declaration = '',
                        expression = '',
                        specifier = '',
                        statement = '',
                        ['template argument'] = '',
                    },
                    kind_icons = {
                        Compound = '',
                        Recovery = '',
                        TranslationUnit = '',
                        PackExpansion = '',
                        TemplateTypeParm = '',
                        TemplateTemplateParm = '',
                        TemplateParamObject = '',
                    },
                    highlights = { detail = 'Comment' },
                },
                memory_usage = { border = 'none' },
                symbol_info  = { border = 'none' },
            })
        end,
    },

    -- diagnostics
    {
        'folke/trouble.nvim',
        opts = {},
        cmd  = 'Trouble',
        keys = {
            { '<leader>t',  '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Diagnostics (Trouble)' },
            { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = 'Buffer Diagnostics (Trouble)' },
            { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = 'Symbols (Trouble)' },
            { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
            { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                            desc = 'Location List (Trouble)' },
            { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                             desc = 'Quickfix List (Trouble)' },
        },
    },
}
