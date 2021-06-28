local cmd = vim.cmd

local M = {}

function M.on(focus_type)
    if (focus_type == "experimental") then
        cmd("tabe %")
    elseif (focus_type == "native") then
        cmd("vert resize | resize")
        cmd("normal! ze")
    end
end

function M.off(focus_type)
    if (focus_type == "experimental") then
        cmd("q")
    elseif (focus_type == "native") then
        cmd("wincmd =")
        cmd("normal! ze")
    end
end

return M
