local CSS = {}

function CSS.Write(tb, tabLevel)
	local tabs = ""
	for i = 0, (tabLevel or 0) do
		tabs = tabs .. '\t'
	end
	local str = tabs
	for _, rule in pairs(tb) do
		str = str .. (rule[1] .. " {") .. '\n'
		for _,v in pairs(rule[2]) do
			str = str .. (string.format("\t%s: %s;", v[1], v[2])) .. '\n'
		end
		str = str .. ("}")
	end

	return str
end

return CSS
