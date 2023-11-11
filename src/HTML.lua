local HTML = {}
local CSS = {}

local TABCHAR = '\t'

function CSS.Write(tb, tabLevel)
	local tabs = ""
	for i = 0, (tabLevel or 0) do
		tabs = tabs .. '\t'
	end
	local str = tabs
	for _, rule in pairs(tb) do
		str = str .. (rule[1] .. " {") .. '\n'
		for _,v in pairs(rule[2]) do
			str = str .. (string.format("\t%s: %s;", v[1], v[2])) .. '\n'
		end
		str = str .. ("}")
	end

	return str
end

local function indentNewlines(input, tabLevel)
    tabLevel = tabLevel or 1
    local str = '\n'
    for i = 0, tabLevel do
        str = str .. TABCHAR
    end
    return input:gsub('\n', str)
end

local function ensureNewline(input)
    if not input:match('\n$') then
        return input .. '\n'
    else
        return input
    end
end

local function ensureSpace(input)
    if not input:match(' $') then
        return input .. ' '
    else
        return input
    end
end

function HTML.Plaintext(str)
    str = str:gsub("&", "&amp;")
    str = str:gsub("\"", "&quot;")
    str = str:gsub("<", "&lt;")
    str = str:gsub(">", "&gt;")
    str = ensureNewline(str):sub(1, -2) -- ensure no newline
    return str:gsub('\n', "<br>\n")
end

local function count(t)
    local i = 0
    for _, _ in pairs(t) do
        i = i + 1
    end
    return i
end

local function formatNumber(value)
    if value == math.floor(value) then
        return string.format("%.0f", value)
    else
        return string.format("%.2f", value)
    end
end

local ANNOTATE_CLASSES = true

function HTML.WriteElement(tb, tabLevel)
    tabLevel = tabLevel or 0
    local tabs = ""
    for i = 1, tabLevel do
        tabs = tabs .. TABCHAR
    end
    local str = tb[1]

    if ANNOTATE_CLASSES then
        local class = "lua-" .. type(tb[3])
        local classFound = false

        if tostring(tb[3]) == "nan" then
            class = ensureSpace(class) .. "lua-invalid"
        end

        if not tb[2] then tb[2] = {} end

        for i, v in pairs(tb[2]) do
            if v[1] == "class" then
                classFound = v
            end
        end

        if not classFound then
            local c = { "class", class }
            tb[2][#tb[2] + 1] = c
        else
            classFound[2] = ensureSpace(classFound[2]) .. class
        end
    end

    if type(tb[2]) == "table" then
        local attrs = ""
        local i = 0
        for _, v in pairs(tb[2]) do
            attrs = attrs .. string.format("%s=\"%s\" ", v[1], v[2])
            i = i + 1
        end

        attrs = attrs:sub(1, -2)
        if i > 0 then
            str = ensureSpace(str) .. attrs
        end
    end

    if type(tb[3]) == "string" or type(tb[3]) == "number" or type(tb[3]) == "boolean" then
        if type(tb[3]) == "number" then
            tb[3] = formatNumber(tb[3])
        end
        tb[3] = tostring(tb[3])

        local newlineCount = 0

        for char in tb[3]:gmatch('\n') do
            newlineCount = newlineCount + 1
        end

        str = tabs .. string.format("<%s>\n", str)
        str = ensureNewline(str):sub(1, -2)

        if newlineCount > 0 then
            str = str .. indentNewlines('\n' .. tb[3], tabLevel)

            str = ensureNewline(str)
            str = str .. string.format("%s</%s>", tabs, tb[1])
        else
            str = str .. tb[3]
            str = ensureNewline(str):sub(1, -2)
            str = str .. string.format("</%s>", tb[1])
        end
    elseif type(tb[3]) == "table" and tb[1] ~= "style" then
        str = tabs .. string.format("<%s>\n", str)
        for _, v in pairs(tb[3]) do
            str = str .. ensureNewline(HTML.WriteElement(v, tabLevel + 1))
        end

        if (count(tb[3]) > 0) then
            str = ensureNewline(str)
            str = str .. string.format("%s</%s>", tabs, tb[1])
        else
            str = ensureNewline(str):sub(1, -2)
            str = str .. string.format("</%s>", tb[1])
        end
    elseif type(tb[3]) == "table" and tb[1] == "style" then
        str = tabs .. string.format("<%s>\n", str)
        local cssContent = CSS.Write(tb[3])
        str = ensureNewline(str) .. tabs .. indentNewlines(cssContent, tabLevel)

        if (count(tb[3]) > 0) then
            str = ensureNewline(str)
            str = str .. string.format("%s</%s>", tabs, tb[1])
        else
            str = ensureNewline(str):sub(1, -2)
            str = str .. string.format("</%s>", tb[1])
        end
    elseif tb[3] == nil then
        str = string.format("%s<%s>", tabs, str)
    end

    return ensureNewline(str)
end

return HTML