local service = require("true-zen.services.mode-ataraxis.service")

local cmd = vim.cmd
local api = vim.api
local opts = require("true-zen.config").options

-- show and hide ataraxis funcs
local function ataraxis_true()
    ataraxis_show = 1
    service.ataraxis_true()
end

local function ataraxis_false()
    ataraxis_show = 0
    service.ataraxis_false()

	if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
		if (opts["focus"]["focus_method"] == "experimental") then
			require("true-zen.services.bottom.integrations.integration_galaxyline").disable_element()
		end
	end
end

-- 1 if being shown
-- 0 if being hidden
local function toggle()
    if (ataraxis_show == 1) then -- ataraxis true, shown; thus, hide
        ataraxis_false()
    elseif (ataraxis_show == 0) then -- ataraxis false, hidden; thus, show
        ataraxis_true()
    elseif (ataraxis_show == nil) then
        ataraxis_show = 1
        ataraxis_false()
    else
        ataraxis_show = 1
        ataraxis_false()
    end
end

function main(option)
    option = option or 0

    if (option == 0) then -- toggle statuline (on/off)
        toggle()
    elseif (option == 1) then -- show status line
        ataraxis_true()
    elseif (option == 2) then
        ataraxis_false()
    else
        -- not recognized
    end
end

return {
    main = main,
    ataraxis_show = ataraxis_show
}
