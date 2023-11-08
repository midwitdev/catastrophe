--[[
<div class="container mt-5">
    <div class="alert alert-info" role="alert">
        <h4 class="alert-heading">Info Box</h4>
        <p>This is an example of a Bootstrap info box. You can use it to display informational messages or notices.</p>
    </div>
</div>
]]

local HTML = require "HTML"

local Infobox = require "Infobox"
local TwoColumn = require "TwoColumn"

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
            STYLE,

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

            { "title", nil, TITLE }
        } },
        { "body", {}, {
            { "h1", {},                           TITLE },
            { "h3", { { "class", "display-5" } }, CONTENT.Subtitle or "Subtitle" },
            { 'hr' },
            { "div", { { "class", "container row" } }, {
                TwoColumn({ 
                    {"span", nil, "Lol1"}, {"span", nil, "Lol2"},
                    {"span", nil, "Lol3"}, {"span", nil, "Lol4"},
                    {"span", nil, "Lol5"}, {"span", nil, "Lol6"},
                    {"span", nil, "Lol7"}, {"span", nil, "Lol8"},
                    {"span", nil, "Lol9"}, {"span", nil, "Lol10"},
                })
            } }
        } },
    } }
    return html_doc
end

local T = createDoc("Infobox Test", {
    Body1 = Infobox("Test1", "This is a test!"),
    Body2 = { "p", nil, "Some content" }
})

print(HTML.WriteElement(T))
