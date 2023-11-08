local CSS = {}

local sample =
{
	{"body", {
		{"background-color", "#333"},
		{"color", "#fff"},
	}},

	{"a", {
		{"color", "#66c2ff"},
	}}
}

--[[
/* Dark mode styles */
body {
  background-color: #333; /* Dark background color */
  color: #fff; /* Light text color */
}

a {
  color: #66c2ff; /* Light link color */
}
--]]

function CSS.Write(tb)
	local str = ""
	for _, rule in pairs(tb) do
		str = str .. (rule[1] .. " {") .. '\n'
		for _,t in pairs(rule[2]) do
			str = str .. (string.format("\t%s: %s;", t[1], t[2])) .. '\n'
		end
		str = str .. ("}")
	end

	return str
end

CSS.Write(sample)

return CSS
