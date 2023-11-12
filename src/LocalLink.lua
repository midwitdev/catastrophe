local curl = require("cURL")


return {
    JS = function(link)
        local response_data = "" -- Initialize an empty string to store the response data

        -- HTTP Get
        curl.easy {
            url = "https://code.jquery.com/jquery-3.5.1.slim.min.js",
            httpheader = {},
            writefunction = function(chunk)
                response_data = response_data .. chunk
                return #chunk -- Return the number of bytes processed
            end
        }:perform():close()

        return { "script", {{"class", "lua-locallink"}}, response_data }
    end
}
