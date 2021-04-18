

local config = {}


config.options = {
    true_false_commands = false
	-- setup_message = false
}

-- Default options
function config.set_options(opts)
    opts = opts or {}
    for opt, _ in pairs(config.options) do
        if opts[opt] ~= nil then
            config.options[opt] = opts[opt]
        end
    end
end


return config
