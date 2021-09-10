local opts = require("true-zen.config").options
local integrations_path = "true-zen.services.integrations."
local integrations_loader = require("true-zen.services.integrations.modules.integrations_loader")
local api = vim.api

local M = {}

-- this are intagrations that must be loadede BEFORE Ataraxis mode does its magic

function M.require_element(element, type)
	if (type == "enable") then
		require(integrations_path .. element).enable_element()
	else
		require(integrations_path .. element).disable_element()
	end
end

function M.load_integrations()
	if (opts["integrations"]["galaxyline"] == true) then
		integrations_loader.set_has_line_with_integration(true)
		api.nvim_exec([[
				augroup truezen_integration_galaxyline
					autocmd!
				augroup END
		]], false)

		M.require_element("galaxyline", "enable")
	end
end

function M.unload_integrations()
	if (opts["integrations"]["galaxyline"] == true) then
		api.nvim_exec(
			[[
				augroup truezen_integration_galaxyline
					autocmd!
					autocmd WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.integrations.modules.integrations_loader'.require_element('galaxyline', 'disable')" | endif
				augroup END
		]],
			false
		)

		M.require_element("galaxyline", "disable")
	end
end

return M
