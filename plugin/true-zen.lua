if vim.g.loaded_true_zen then
  return
end
vim.g.loaded_true_zen = true

local command = vim.api.nvim_create_user_command

command("TZAtaraxis", function()
	require("true-zen").ataraxis()
end, {})

command("TZFocus", function()
	require("true-zen").focus()
end, {})

command("TZMinimalist", function()
	require("true-zen").minimalist()
end, {})

command("TZNarrow", function(...)
	local args = {...}
	local line1 = args[1]["line1"]
	local line2 = args[1]["line2"]

	require("true-zen").narrow(line1, line2)
end, { range = true, bar = true })
