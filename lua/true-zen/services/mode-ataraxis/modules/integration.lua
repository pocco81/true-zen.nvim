

local opts = require("true-zen.config").options
local cmd = vim.cmd



function load_integrations(state)

	state = state or false

	if (state == true) then

		for opt, _ in pairs(opts["integrations"]) do
			if (opts["integrations"][opt] == true) then
				if (opt == "integration_galaxyline") then
					require("true-zen.services.bottom.integrations.integration_galaxyline").enable_element()
					has_statusline_with_integration = true
				elseif (opt == "integration_gitgutter") then

					local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

					if (is_gitgutter_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_gitgutter").enable_element()
					elseif (is_gitgutter_running == 1) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_vim_signify") then


					local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

					if (is_vim_signify_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_signify").enable_element()
					elseif (is_vim_signify_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_tmux") then
				
					local is_tmux_running = vim.api.nvim_eval("$TMUX")

					if (is_tmux_running ~= "") then		-- is running
						require("true-zen.services.bottom.integrations.integration_tmux").enable_element()
					else
						-- tmux wasn't running
					end

				elseif (opt == "integration_vim_airline") then


					local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

					if (is_vim_airline_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_airline").enable_element()
					elseif (is_vim_airline_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_vim_powerline") then


					local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

					if (is_vim_powerline_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_powerline").enable_element()
					elseif (is_vim_powerline_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_express_line") then

					require("true-zen.services.bottom.integrations.integration_express_line").enable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_limelight") then

					require("true-zen.services.bottom.integrations.integration_limelight").disable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_gitsigns") then

					local gs_integration = require("true-zen.services.bottom.integrations.integration_gitsigns")
					local gs_config = require("gitsigns")._get_config()


					if (gs_ps_current_line_blame == nil) then
						gs_integration.toggle_element(0)
					else
						if (gs_ps_current_line_blame == false) then
							-- it's already false
						end
					end

					if (gs_ps_numhl == nil) then
						gs_integration.toggle_element(1)
					else
						if (gs_ps_current_line_blame == false) then
							-- it's already false
						end
					end

					if (gs_ps_linehl == nil) then
						gs_integration.toggle_element(2)
					else
						if (gs_ps_linehl == false) then
							-- it's already false
						end
					end

					if (gs_ps_signs == nil) then
						gs_integration.toggle_element(3)
					else
						if (gs_ps_signs == false) then
							-- it's already false
						end
					end

				else
					-- integration not recognized
				end
			else
				-- ignore it
			end
		end
	
	elseif (state == false) then
		
		for opt, _ in pairs(opts["integrations"]) do
			if (opts["integrations"][opt] == true) then
				if (opt == "integration_galaxyline") then

					require("true-zen.services.bottom.integrations.integration_galaxyline").disable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_gitgutter") then

					local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

					if (is_gitgutter_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_gitgutter").disable_element()
					elseif (is_gitgutter_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_vim_signify") then

					local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

					if (is_vim_signify_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_signify").disable_element()
					elseif (is_vim_signify_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_tmux") then

					local is_tmux_running = vim.api.nvim_eval("$TMUX")

					if (is_tmux_running ~= "") then
						require("true-zen.services.bottom.integrations.integration_tmux").disable_element()
					else
						-- tmux wasn't running
					end


				elseif (opt == "integration_vim_airline") then

					local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

					if (is_vim_airline_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_airline").disable_element()
					elseif (is_vim_airline_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_vim_powerline") then

					local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

					if (is_vim_powerline_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_powerline").disable_element()
					elseif (is_vim_powerline_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
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

				else
					-- integration not recognized
				end
			else
				-- ignore it
			end
		end

	end
	
end


return {
	load_integrations = load_integrations,
	has_statusline_with_integration = has_statusline_with_integration
}
