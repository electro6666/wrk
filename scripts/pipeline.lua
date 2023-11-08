-- Improved script for demonstrating HTTP pipelining

-- Function to generate HTTP requests
local function generateRequests()
    local requests = {}
    requests[1] = wrk.format(nil, "/?foo")
    requests[2] = wrk.format(nil, "/?bar")
    requests[3] = wrk.format(nil, "/?baz")
    return table.concat(requests)
end

-- Initialize the script
init = function(args)
    req = generateRequests()
end

-- Define the request function
request = function()
    return req
end
