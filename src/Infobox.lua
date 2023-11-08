local HTML = require "HTML"

function Infobox(TITLE, INNER)
    return
    { "div", { { "class", "alert alert-info" }, { "role", "alert" } }, {
        { "h4", { { "class", "alert-heading" } },
            TITLE or "Untitled Infobox"
        },
        { "p", {},
            INNER or "[ No Content ]"
        }
    } }
end

return Infobox
