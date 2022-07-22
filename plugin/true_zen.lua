if vim.g.loaded_true_zen then
  return
end
vim.g.loaded_true_zen = true

local command = vim.api.nvim_create_user_command

command("TZZAtaraxis", function()
	require("true_zen").ataraxis()
end, {})

command("TZZFocus", function()
	require("true_zen").focus()
end, {})

command("TZZMinimalist", function()
	require("true_zen").minimalist()
end, {})

command("TZZNarrow", function(...)
	local args = {...}
	local line1 = args[1]["line1"]
	local line2 = args[1]["line2"]

	require("true_zen").narrow(line1, line2)
end, { range = true, bar = true })
