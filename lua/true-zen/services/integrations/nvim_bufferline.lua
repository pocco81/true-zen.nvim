local M = {}

function M.run()
    nvim_bufferline()
end

function M.enable_element()
    if (require("bufferline.config").get("options")["always_show_bufferline"] == false) then
        if (vim.api.nvim_eval([[len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))]]) > 1) then
            vim.cmd("set showtabline=2")
        end
    end
end

return M
