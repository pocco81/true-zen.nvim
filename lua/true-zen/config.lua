local config = {}

config.options = {
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 1,
			bottom_padding = 1,
			ideal_writing_area_width = 0,
			just_do_it_for_me = true,

			fillchars_configuration = false,
			keep_default_fold_fillchars = true,
			quit_untoggles_ataraxis = true,
			custome_bg = "",
			bg_configuration = false,
			affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		noclc = false,
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
}

function config.set_options(opts)
    opts = opts or {}

    for opt, _ in pairs(opts) do
        -- check if option exists in the config's table
        if (config.options[opt] ~= nil) then -- not nil
            -- chec if option is a table
            if (type(opts[opt]) == "table") then -- if table
                for inner_opt, _ in pairs(opts[opt]) do
                    -- table contains element by that key
                    if (config.options[opt][inner_opt] ~= nil) then -- not nil
                        config.options[opt][inner_opt] = opts[opt][inner_opt]
                    end
                end
			else
                config.options[opt] = opts[opt]
            end
        end
    end
end

return config
