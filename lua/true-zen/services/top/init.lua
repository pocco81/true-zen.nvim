local service = require("true-zen.services.top.service")
local cmd = vim.cmd

-- show and hide top funcs
local function top_true()
    top_show = 1
    service.top_true()
end

local function top_false()
    top_show = 0
    service.top_false()
end

local function toggle()
    top_show = vim.api.nvim_eval("&showtabline > 0")
    if (top_show == 1) then -- status line true, shown; thus, hide
        top_false()
    elseif (top_show == 0) then -- status line false, hidden; thus, show
        top_true()
    else
        -- nothing
    end
end

function resume()
    if (top_show == 1) then -- status line true; shown
        -- cmd("echo 'I was set to true so I am turning status line on'")
        top_true()
    elseif (top_show == 0) then -- status line false; hidden
        -- cmd("echo 'I was set to false so I am turning status line off'")
        top_false()
    elseif (top_show == nil) then -- show var is nil
        -- cmd("echo 'I was not set to anything so I am nil'")
        top_show = vim.api.nvim_eval("&showtabline > 0")
    else
        -- nothing
        cmd("echo 'none of the above'")
    end
end

function main(option)
    option = option or 0

    if (option == 0) then -- toggle statuline (on/off)
        toggle()
    elseif (option == 1) then -- show status line
        top_true()
    elseif (option == 2) then
        top_false()
    else
        -- not recognized
    end
end

-- vim.api.nvim_exec([[
-- 	augroup toggle_statusline
-- 		autocmd!
-- 		autocmd VimResume,FocusGained * lua resume()
-- 	augroup END
-- ]], false)

return {
    main = main,
    resume = resume,
    top_show = top_show
}
