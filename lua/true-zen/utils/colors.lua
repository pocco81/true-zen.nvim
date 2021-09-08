local M = {}

-- original source: https://github.com/folke/zen-mode.nvim/blob/main/lua/zen-mode/util.lua

function M.hex2rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function M.rgb2hex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

function M.darken(hex, amount)
	local r, g, b = M.hex2rgb(hex)
	return M.rgb2hex(r * amount, g * amount, b * amount)
end

function M.get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not ok then
		return
	end
	for _, key in pairs({ "foreground", "background", "special" }) do
		if hl[key] then
			hl[key] = string.format("#%06x", hl[key])
		end
	end
	return hl
end

return M
