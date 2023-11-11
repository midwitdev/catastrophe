-- Tree.lua
-- Create a tree out of lua table, recursive

local function alphapairs(t)
    local keys = {}
    for key in pairs(t) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b)
        -- Compare numbers first
        if type(a) == "number" and type(b) ~= "number" then
            return true
        elseif type(a) ~= "number" and type(b) == "number" then
            return false
        end

        -- Compare alphabetically for non-numeric keys
        return a < b
    end)

    local i = 0
    local n = #keys

    return function()
        i = i + 1
        if i <= n then
            return keys[i], t[keys[i]]
        end
    end
end

local function f(tb)
    local T = { "tbody", { { "class", "table table-responsive table-bordered" } }, {} }
    for k, v in alphapairs(tb) do
        local r = { "tr", {}, {} }
        if type(k) ~= "table" then
            r[3][#r[3] + 1] = { "td", { { "style", "width:15%;" } }, k }
        else
            r[3][#r[3] + 1] = { "td", nil, { f(k) } }
        end

        if type(v) ~= "table" then
            r[3][#r[3] + 1] = { "td", nil, v }
        else
            r[3][#r[3] + 1] = { "td", nil, { f(v) } }
        end

        T[3][#T[3] + 1] = r
    end

    return { "table", {}, { T } }
end

return f
