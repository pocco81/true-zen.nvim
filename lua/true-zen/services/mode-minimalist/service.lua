local bottom = require("true-zen.services.bottom.init")
local top = require("true-zen.services.top.init")
local left = require("true-zen.services.left.init")

-- bottom specific options

function minimalist_true(minimalist_show) -- show
    bottom.main(1, minimalist_show)
    top.main(1, minimalist_show)
    left.main(1, minimalist_show)
end

function minimalist_false(minimalist_show) -- don't show
    bottom.main(2, minimalist_show)
    top.main(2, minimalist_show)
    left.main(2, minimalist_show)
end

return {
    minimalist_true = minimalist_true,
    minimalist_false = minimalist_false
}
