-- Columns.lua
-- Split a list of table exprs by odd/even into two columns
return function (T)
    local t1 = {}
    local t2 = {}

    for i, v in ipairs(T) do
        if i%2 == 1 then
            t1[#t1+1]=v
            t1[#t1+1]={"br"}
        else
            t2[#t2+1]=v
            t2[#t2+1]={"br"}
        end
    end

    return { "div", {{"class", "container-fluid row lua-twocolumn"}}, {
        { "div", {{"class", "col"}}, t1},
        { "div", {{"class", "col"}}, t2}
    }}
end