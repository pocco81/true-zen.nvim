local opts = require("true-zen.config").options

local cmd = vim.cmd

local M = {}

function M.set_fillchars()
    cmd([[set fillchars+=stl:\ ]])
    cmd([[set fillchars+=stlnc:\ ]])
    cmd([[set fillchars+=vert:\ ]])
    cmd([[set fillchars+=diff:\ ]])
    cmd([[set fillchars+=msgsep:\ ]])
    cmd([[set fillchars+=eob:\ ]])

    if (opts["modes"]["ataraxis"]["keep_default_fold_fillchars"] == true) then
        -- This is for the mouse to work
        cmd([[set fillchars+=fold:·,foldopen:-,foldclose:+,foldsep:\|]])
    else
        cmd([[set fillchars+=fold:\ ]])
        cmd([[set fillchars+=foldopen:\ ]])
        cmd([[set fillchars+=foldclose:\ ]])
        cmd([[set fillchars+=foldsep:\ ]])
    end
end

function M.store_fillchars()
    local fillchars = vim.api.nvim_eval("&fillchars")

    if (fillchars == "" or fillchars == " " or fillchars == nil) then
        -- vim's default fillchars
        final_fillchars = [[stl:\ ,stlnc:\ ,vert:\│,fold:·,foldopen:-,foldclose:+,foldsep:\|,diff:-,msgsep:\ ,eob:~]]
    else
        fillchars_escaped_spaces = fillchars:gsub(": ", ":\\ ")
        fillchars_escaped_thicc_pipes = fillchars_escaped_spaces:gsub(":│", [[:\│]])
        fillchars_escaped_thin_pipes = fillchars_escaped_thicc_pipes:gsub(":|", [[:\|]])
        final_fillchars = fillchars_escaped_thin_pipes
    end

    fillchars_stored = true
end

function M.restore_fillchars()
    if (fillchars_stored == true) then
        cmd("set fillchars=" .. final_fillchars .. "")
    end
end

return M
