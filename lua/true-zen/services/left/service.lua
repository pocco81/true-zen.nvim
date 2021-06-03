local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- left specific options
-- set number
-- set relativenumber
-- set signcolumn=no

function left_true() -- show
    cmd_settings.map_settings(opts["left"], true, "LEFT")
end

function left_false() -- hide
    cmd_settings.map_settings(opts["left"], false, "LEFT")
end

return {
    left_true = left_true,
    left_false = left_false
}
