local HTML = {}
local CSS = require "CSS"

local function indentNewlines(input, tabLevel)
    tabLevel = tabLevel or 1
    local str = '\n'
    for i = 0, tabLevel do
        str = str .. '\t'
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
    str = str:gsub("<", "&lt;")
    str = str:gsub(">", "&gt;")
    str = ensureNewline(str):sub(1,-2)
    return str:gsub('\n', "<br>\n")
end

local scripts = {

}

local stylesheet = 
{
	{"body", {
		{"background-color", "#333"},
		{"color", "#fff"},
	}},

	{"a", {
		{"color", "#66c2ff"},
	}}
}

local html_doc =
{
    {"!DOCTYPE html"},
    {"html", nil, {
        {"head", nil, {
            {"script", {src = "https://code.jquery.com/jquery-3.5.1.slim.min.js"}, {}},
            {"script", {src = "https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"}, {}},
            {"script", {src = "https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"}, {}},

            {"style", {},
                CSS.Write({
                    {"body", {
                        {"background-color", "#333"},
                        {"color", "#fff"},
                    }},
                
                    {"a", {
                        {"color", "#66c2ff"},
                    }}
                })
            },

            {"meta", {
                charset="UTF-8"
            }},

            {"meta", {
                name="viewport",
                content="width=device-width, initial-scale=1.0"
            }},

            {"link", {
                rel="stylesheet",
                href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            }},

            {"link", {
                rel="stylesheet",
                href="test.css"
            }},
            
            {"title", nil, "Hello World Site"}
        }},
        {"body", {}, {
            {"h1", {}, "Hello, world"},
            {'hr', {}},
            {"div", {class="container row"}, {
                {"div", {class="col"}, {
                    {"p", {},
                        HTML.Plaintext(
                        "Each line here\n"..
                        "Will automatically convert\n"..
                        "to a <br> tag\n")
                    }
                }},
                {"div", {class="col"}, {
                    {"p", {},
                        HTML.Plaintext(
                        "Each line here\n"..
                        "Will automatically convert\n"..
                        "to a <br> tag\n")
                    }
                }},
            }}
        }},
    }}
}

local function count(t)
    local i = 0
    for _,_ in pairs(t) do
        i = i + 1
    end
    return i
end

function HTML.WriteElement(tb, tabLevel)
    tabLevel = tabLevel or 0
    local tabs = ""
    for i = 1, tabLevel do
        tabs = tabs .. '\t'
    end
    local str = tb[1]

    if type(tb[2])=="table" then
        local attrs = ""
        local i = 0
        for k,v in pairs(tb[2]) do
            attrs = attrs .. string.format("%s=\"%s\"", k, v)
            i = i + 1
        end
        if i > 0 then
            str = ensureSpace(str) .. attrs
        end
    end

    if type(tb[3])=="string" then
        local newlineCount = 0

        for char in tb[3]:gmatch('\n') do
            newlineCount = newlineCount + 1
        end

        str = tabs .. ensureNewline(string.format("<%s>", str))
        str = ensureNewline(str):sub(1, -2)

        if newlineCount > 0 then
            str = str .. indentNewlines('\n'..tb[3], tabLevel)

            str = ensureNewline(str)
            str = str .. string.format("%s</%s>", tabs, tb[1])
        else
            str = str .. tb[3]
            str = ensureNewline(str):sub(1, -2)
            str = str .. string.format("</%s>", tb[1])
        end
    elseif type(tb[3])=="table" then
        str = tabs .. ensureNewline(string.format("<%s>", str))
        for _,v in pairs(tb[3]) do
            str = str .. ensureNewline(HTML.WriteElement(v, tabLevel + 1))
        end

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

    if tb[3] then
        
    else
        --str = str .. string.format("</%s>", tb[1])
    end

    return ensureNewline(str)
end

function imap(tb, fn)
    local n = {}
    for _,v in pairs(tb) do
        n[#n+1] = fn(v)
    end
    return n
end

function doeach(tb, fn)
    for k,v in pairs(tb) do
        fn(k,v)
    end
end

doeach(
    imap(
        html_doc,
        HTML.WriteElement
    ),
    function(_,v) print(v) end
)

return HTML