local M = {}

local cnf = require("true-zen.config").options
local fn = vim.fn
local status

function M.on()
    if not fn.executable("alacritty") then
        return
    end
    local cmd = "alacritty msg config -w %s font.size=%s"
    local win_id = fn.expand("$ALACRITTY_WINDOW_ID")
    fn.system(cmd:format(win_id, cnf.integrations.alacritty.font))
    vim.cmd([[redraw]])
    status = true
end

function M.off()
    if status == true then
        local cmd = "alacritty msg config -w %s --reset"
        local win_id = fn.expand("$ALACRITTY_WINDOW_ID")
        fn.system(cmd:format(win_id))
    end
    status = nil
end

return M
