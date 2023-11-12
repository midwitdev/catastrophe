-- Tree.lua
-- Create a tree out of lua table, recursive

local function alphapairs(t)
    local keys = {}
    for key in pairs(t) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b)
        if type(a) == "number" and type(b) ~= "number" then
            return true
        elseif type(a) ~= "number" and type(b) == "number" then
            return false
        end

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

local NOBG = {"class","bg-transparent"}

local function count (t) 
    local c = 0
    for _,_ in pairs(t) do c = c + 1 end
    return c
end

local function f(tb)
    local T = { "tbody", {}, {} }
    for k, v in alphapairs(tb) do
        local r = { "tr", {}, {} }
        if type(k) ~= "table" then
            r[3][#r[3] + 1] = { "th", {}, k }
        else
            r[3][#r[3] + 1] = { "th", {}, {f(k)} }
        end

        if type(v) ~= "table" then
            r[3][#r[3] + 1] = { "td", {}, v }
        elseif count(v) <= 0 then
            r[3][#r[3] + 1] = { "td", {}, "{ empty }" }
        else
            r[3][#r[3] + 1] = { "td", {}, {f(v)} }
        end


        T[3][#T[3] + 1] = r
    end

    return { "table", {{"class", "table table-striped table-condensed table-bordered"}}, { T } }
end

return f