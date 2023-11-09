--[[
<div class="container mt-5">
    <div class="alert alert-info" role="alert">
        <h4 class="alert-heading">Info Box</h4>
        <p>This is an example of a Bootstrap info box. You can use it to display informational messages or notices.</p>
    </div>
</div>
]]

local HTML = require "HTML"

local PasswordGen = require "PasswordGen"

local Infobox = require "Infobox"
local TwoColumn = require "TwoColumn"
local TwoRow = require "TwoRow"
local Table2D = require "Table2D"

function imap(tb, fn)
    local n = {}
    for _, v in pairs(tb) do
        n[#n + 1] = fn(v)
    end
    return n
end

function doeach(tb, fn)
    for k, v in pairs(tb) do
        fn(k, v)
    end
end

local DARK_THEME =
{
    { "body", {
        { "background-color", "#000" },
        { "color",            "#fff" },
    } },

    { "table tr td", {
        { "background-color", "#222" },
        { "color",            "#fff" },
        { "font-family",      "Mono" }
    } },

    { "table tr th", {
        { "background-color", "#333" },
        { "color",            "#f22" },
    } },

    { "a", {
        { "color", "#66c2ff" },
    } },
}

local function createDoc(TITLE, CONTENT, THEME)
    TITLE = TITLE or "Untitled Site"
    local STYLE = nil

    if THEME then
        STYLE = { "style", {}, THEME }
    end

    local numbers = {}

    for i = 1, 9, 1 do
        numbers[i] = {}
        for j = 1, 9, 1 do
            numbers[i][j] = string.format("%d * %d = %d", i, j, i * j)
        end
    end

    local mulTable = Table2D(numbers)

    local passwords = {{"#", "Password", "Length"}}

    for i = #passwords + 1, 85 + (#passwords + 1), 1 do
        passwords[i] = { i, PasswordGen(64), 64 }
    end

    local html_doc =
    { "html", nil, {
        { "head", nil, {
            { "script", { { "src", "https://code.jquery.com/jquery-3.5.1.slim.min.js" } },                         {} },
            { "script", { { "src", "https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" } }, {} },
            { "script", { { "src", "https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" } },   {} },

            { "meta", {
                { "charset", "UTF-8" }
            } },

            { "meta", {
                { "name",    "viewport" },
                { "content", "width=device-width, initial-scale=1.0" }
            } },

            { "link", {
                { "rel",  "stylesheet" },
                { "href", "https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" }
            } },

            STYLE,

            { "title", nil, TITLE }
        } },
        { "body", {}, {
            { "h1", { { "class", "text-center" } },           TITLE },
            { "h3", { { "class", "display-5 text-center" } }, CONTENT.Subtitle or "Subtitle" },
            { 'hr' },
            { "div", { { "class", "container-fluid row" } }, {
                TwoColumn(
                    {
                        TwoRow({
                            Table2D(
                                {
                                    { "",                              "Job",        "Salary",                      "Rating", "Experience" }, -- header
                                    { { { "strong", {}, "Andrew" } },  "Programmer", 82500 + math.random() * 10000, 9.5,      "10 years" },
                                    { { { "strong", {}, "John" } },    "Programmer", 78000 + math.random() * 10000, 8.0,      "7 years" },
                                    { { { "strong", {}, "Steve" } },   "Programmer", 80000 + math.random() * 10000, 9.5,      "8 years" },
                                    { { { "strong", {}, "Zane" } },    "Programmer", 85000 + math.random() * 10000, 10.0,     "9 years" },
                                    { { { "strong", {}, "Michael" } }, "Programmer", 70000 + math.random() * 10000, 7.5,      "8 years" },
                                }
                            ),
                            { "div", { { "class", "text-center container-fluid" } }, {
                                { "h4", { { "class", "display-8" } },  "Job Board" },
                                { "h6", { { "class", "display-10" } }, "Overview of Employees" }
                            } },
                        }),
                        TwoRow({
                            { "div", { { "class", "text-center container-fluid" } }, {
                                { "h4", { { "class", "display-8" } },  "Generated Passwords" },
                                { "h6", { { "class", "display-10" } }, "64 bytes" }
                            } },
                            Table2D(
                                passwords
                            )
                        }),
                    })
            } }
        } },
    } }
    return html_doc
end

local T = createDoc("Table Demo", {}, DARK_THEME)

print(HTML.WriteElement(T))
