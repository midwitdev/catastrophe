-- TwoRow.lua
-- Split a list of table exprs by odd/even into two rows

local HTML = require "HTML"

return function(T, LC)
    local t1 = {}
    local t2 = {}

    for i, v in ipairs(T) do
        if i % 2 == 1 then
            t1[#t1 + 1] = v
            t1[#t1 + 1] = { "br" }
        else
            t2[#t2 + 1] = v
            t2[#t2 + 1] = { "br" }
        end
    end

    local leftClass = "row"

    if LC then
        leftClass = leftClass .. "-" .. math.floor(LC)
    end

    return
    { "div", { { "class", "container-fluid col lua-tworow" } },
        {
            { "div", { { "class", leftClass} }, t1 },
            { "div", { { "class", "row"} }, t2 }
        }
    }
end
