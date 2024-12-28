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

        require('dap-python').setup 'python3'

        local function is_dapui_active()
            return dapui.windows and #dapui.windows > 0
        end

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',
                program = function()
                    return vim.fn.input('Path to file: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
            },
        }

        vim.api.nvim_create_autocmd('BufEnter', {
            group = vim.api.nvim_create_augroup('DAPKeymap', { clear = true }),
            pattern = '*', -- This applies to all buffers
            callback = function()
                if dap.session() ~= nil then
                    -- DAP session is active: set buffer-local keymap for Ctrl+n
                    vim.keymap.set('n', '<A-S-n>', function()
                        dap.step_over()
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '<A-S-i>', function()
                        dap.step_into()
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '<A-S-o>', function()
                        dap.step_out()
                    end, { silent = true, buffer = true })
                    vim.keymap.set('n', '<S-k>', function()
                        dapui.eval()
                    end, { silent = true, buffer = true })
                else
                    -- No DAP session: unmap <C-n> if it exists
                    pcall(function()
                        vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-n>')
                    end)
                    pcall(function()
                        vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-i>')
                    end)
                    pcall(function()
                        vim.api.nvim_buf_del_keymap(0, 'n', '<A-S-o>')
                    end)
                end
            end,
        })

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
