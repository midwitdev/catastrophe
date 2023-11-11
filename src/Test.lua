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
local TopCaption = require "TopCaption"
local Tree = require "Tree"

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

    { "table .lua-number", {
        { "background-color", "#222" },
        { "color",            "#a22" },
        { "font-family",      "Mono" }
    } },

    { "table .lua-string", {
        { "background-color", "#222" },
        { "color",            "#82a" },
        { "font-family",      "Mono" }
    } },

    { "table tr th", {
        { "background-color", "#333 !important" },
        { "color",            "#28f !important" },
    } },

    { ".lua-invalid", {
        { "text-decoration", "line-through" },
        { "color",           "#666 !important" }
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
            { "h1", { { "class", "text-center" } }, TITLE or "Title" },
            { "h5", { { "class", "text-center" } }, CONTENT.Subtitle or "Subtitle" },
            { 'hr' },
            { "div", { { "class", "container d-flex justify-content-center align-items-center text-center" } },
                { CONTENT.Text }
            }
        } },
    } }
    return html_doc
end



--print(HTML.WriteElement(T))


local function parseInputToTable()
    local result = {}

    for line in io.lines() do
        if line == "" then break end
        local row = {}
        for value in line:gmatch("%S+") do
            table.insert(row, tonumber(value) or value)
        end
        table.insert(result, row)
    end

    return result
end

local function parseParagraphs()
    local result = {}

    local linebrct = 0
    for line in io.lines() do
        if line == "" then linebrct = linebrct + 1 end
        if linebrct == 2 then break end

        local paragraph = { "p", { { "class", "text-left" } }, HTML.Plaintext(line) }
        result[#result + 1] = paragraph
    end

    return { "div", {}, result }
end
-- Read the input and parse it into a 2D array
--local result = parseInputToTable()

local numbers = {}

for i = 1, 9, 1 do
    numbers[i] = {}
    for j = 1, 9, 1 do
        numbers[i][j] = string.format("%d * %d = %d", i, j, i * j)
    end
end

local mulTable = Table2D(numbers)

local passwords = { { "#", "Password", "Length" } }

for i = #passwords + 1, 85 + (#passwords + 1), 1 do
    passwords[i] = { i, PasswordGen(64), 64 }
end

local result2 = Tree({
    Test = "Test",
    Thing = 15,
    More = {
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six"
    }
})

local T = createDoc("Demo", { Text = result2, Subtitle = "catastrophe ssg sample" }, DARK_THEME)

local result3 = Tree(
    T
)

local T2 = createDoc("Demo", { Text = result3, Subtitle = "catastrophe ssg sample" }, DARK_THEME)

print(HTML.WriteElement(
    T
))
