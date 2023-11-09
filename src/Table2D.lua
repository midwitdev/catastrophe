return function (content)
    local T = {"table", {{"class", "table table-bordered"}}, {}}

    local theadRow = {"tr", {}, {}}
    for _, e in pairs(content[1]) do
        theadRow[3][#theadRow[3]+1] = {"th", {}, e}
    end
    T[3][#T[3]+1] = {"thead", {}, {theadRow}}

    for i = 2, #content do
        local arr = content[i]

        local row = {"tr", {}, {}}

        row[3][1] = {"th", {}, arr[1]}

        for i = 2, #arr do
            local e = arr[i]
            row[3][#row[3]+1] = {"td", {}, e}
        end
        T[3][#T[3]+1] = row
    end

    return T
end