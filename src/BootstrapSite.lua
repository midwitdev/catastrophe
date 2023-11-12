local DARK_THEME =
{
    {".recursive-list", {
        {"list-style-type", "none"},
        {"padding-left", "0"},
    } },

    {".key", {
        {"font-weight", "bold"}
    } },

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

    { "table tr td", {
        { "vertical-align", "top" },
    } },

    { ".lua-invalid", {
        { "text-decoration", "line-through" },
        { "color",           "#666 !important" }
    } },

    { "a", {
        { "color", "#66c2ff" },
    } },
}

local function bootstrapSite(HEAD, BODY, STYLE)
    TITLE = TITLE or "Untitled Site"

    local html_head = {
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

        { "style", {}, STYLE or DARK_THEME },
    }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    for _,v in pairs(HEAD or {}) do
        html_head[#html_head+1] = v
    end

    local html_doc =
    { "html", nil, {
        { "head", nil,  html_head},
        { "body", {}, BODY },
    } }
    return html_doc
end

return bootstrapSite