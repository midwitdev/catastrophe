-- Define the character sets
local uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local lowercase = "abcdefghijklmnopqrstuvwxyz"
local numbers = "0123456789"
local special_chars = "!@#$%^&*()"

-- Combine all character sets
local all_chars = uppercase .. lowercase .. numbers .. special_chars

-- Function to generate a random password
return function (length)
    local password = ""
    local charset_length = #all_chars

    for i = 1, length do
        local random_index = math.random(1, charset_length)
        password = password .. string.sub(all_chars, random_index, random_index)
    end

    return password
end