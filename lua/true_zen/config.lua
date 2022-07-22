local config = {}

config.options = {
	modes = {
		ataraxis = {
			shade = "dark",
			backdrop = 0.05,
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
		}
	},
	integrations = {
		tmux = true,
	},
}
function config.set_options(opts)
	opts = opts or {}
	config.options = vim.tbl_deep_extend("keep", opts, config.options)
end

return config
