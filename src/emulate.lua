local T = {
    {"Andrew",2,3,4},
    {"Jack",6,7,8}
}

local function f(n)
    local steps = 0
    for i = 1, n do
        steps = steps + i
    end
    return steps
end

local complexities = {"n", "f(n)", "n*n", "n*log(n)"}
local numbers = { complexities }
for i = 0, 100, 5 do
    local m = {}
    m[1] = i
    m[2] = f(i)
    m[3] = i^2
    m[4] = i*math.log(i)
    numbers[#numbers+1] = m
end


function map(tb, fn)
    local n = {}
    for k,v in pairs(tb) do
        n[k] = fn(v)
    end
    return n
end

map(numbers, function(x) map(x, function(y) io.write (y..'\t') end) print'' end)
print''
print("Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah Hello, world Blah")
print("Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 Test 2 ")