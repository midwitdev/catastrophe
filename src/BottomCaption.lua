return function(content, caption)
    return { "div", { { "class", "container" } }, {
        content,
        { "h4", { { "class", "container text-center" } }, caption or "Caption" },
    }}
end
