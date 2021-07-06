local opts = require("true-zen.config").options
local integrations_path = "true-zen.services.integrations."

local api = vim.api
local cmd = vim.cmd

local has_line_with_integration

-- NOTE: This doesn't load every single integration, it just laods the ones taht are needed
-- for the Ataraxis mode.

local M = {}

function M.get_line_with_integration()
    return has_line_with_integration
end

function M.set_has_line_with_integration(value)
    has_line_with_integration = value
end

function M.get_has_line_with_integration()
    return has_line_with_integration
end

function M.require_element(element, type)
    if (type == "enable") then
        require(integrations_path .. element).enable_element()
    else
        require(integrations_path .. element).disable_element()
    end
end

function M.load_integrations()
    for integration, _ in pairs(opts["integrations"]) do
        if (integration == "nvim_bufferline" or integration == "galaxyline") then
            goto continue
        end

        if (opts["integrations"][integration] == true) then
            if
                (integration == "vim_airline" or integration == "vim_powerline" or integration == "express_line" or
                    integration == "lualine")
             then
                M.set_has_line_with_integration(true)
                if (integration == "vim_airline") then
                    if (api.nvim_eval("exists('#airline')") == 0) then
                        M.require_element(integration, "enable")
                    end
                elseif (integration == "vim_powerline") then
                    if (api.nvim_eval("exists('#PowerlineMain')") == 0) then
                        M.require_element(integration, "enable")
                    end
                else -- lualine, express_line
                    M.require_element(integration, "enable")
                end
            elseif (integration == "vim_gitgutter") then
                if (api.nvim_eval("get(g:, 'gitgutter_enabled', 0)") == 0) then
                    M.require_element(integration, "enable")
                end
            elseif (integration == "vim_signify") then
                if (api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))") == 0) then
                    M.require_element(integration, "enable")
                end
            elseif (integration == "tmux") then
                if (api.nvim_eval("$TMUX") ~= "") then
                    M.require_element(integration, "enable")
                end
            elseif (integration == "limelight") then
                M.require_element(integration, "disable")
            else -- gitsigns,
                M.require_element(integration, "enable")
            end
        end

        ::continue::
    end
end

function M.unload_integrations()
    for integration, _ in pairs(opts["integrations"]) do
        if (integration == "nvim_bufferline" or integration == "galaxyline") then
            goto continue
        end

        if (opts["integrations"][integration] == true) then
            if
                (integration == "vim_airline" or integration == "vim_powerline" or integration == "express_line" or
                    integration == "lualine")
             then
                M.set_has_line_with_integration(true)
                if (integration == "vim_airline") then
                    if (api.nvim_eval("exists('#airline')") == 1) then
                        M.require_element(integration, "disable")
                    end
                elseif (integration == "vim_powerline") then
                    if (api.nvim_eval("exists('#PowerlineMain')") == 1) then
                        M.require_element(integration, "disable")
                    end
                else -- lualine, express_line
                    M.require_element(integration, "disable")
                end
            elseif (integration == "vim_gitgutter") then
                if (api.nvim_eval("get(g:, 'gitgutter_enabled', 0)") == 1) then
                    M.require_element(integration, "disable")
                end
            elseif (integration == "vim_signify") then
                if (api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))") == 1) then
                    M.require_element(integration, "disable")
                end
            elseif (integration == "tmux") then
                if (api.nvim_eval("$TMUX") ~= "") then
                    M.require_element(integration, "disable")
                end
            elseif (integration == "limelight") then
                M.require_element(integration, "enable")
            else -- gitsigns
                M.require_element(integration, "disable")
            end
        end

        ::continue::
    end
end

return M
