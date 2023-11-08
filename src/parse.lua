-- Open the file for reading
local HTML = require "HTML"
local file = io.open("test.syn1", "r")

function parseLine()

end

print(parseLine("test"))

function trimStart(input)
    return input:match("^%s*(.-)$")
end

function trimEnd(input)
    return input:match("^(.-)%s*$")
end

function getUntilWS(input)
    local nonWhitespace, whitespace, rest = input:match("(%S+)(%s+)(.*)")
    return nonWhitespace, whitespace, rest
end

function parse(input)
    input = input:gsub("'\n", " ")

    local stack = {}
    local result = {}

    for word in input:gmatch("%S+") do
        if word == "{" then
            -- Opening brace, push a new table onto the stack
            table.insert(stack, {})
        elseif word == "}" then
            -- Closing brace, pop the top table from the stack
            local top = table.remove(stack)
            if #stack > 0 then
                -- If there's still a table on the stack, add the top table to it
                table.insert(stack[#stack], top)
            else
                -- If the stack is empty, the top table becomes the result
                result = top
            end
        else
            -- Regular word, add it to the top table
            table.insert(stack[#stack], word)
        end
    end

    return result
end

if not file then error("AUGHH!!!") end

local ast = parse(file:read("a"))

doeach(
    imap(
        ast,
        HTML.WriteElement
    ),
    function(_, v) print(v) end
)
