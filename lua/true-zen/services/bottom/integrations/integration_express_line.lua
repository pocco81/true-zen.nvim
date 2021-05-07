local M = {}


local api = vim.api



function M.enable_element()
	require('el').setup()
end

function M.disable_element()
	-- nothing
end



return M
