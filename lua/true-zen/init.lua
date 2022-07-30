local M = {}

function M.ataraxis()
	require("true-zen.ataraxis").toggle()
end

function M.minimalist()
	require("true-zen.minimalist").toggle()
end

function M.focus()
	require("true-zen.focus").toggle()
end

function M.narrow(line1, line2)
	require("true-zen.narrow").toggle(line1, line2)
end

function M.setup(custom_opts)
	require("true-zen.config").set_options(custom_opts)
end

return M
