-- Columns.lua
-- Split a list of table exprs by odd/even into two columns

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

    local leftClass = "mx-auto col"

    if LC then
        leftClass = leftClass .. "-" .. math.floor(LC)
    end

    local e1 = { "div", { { "class", leftClass} }, t1 }
    local e2 = nil

    if t2 then
        e2 = { "div", { { "class", "col mx-auto"} }, t2 }
    end

    return
    { "div", { { "class", "mx-auto container-fluid row text-center lua-twocolumn" } },
        {
            e1,
            e2
        }
    }
end
