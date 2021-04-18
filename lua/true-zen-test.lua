

local cmd = vim.cmd

function setup()
	cmd("echo 'TrueZen was setup'")
	-- require("config").set_options(custom_opts)
	-- if (opts.true_false_commands == true) then
	-- 	cmd("command! TZStatuslineT lua main(0, 1)")
	-- 	cmd("command! TZStatuslineF lua main(0, 2)")
	-- else
	-- 	-- do nothing
	-- end
end


return {
	setup = setup
}
