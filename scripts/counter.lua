-- Improved dynamic request script with changing path and header

-- Initialize the counter
local counter = 0

-- Function to generate requests with changing path and header
local function generateRequest()
    local path = "/" .. counter
    local headers = {
        ["X-Counter"] = counter
    }
    counter = counter + 1
    return wrk.format(nil, path, headers)
end

-- Define the request function
request = function()
    return generateRequest()
end
