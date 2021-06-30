local opts = require("true-zen.config").options
local cmd = vim.cmd

local M = {}

local function setup_commands()
    if (opts["misc"]["on_off_commands"] == true) then
        cmd([[command! TZMinimalistOn lua require'true-zen.main'.main(3, 'on')]])
        cmd([[command! TZMinimalistOff lua require'true-zen.main'.main(3, 'off')]])
        cmd([[command! TZAtaraxisOn lua require'true-zen.main'.main(4, 'on')]])
        cmd([[command! TZAtaraxisOff lua require'true-zen.main'.main(4, 'off')]])
        cmd([[command! TZFocusOn lua require'true-zen.main'.main(5, 'on')]])
        cmd([[command! TZFocusOff lua require'true-zen.main'.main(5, 'off')]])

        if (opts["misc"]["ui_elements_commands"] == true) then
            cmd([[command! TZTopOn lua require'true-zen.main'.main(1, 'on')]])
            cmd([[command! TZTopOff lua require'true-zen.main'.main(1, 'off')]])
            cmd([[command! TZLeftOn lua require'true-zen.main'.main(2, 'on')]])
            cmd([[command! TZLeftOff lua require'true-zen.main'.main(2, 'off')]])
            cmd([[command! TZBottomOn lua require'true-zen.main'.main(0, 'on')]])
            cmd([[command! TZBottomOff lua require'true-zen.main'.main(0, 'off')]])
        end
    end

    if (opts["misc"]["ui_elements_commands"] == true) then
        cmd([[command! TZBottom lua require'true-zen.main'.main(0, 'toggle')]])
        cmd([[command! TZTop lua require'true-zen.main'.main(1, 'toggle')]])
        cmd([[command! TZLeft lua require'true-zen.main'.main(2, 'toggle')]])
    end
end

local function setup_cursor()
    if (opts["misc"]["cursor_by_mode"] == true) then
        cmd("set guicursor=i-c-ci:ver25,o-v-ve:hor20,cr-sm-n-r:block")
    end
end

function M.setup(custom_opts)
    require("true-zen.config").set_options(custom_opts)
    setup_commands()
    setup_cursor()
end

return M
