local opts = require("true-zen.config").options
local cmd = vim.cmd

local M = {}

local function setup_commands()
    if (opts.true_false_commands == true) then
        -- UI components
        cmd("command! TZTopOn lua require'true-zen.main'.main(1, 'on')")
        cmd("command! TZTopOff lua require'true-zen.main'.main(1, 'off')")
        cmd("command! TZLeftOn lua require'true-zen.main'.main(2, 'on')")
        cmd("command! TZLeftOff lua require'true-zen.main'.main(2, 'off')")
        cmd("command! TZBottomOn lua require'true-zen.main'.main(0, 'on')")
        cmd("command! TZBottomOff lua require'true-zen.main'.main(0, 'off')")

        -- Modes
        cmd("command! TZMinimalistOn lua require'true-zen.main'.main(3, 'on')")
        cmd("command! TZMinimalistOff lua require'true-zen.main'.main(3, 'off')")
        cmd("command! TZAtaraxisOn lua require'true-zen.main'.main(4, 'on')")
        cmd("command! TZAtaraxisOff lua require'true-zen.main'.main(4, 'off')")
        cmd("command! TZFocusOn lua require'true-zen.main'.main(5, 'on')")
        cmd("command! TZFocusOff lua require'true-zen.main'.main(5, 'off')")
    elseif (opts.true_false_commands == false) then
        -- nothing
    else
        print("'true_false_commands' option was not set properly for TrueZen.nvim plugin")
    end
end

local function setup_cursor()
    if (opts.cursor_by_mode == true) then
        cmd("set guicursor=i-c-ci:ver25,o-v-ve:hor20,cr-sm-n-r:block")
    elseif (opts.cursor_by_mode == false) then
        -- nothing
    else
        print("'cursor_by_mode' option was not set properly for TrueZen.nvim plugin")
    end
end

function M.setup(custom_opts)
    require("true-zen.config").set_options(custom_opts)
    setup_commands()
    setup_cursor()
end

return M
