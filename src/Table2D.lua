return function (content, dontMarqueesX, dontMarqueesY)
    local T = {"table", {{"class", "table table-bordered"}}, {}}

    local start = 1

    if not dontMarqueesX then
        local theadRow = {"tr", {}, {}}
        for _, e in pairs(content[1]) do
            theadRow[3][#theadRow[3]+1] = {"th", {}, e}
        end
        T[3][#T[3]+1] = {"thead", {}, {theadRow}}

        start = 2
    end

    for i = start, #content do
        local arr = content[i]

        local row = {"tr", {}, {}}

        local start = 1

        if not dontMarqueesY then
            row[3][1] = {"th", {}, arr[1]}
            start = 2
        end

        for i = 1, #arr do
            local e = arr[i]
            row[3][#row[3]+1] = {"td", {}, e}
        end
        T[3][#T[3]+1] = row
    end

    return T
end