local BottomCaption = require "BottomCaption"

return function(caption, content)
    local r = BottomCaption(content, caption)

    local content = r[3][1]
    local caption= r[3][2]

    -- swap them
    r[3][2] = content
    r[3][1] = caption

    return r
end