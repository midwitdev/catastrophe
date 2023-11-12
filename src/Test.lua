--[[
<div class="container mt-5">
    <div class="alert alert-info" role="alert">
        <h4 class="alert-heading">Info Box</h4>
        <p>This is an example of a Bootstrap info box. You can use it to display informational messages or notices.</p>
    </div>
</div>
]]

local HTML = require "HTML"
local lfs = require "lfs"

local PasswordGen = require "PasswordGen"

local BootstrapSite = require "BootstrapSite"
local Infobox = require "Infobox"
local TwoColumn = require "TwoColumn"
local TwoRow = require "TwoRow"
local Table2D = require "Table2D"
local TopCaption = require "TopCaption"
local Tree = require "Tree"

function LS(directory)
    local results = {}
    for file in lfs.dir(directory) do
        if file ~= "." and file ~= ".." then
            local filePath = directory .. "/" .. file
            local attr = lfs.attributes(filePath)
            results[file] = attr
        end
    end

    return results
end

local dirs = LS(".") -- get directory information
local htmlContent = Tree(dirs) -- turn directory information into an HTML table

local T = BootstrapSite({}, {
    {"div", {{"class", "container"}}, {
        {"h3", {{"class", "text-center display-4"}}, "Sample Site"},
        htmlContent
    }},
})

print(HTML.WriteElement(
    T
))
