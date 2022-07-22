local M = {}

function M.ataraxis()
	require("true_zen.ataraxis").toggle()
end

function M.minimalist()
	require("true_zen.minimalist").toggle()
end

function M.focus()
	require("true_zen.focus").toggle()
end

function M.narrow(line1, line2)
	require("true_zen.narrow").toggle(line1, line2)
end

function M.setup(custom_opts)
	require("true_zen.config").set_options(custom_opts)
end

return M
