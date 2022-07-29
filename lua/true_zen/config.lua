local config = {}

config.options = {
	modes = {
		ataraxis = {
			shade = "dark",
			backdrop = 0,
			minimum_writing_area = {
				width = 70,
				height = 44
			},
			quit_untoggles = true,
			padding = {
				left = 52,
				right = 52,
				top = 0,
				bottom = 0,
			},
		},
		narrow = {
			run_ataraxis = false
		},
		minimalist = {
			ignored_buf_types = { "nofile" },
			options = {
				-- window = {
				--
				-- },
				-- global = {
					laststatus = 0,
					showcmd = false,
					showmode = false,
				-- }
				ruler = false,
				number = false,
				relativenumber = false,
				showtabline = 0,
				statusline = "",
				cmdheight = 1,
			}
		}
	},
	integrations = {
		tmux = true, -- hide tmux status bar
	},
}
function config.set_options(opts)
	opts = opts or {}
	config.options = vim.tbl_deep_extend("keep", opts, config.options)
end

return config
