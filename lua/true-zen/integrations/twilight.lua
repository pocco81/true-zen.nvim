local M = {}

local status

function M.on()
	local present, twilight = pcall(require, "twilight")
	if not present then
		return
	end

	if require("twilight.view").enabled == false then
		twilight.enable()
		status = true
	end
end

function M.off()
	if status == true then
		require("twilight").disable()
	end
	status = nil
end

return M
