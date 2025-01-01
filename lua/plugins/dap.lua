return {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap, dapui = require 'dap', require 'dapui'
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require('dapui').setup {
            expand_lines = true,
            layouts = {
                {
                    elements = {
                        {
                            id = 'breakpoints',
                            size = 0.1,
                        },
                        {
                            id = 'stacks',
                            size = 0.3,
                        },
                        {
                            id = 'scopes',
                            size = 0.35,
                        },
                        {
                            id = 'watches',
                            size = 0.25,
                        },
                    },
                    position = 'left',
                    size = 50,
                },
                {
                    elements = {
                        {
                            id = 'repl',
                            size = 0.8,
                        },
                        {
                            id = 'console',
                            size = 0.2,
                        },
                    },
                    position = 'bottom',
                    size = 15,
                },
            },
        }

        require('dap-python').setup 'python'

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
            vim.keymap.set('n', '<A-S-n>', function()
                dap.step_over()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', '<A-S-i>', function()
                dap.step_into()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', '<A-S-o>', function()
                dap.step_out()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', 'K', function()
                dapui.eval()
            end, { silent = true, buffer = true })
        end
        dap.listeners.before.launch.dapui_config = function()
            vim.keymap.set('n', '<A-S-n>', function()
                dap.step_over()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', '<A-S-i>', function()
                dap.step_into()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', '<A-S-o>', function()
                dap.step_out()
            end, { silent = true, buffer = true })
            vim.keymap.set('n', 'K', function()
                dapui.eval()
            end, { silent = true, buffer = true })
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, buffer = true })
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, buffer = true })
            dapui.close()
        end

        -- Create a function to pick and debug a file
        local function pick_python_file()
            require('fzf-lua').files {
                prompt = 'Select Python File> ',
                git_icons = false,
                file_icons = false,
                color_icons = false,
                fd_opts = '--type f --extension py',
                actions = {
                    ['default'] = function(items)
                        vim.cmd('edit ' .. items[1])
                        require('dap').continue()
                    end,
                },
            }
        end

        vim.api.nvim_create_user_command('DapPickPythonFile', pick_python_file, {})

        -- vim.api.nvim_create_autocmd('BufEnter', {
        --     group = vim.api.nvim_create_augroup('DAPKeymap', { clear = true }),
        --     pattern = '*', -- This applies to all buffers
        --     callback = function()
        --         if dap.session() ~= nil then
        --             -- DAP session is active: set buffer-local keymap for Ctrl+n
        --             vim.keymap.set('n', '<A-S-n>', function()
        --                 dap.step_over()
        --             end, { silent = true, buffer = true })
        --             vim.keymap.set('n', '<A-S-i>', function()
        --                 dap.step_into()
        --             end, { silent = true, buffer = true })
        --             vim.keymap.set('n', '<A-S-o>', function()
        --                 dap.step_out()
        --             end, { silent = true, buffer = true })
        --             vim.keymap.set('n', 'K', function()
        --                 dapui.eval()
        --             end, { silent = true, buffer = true })
        --         else
        --             -- -- No DAP session: unmap <C-n> if it exists
        --             vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-n>')
        --             vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-i>')
        --             vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-o>')
        --             vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, buffer = true })
        --         end
        --     end,
        -- })

        -- - `DapBreakpoint` for breakpoints (default: `B`)
        -- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
        -- - `DapLogPoint` for log points (default: `L`)
        -- - `DapStopped` to indicate where the debugee is stopped (default: `→`)
        -- - `DapBreakpointRejected` to indicate breakpoints rejected by the debug
        --   adapter (default: `R`)
        --
        -- You can customize the signs by setting them with the |sign_define()| function.
        -- For example:
        --
        --
        -- >lua
        vim.fn.sign_define(
            'DapBreakpoint',
            { text = '', texthl = 'DapUIWatchesError', linehl = '', numhl = '' }
        )
        vim.fn.sign_define(
            'DapStopped',
            { text = '', texthl = 'DapUISource', linehl = '', numhl = '' }
        )
    end,
}
