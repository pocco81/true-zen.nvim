local opts = require("true-zen.config").options
local integrations_path = "true-zen.services.integrations."

local api = vim.api

-- NOTE: This doesn't load every singlep integration, it just laods the ones taht are needed
-- for the Ataraxis mode.

local M = {}

function M.get_line_with_integration()
	return has_line_with_integration
end

function M.set_has_line_with_integration(value)
	has_line_with_integration = value
end

local function require_element(element, type)
	if (type == "enable") then
		require(integrations_path..element).enable_element()
	else
		require(integrations_path..element).disable_element()
	end
end

function M.load_integrations()
    for integration, _ in pairs(opts["integrations"]) do
        if (opts["integrations"][integration] == true) then

			if (integration == "galaxyline" or integration == "vim_airline" or integration == "vim_powerline" or integration == "express_line") then
				M.set_has_line_with_integration(true)
				if (integration == "galaxyline" or integration == "express_line") then
					require_element(integration, "enable")
				else
					if (integration == "vim_airline") then
						if (api.nvim_eval("exists('#airline')") == 0) then -- is not running
							require_element(integration, "enable")
						end
					else
						if (api.nvim_eval("exists('#PowerlineMain')") == 0) then -- is not running
							require("true-zen.services.bottom.integrations.integration_vim_powerline").enable_element()
						end
					end
				end
			elseif (integration == "vim_gitgutter") then
                if (api.nvim_eval("get(g:, 'gitgutter_enabled', 0)") == 0) then
					require_element(integration, "enable")
                end
			elseif (integration == "vim_signify") then
                if (api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))") == 0) then -- is not running
					require_element(integration, "enable")
                end
			elseif (integration == "tmux") then
                if (api.nvim_eval("$TMUX") ~= "") then -- is running
					require_element(integration, "enable")
                end
			elseif (integration == "gitsigns") then
                local gs_integration = require("true-zen.services.integrations.gitsigns")
                local gs_config = require("gitsigns")._get_config()

                if (gs_ps_current_line_blame == nil) then
                    gs_integration.toggle_element(0)
                end

                if (gs_ps_numhl == nil) then
                    gs_integration.toggle_element(1)
                end

                if (gs_ps_linehl == nil) then
                    gs_integration.toggle_element(2)
                end

                if (gs_ps_signs == nil) then
                    gs_integration.toggle_element(3)
                end
			end

			if (true) then
            elseif (opt == "integration_limelight") then
                require("true-zen.services.bottom.integrations.integration_limelight").disable_element()

                has_statusline_with_integration = true
            elseif (opt == "integration_gitsigns") then
            end
        end
    end
end

function M.unload_integrations()
    for opt, _ in pairs(opts["integrations"]) do
        if (opts["integrations"][opt] == true) then
            if (opt == "integration_galaxyline") then
                require("true-zen.services.bottom.integrations.integration_galaxyline").disable_element()

                has_statusline_with_integration = true
            elseif (opt == "integration_gitgutter") then
                local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

                if (is_gitgutter_running == 1) then -- is running
                    require("true-zen.services.bottom.integrations.integration_gitgutter").disable_element()
                elseif (is_gitgutter_running == 0) then -- is not running
                -- nothing
                end
            elseif (opt == "integration_vim_signify") then
                local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

                if (is_vim_signify_running == 1) then -- is running
                    require("true-zen.services.bottom.integrations.integration_vim_signify").disable_element()
                elseif (is_vim_signify_running == 0) then -- is not running
                -- nothing
                end
            elseif (opt == "integration_tmux") then
                local is_tmux_running = vim.api.nvim_eval("$TMUX")

                if (is_tmux_running ~= "") then
                    require("true-zen.services.bottom.integrations.integration_tmux").disable_element()
                end
            elseif (opt == "integration_vim_airline") then
                local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

                if (is_vim_airline_running == 1) then -- is running
                    require("true-zen.services.bottom.integrations.integration_vim_airline").disable_element()
                elseif (is_vim_airline_running == 0) then -- is not running
                -- nothing
                end

                has_statusline_with_integration = true
            elseif (opt == "integration_vim_powerline") then
                local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

                if (is_vim_powerline_running == 1) then -- is running
                    require("true-zen.services.bottom.integrations.integration_vim_powerline").disable_element()
                elseif (is_vim_powerline_running == 0) then -- is not running
                -- nothing
                end

                has_statusline_with_integration = true
            elseif (opt == "integration_express_line") then
                require("true-zen.services.bottom.integrations.integration_express_line").disable_element()

                has_statusline_with_integration = true
            elseif (opt == "integration_limelight") then
                require("true-zen.services.bottom.integrations.integration_limelight").enable_element()

                has_statusline_with_integration = true
            elseif (opt == "integration_gitsigns") then
                local gs_integration = require("true-zen.services.bottom.integrations.integration_gitsigns")
                local gs_config = require("gitsigns")._get_config()

                gs_ps_current_line_blame = nil
                gs_ps_numhl = nil
                gs_ps_linehl = nil
                gs_ps_signs = nil

                if (gs_config.current_line_blame == true) then
                    gs_integration.toggle_element(0)
                else
                    gs_ps_current_line_blame = false
                end

                if (gs_config.numhl == true) then
                    gs_integration.toggle_element(1)
                else
                    gs_ps_numhl = false
                end

                if (gs_config.linehl == true) then
                    gs_integration.toggle_element(2)
                else
                    gs_ps_linehl = false
                end

                if (gs_config.signs == true) then
                    gs_integration.toggle_element(3)
                else
                    gs_ps_signs = false
                end
            end
        end
    end
end

return M
