local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au('TextYankPost', {
    group = ag('yank_highlight', {}),
    pattern = '*',
    callback = function ()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
    end,
})

au('CmdlineLeave', {
    group = ag('cmd_line_clear', {}),
    callback = function ()
        vim.fn.timer_start(5000, function ()
            vim.cmd [[ echon ' ' ]]
        end)
    end,
})

au('FocusLost', {
    group = ag('save_on_focus_lost', {}),
    pattern = '*',
    callback = function (opts)
        if
            vim.bo[opts.buf].buftype ~= 'prompt'
            and vim.bo[opts.buf].filetype ~= 'TelescopePrompt'
            and vim.bo[opts.buf].filetype ~= 'NvimTree'
            and vim.bo[opts.buf].filetype ~= 'oil'
            and vim.bo[opts.buf].filetype ~= 'neo-tree'
            and vim.bo[opts.buf].filetype ~= 'neo-tree-popup'
            and vim.bo[opts.buf].filetype ~= 'Lazy'
        then
            vim.cmd [[ update ]]
        end
    end,
})

au('BufLeave', {
    group = ag('save_on_buffer_change', {}),
    pattern = '*',
    callback = function (opts)
        if
            vim.bo[opts.buf].buftype ~= 'prompt'
            and vim.bo[opts.buf].filetype ~= 'TelescopePrompt'
            and vim.bo[opts.buf].filetype ~= 'NvimTree'
            and vim.bo[opts.buf].filetype ~= 'oil'
            and vim.bo[opts.buf].filetype ~= 'neo-tree'
            and vim.bo[opts.buf].filetype ~= 'neo-tree-popup'
            and vim.bo[opts.buf].filetype ~= 'neo-tree-popup'
            and vim.bo[opts.buf].filetype ~= 'dap-repl'
            and vim.bo[opts.buf].filetype ~= 'dap-ui-watches'
            and vim.bo[opts.buf].filetype ~= 'dap-ui-stacks'
            and vim.bo[opts.buf].filetype ~= 'dap-ui-sessions'
            and vim.bo[opts.buf].filetype ~= 'dap-ui-scopes'
            and vim.bo[opts.buf].filetype ~= 'lazy'
            and vim.bo[opts.buf].filetype ~= 'harpoon'
        then
            vim.cmd [[ update ]]
        end
    end,
})

-- on :w, if dir is not exist, create the dir also
au('BufWritePre', {
    callback = function (args)
        if vim.bo[args.buf].filetype ~= 'oil' then
            local dir = vim.fn.fnamemodify(args.file, ':p:h')
            if not vim.loop.fs_stat(dir) then
                vim.fn.mkdir(dir, 'p')
            end
        end
    end,
})

-- local modifiedBufs = function (bufs)
--     local t = 0
--     for k, v in pairs(bufs) do
--         if v.name:match("NvimTree_") == nil then
--             t = t + 1
--         end
--     end
--     return t
-- end
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     nested = true,
--     callback = function (opts)
--         if #vim.api.nvim_list_wins() == 1 and
--             vim.bo[opts.buf].filetype == 'NvimTree' and
--             modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0 then
--             -- vim.cmd ":NvimTreeClose"
--             vim.cmd "quit"
--         end
--     end
-- })

-- au('BufWritePre', {
--     group = ag('format_on_save', {}),
--     pattern = '*.cpp',
--     command = "silent! lua vim.lsp.buf.format()"
-- })

-- au('BufWritePre', {
--     group = ag('format_on_save', {}),
--     pattern = '*.h',
--     command = "silent! lua vim.lsp.buf.format()"
-- })

-- -- Define a custom save function
-- _G.save_if_changed = function()
--   if vim.bo.modified then
--     vim.cmd('write')
--   else
--     print("No changes made")
--   end
--   -- Always trigger LSP updates
--   local clients = vim.lsp.get_active_clients()
--   for _, client in pairs(clients) do
--     if client.server_capabilities.documentFormattingProvider then
--       vim.lsp.buf.format({ async = true })
--     end
--   end
-- end
--
-- -- Create an augroup to avoid duplicate autocommands
-- local group = vim.api.nvim_create_augroup("AutoSaveGroup", { clear = true })
--
-- -- Create an autocommand that intercepts the BufWriteCmd event
-- vim.api.nvim_create_autocmd("BufWriteCmd", {
--   group = group,
--   pattern = "*", -- Apply to all files
--   callback = function()
--     _G.save_if_changed()
--     -- Do not stop the command, allow the default behavior to proceed if needed
--   end,
-- })

-- Define a custom save function
-- _G.save_if_changed = function()
--   if vim.bo.modified then
--     vim.cmd('write')
--   else
--     print("no changes made")
--   end
-- end
--
-- -- Override the default :w command
-- vim.cmd([[
--   command! W lua save_if_changed()
--   cabbrev w W
-- ]])

-- add command to copy file path to system clipboard
vim.api.nvim_create_user_command('CopyAbsoluteFilePath', function ()
    local filepath = vim.fn.expand '%:p'
    vim.fn.setreg('+', filepath)
    print('Copied: ' .. filepath)
end, {})

vim.api.nvim_create_user_command('CopyFilePath', function ()
    local filepath = vim.fn.expand '%'
    vim.fn.setreg('+', filepath)
    print('Copied: ' .. filepath)
end, {})

-- grep for `ipdb`, ctrl-o toggle comment on line of matches
vim.api.nvim_create_user_command('FzfLuaIpdb', function ()
    require('fzf-lua').grep({
        search = 'ipdb',
        file_icons = false,
        rg_opts =
        '--sort-files --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
        actions = {
            ['ctrl-o'] = {
                fn = function (selected)
                    local path, lineno = selected[1]:match('^(.-):(%d+):')
                    if path and lineno then
                        local bufnr = vim.fn.bufnr(path, true)
                        if bufnr == -1 then return end
                        vim.fn.bufload(bufnr)

                        -- Run the comment toggle inside the correct buffer
                        vim.api.nvim_buf_call(bufnr, function ()
                            vim.cmd(string.format('%dnorm gcc', tonumber(lineno)))
                            vim.cmd('write')
                        end)
                    end
                end,
                reload = true
            },
            ['ctrl-x'] = {
                fn = function (selected)
                    local path, lineno = selected[1]:match('^(.-):(%d+):')
                    if path and lineno then
                        local bufnr = vim.fn.bufnr(path, true)
                        if bufnr == -1 then return end
                        vim.fn.bufload(bufnr)

                        -- Run the comment toggle inside the correct buffer
                        vim.api.nvim_buf_call(bufnr, function ()
                            vim.cmd(string.format('%dnorm dd', tonumber(lineno)))
                            vim.cmd('write')
                        end)
                    end
                end,
                reload = true
            }
        },
    })
end, {})

vim.api.nvim_create_user_command('DapPickPythonFile', function ()
    require('fzf-lua').files {
        prompt = 'dap entry ',
        formatter = 'path.dirname_first',
        git_icons = false,
        file_icons = false,
        color_icons = false,
        fd_opts = '--type f --extension py',
        actions = {
            ['default'] = function (selected)
                vim.cmd('edit ' .. selected[1])
                require('dap').continue()
            end,
        },
    }
end, {})
