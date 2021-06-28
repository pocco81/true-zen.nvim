local cmd = vim.cmd

local M = {}

function M.enable_element()
    cmd("AirlineToggle")
end

function M.disable_element()
    cmd("AirlineToggle")
    cmd("silent! AirlineRefresh")
    cmd("silent! AirlineRefresh")
end

return M
